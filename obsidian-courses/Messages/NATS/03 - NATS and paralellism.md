# NATS handles this very differently from Kafka

The key thing to understand is:

> A NATS connection is not a single-threaded message processing pipeline.

A single TCP connection can carry many subscriptions simultaneously, and the server does not wait for one message handler to finish before sending the next message.

---

# RabbitMQ / ActiveMQ Mental Model

Many brokers historically look like:

```
Queue
  |
  +--> Consumer
         |
         +--> Message A (5s)
         +--> Message B (wait)
         +--> Message C (wait)
```

If your consumer concurrency is 1:

```
A  
B  
C  
```

becomes serialized.

The bottleneck is usually the consumer, not the broker.

---

# Kafka Mental Model

Kafka solves this with partitions:

```
Topic

Partition 0 -> Consumer #1
Partition 1 -> Consumer #2
Partition 2 -> Consumer #3
```

Ordering is guaranteed within each partition.

Parallelism comes from:

```
number_of_partitions
```

If you want more parallelism:

```
increase partitions
```

---

# NATS Mental Model

NATS subjects are not partitions.

Imagine:

```
sales.order.created
sales.order.updated
inventory.stock.changed
```

All of these can flow through the same connection.

Internally the connection is multiplexed.

```
                  One TCP Connection

                        |
                        V

+------------------------------------------------+
|                NATS Client                     |
+------------------------------------------------+
    |                |                 |
    V                V                 V

 Subscription A  Subscription B  Subscription C

 sales.order.*   inventory.*      billing.*
```

A long-running message in one subscription does not inherently block delivery on the others.

---

# Where You Can Still Create a Bottleneck

The important distinction:

```
Broker Concurrency  
!=  
Application Concurrency
```

You can completely kill throughput with:

```c#
await foreach(var msg in subscription.Messages.ReadAllAsync())
{
    await Process(msg);
}
```

because you've made the handler sequential.

Now:

```
Message 1 -> 5s  
Message 2 -> waits  
Message 3 -> waits
```

even though NATS itself could handle much more.

---

# JetStream Consumer Configuration

For JetStream, concurrency is generally created using:

```
Multiple message handlers  
Multiple service instances  
Queue consumers
```

rather than partitions.

Example:

```
orders.process
```

You run:

```
Instance A  
Instance B  
Instance C  
```

Each receives part of the workload.

Very similar to:

```
RabbitMQ competing consumers
```

---

# Queue Groups

This is one of the nicest NATS features.

Suppose:

```
command.order.submit
```

You have:

```
Worker 1  
Worker 2  
Worker 3
```

all joined to:

```
order-processors
```

queue group.
```
Publisher
    |
    V

command.order.submit
    |
    V

+-----------------------+
| Queue Group           |
+-----------------------+

Worker1
Worker2
Worker3
`
```


Messages automatically load-balance.

No partition management.

No queue sharding.

---

# What Happens If One Message Takes 30 Seconds?

Suppose:

```
Worker 1
```

gets:

```
Order #123
```

and processing takes:

```
30 seconds
```

NATS continues sending messages to:

```
Worker 2  
Worker 3
```

The entire system does not stop.

Only that worker is busy.

---

# But What About Ordering?

Here's the tradeoff.

Kafka gives:

```
Ordering within partition
```

NATS gives:

```
Subject ordering
```

but if you scale consumers:

```
Order A  
Order B  
Order C
```

may reach different workers.

So if strict ordering matters:

```
customer.123.*
```

you need to design for it.

NATS intentionally avoids Kafka's partitioning model.

---

# The Closest Equivalent to a Kafka Partition

You can model subject sharding yourself:

```
sales.order.0  
sales.order.1  
sales.order.2  
sales.order.3  
```

or

```
sales.customer.123  
sales.customer.456
```

and assign consumers accordingly.

But most NATS users don't.

The platform encourages horizontal consumers rather than partition engineering.

---

# With Wolverine Specifically

Wolverine already has concurrent execution facilities.

Instead of:

```
1 connection  
1 subscription  
1 handler
```

you'd typically configure endpoint concurrency.

Conceptually:

```
command.order.submit  

Concurrency = 32
```

Then:

```
Message 1 -> Handler #1  
Message 2 -> Handler #2  
Message 3 -> Handler #3
```

all inside the same process.

The broker is rarely the bottleneck.

**CPU, database, or external APIs usually become the bottleneck first.**

---

# The Surprising Thing for Kafka Engineers

Kafka engineers often ask:

> "How many partitions should I create?"

In NATS the equivalent question is usually:

> "How many consumers or service instances do I need?"

Because throughput is scaled by:

```
Consumers
```

rather than

```
Partitions
```

For a Wolverine application, a very common production setup is:

```
1 NATS connection

N subscriptions

M concurrent handlers

K service replicas
```



where:

- **1 connection** is normal.
- **M** controls local parallelism.
- **K** controls horizontal scaling.

So the answer to your concern is:

> A single NATS connection does not imply serial message processing. NATS multiplexes many subscriptions over one connection, and concurrency is typically achieved through concurrent handlers, queue groups, and multiple service instances rather than Kafka-style partitions.