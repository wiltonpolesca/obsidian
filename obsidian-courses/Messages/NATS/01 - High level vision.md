# High level vision from Copilot

Given your background with **ActiveMQ → RabbitMQ → Kafka/Redpanda**, I think the biggest mental shift is:

> 	**NATS is not a log platform first. It's a messaging fabric first. JetStream adds durability when needed.**

Kafka/Redpanda users often start by trying to model everything as a persistent log. With NATS, you'll usually get better results by treating durability as an exception rather than the default.

---

# NATS Architecture in One Picture

Think of NATS as two layers:
```
                    +----------------+
                    |   Wolverine    |
                    +----------------+
                            |
                            v

+------------------------------------------------+
|                    NATS                        |
|                                                |
|  Core NATS            JetStream                |
|  ---------            ----------               |
|  Ephemeral            Durable                  |
|  Ultra-fast           Persistence              |
|  Fire-and-forget      Replay                   |
|  Pub/Sub              Consumer state           |
+------------------------------------------------+
```

A common DDA/Event-Driven architecture is:

```
Commands     -> JetStream
Domain Events-> JetStream
Cache Events -> Core NATS
Metrics      -> Core NATS
Heartbeats   -> Core NATS
Notifications-> Core NATS
```

---

# Performance Expectations

NATS is generally one of the fastest brokers available.

Compared with Kafka:

| Capability             | Kafka / Redpanda | NATS Core    | NATS JetStream |
| ---------------------- | ---------------- | ------------ | -------------- |
| Latency                | Good             | Excellent    | Very Good      |
| Throughput             | Massive          | Massive      | High           |
| Durability             | Primary feature  | None         | Strong         |
| Replay                 | Native           | No           | Yes            |
| Consumer groups        | Native           | Queue Groups | Consumers      |
| Operational complexity | Medium           | Low          | Medium         |

For request/response microservices, CQRS handlers, and Wolverine message dispatching, NATS often feels much lighter than Kafka because there is no partition planning, broker tuning, or offset management for the majority of traffic.

---

# Wolverine + NATS

Wolverine fits NATS surprisingly well because both encourage:

- Message-driven systems
- Async handlers
- Command processing
- Local-first workflows
- Lightweight infrastructure

A typical mapping would be:

```
Application Command
    ↓
JetStream Subject

Command Handler
    ↓
Domain Event

Domain Event Subject
    ↓
Multiple Subscribers
```

Example:

```
sales.order.submit
sales.order.approved
sales.order.shipped
billing.invoice.created
```

Use **subjects as business language**.

Avoid Kafka-style topics such as:

```
orders-topic-v2
```

Prefer:

```
sales.order.
_sales.customer._  
inventory.product.*
```

Subject hierarchies are one of NATS's strongest features.

---

# Retention Strategies

This is where many newcomers make mistakes.

## 1. Commands

Example:

```
sales.order.submit
```

Recommended:

```
Retention: Work Queue  
Acknowledgements: Required
```

Reason:

A command should typically be processed by one consumer.

Think RabbitMQ queue semantics.

---

## 2. Domain Events

Example:

sales.order.approved  

``

Recommended:

Retention: Limits  

Replay: Enabled

Reason:

Multiple projections and services may need to consume the event.

Think Kafka topic semantics.

---

## 3. Notifications

Example:

```
user.online
```

Recommended:

```
Core NATS  
No persistence
```

Reason:

Nobody cares about yesterday's "user online" event.

---

## 4. Telemetry

Example:

```
telemetry.device.temperature
```

Recommended:

```
Core NATS  
or  
Short-lived JetStream
```

depending on business requirements.

---

# Retention Policies

JetStream has three major retention modes.

## LimitsPolicy

Most common.

Messages stay until:

- age limit reached
- size limit reached
- message count limit reached

Good for:

```
Domain Events  
Audit Events  
Integration Events
```

Example:

```
7 days retention  
100 GB max
```

---

## WorkQueuePolicy

Perfect for commands.

Messages disappear after successful consumption.

Good for:

```
Commands  
Background jobs  
Task queues
```

Example:

```
billing.generate-invoice  
inventory.recalculate-stock
```

---

## InterestPolicy

A message is removed once all interested consumers have acknowledged it.

Useful but rarely needed.

Good only when:

```
All subscribers must consume the event
```

Most teams use LimitsPolicy instead.

---

# My Recommended Setup

If I were building a Wolverine DDA system today:

### Commands

```
JetStream  
WorkQueuePolicy  
```

Retention:

```
24h-72h
```

Just enough for retries and recovery.

---

### Domain Events

```
JetStream  
LimitsPolicy
```

Retention:

```
7 days  
30 days  
90 days
```

depending on compliance needs.

This gives replay capability for rebuilding projections.

---

### Event-Sourced Systems

If events are your source of truth:

```
JetStream  
LimitsPolicy
```

with very long retention:

```
1 year+  
or unlimited
```

At that point JetStream starts looking more Kafka-like.

---

### Ephemeral Information

Use Core NATS:

```
health.
_heartbeat._  
presence.
_cache._  
metrics.*  
```

No persistence.
Maximum speed.

---

# Configuration Philosophy

For teams coming from Kafka, my biggest advice is:

### Don't put everything in JetStream

A lot of architectures become:

```
100%  
Kafka  
100%  
persistent  
```

With NATS, a healthier split is often:

```
70% Core NATS  
30% JetStream
```

or even

```
80% Core NATS  
20% JetStream 
```

Only persist messages that provide business value after they've been published.

---

# What I would choose for a Wolverine DDA project

```
Commands:
    JetStream + WorkQueuePolicy

Domain Events:
    JetStream + LimitsPolicy

Read Model Projections:
    Durable Consumers

Notifications:
    Core NATS

Heartbeat:
    Core NATS

Metrics:
    Core NATS

Saga/Workflow Messages:
    JetStream

Request/Response:
    Core NATS
```

That architecture usually provides RabbitMQ-like simplicity, Kafka-like replay where actually needed, and significantly lower operational overhead than a full Kafka/Redpanda deployment.