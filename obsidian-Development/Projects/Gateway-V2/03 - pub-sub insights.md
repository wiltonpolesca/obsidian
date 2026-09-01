## Should I hide wolverine to avoid MediaR problems

That's actually a very valid concern.

I have the same concern whenever a framework becomes deeply embedded in the application model rather than remaining an infrastructure detail.

The MediatR story is a good example:

```
MediatR
    ↓
Becomes ubiquitous in the codebase
    ↓
Licensing changes
    ↓
Migration becomes expensive
```

The cost wasn't technical. The cost was architectural coupling.

---

## My Rule: Depend on Concepts, Not Frameworks

I generally classify frameworks into two categories:

### Infrastructure

```
NATS
RabbitMQ
Kafka
PostgreSQL
Redis
```

Easy to hide.

---

### Architectural

```
Wolverine
MediatR
MassTransit
Orleans
Akka.NET
```

Harder to hide because they influence how you write code.

---

## What Makes Wolverine Different?

Unlike MediatR, Wolverine tends to encourage:

```c#
public static Task Handle(SubmitOrder command)
```

instead of:

```c#
public class SubmitOrderHandler
    : IRequestHandler<SubmitOrder>
```

There's no inheritance.

No marker interfaces.

No attributes required.

That's actually a huge advantage.

---

## How I Would Future-Proof It

I'd avoid exposing:

```
IMessageBus
```

everywhere.

Instead, I'd create a very small boundary.

Example:

```c#
public interface IEventPublisher
{
    Task PublishAsync<T>(T evt);
}

public interface ICommandDispatcher
{
    Task SendAsync<T>(T command);
}
```

Internally:

```c#
public class WolverineEventPublisher
    : IEventPublisher
{
    private readonly IMessageBus _bus;

    public Task PublishAsync<T>(T evt)
        => _bus.PublishAsync(evt);
}
```

Now the application layer depends on:

```
IEventPublisher  
ICommandDispatcher
```

not Wolverine.

---

## But Don't Hide Handlers

This is where I'd draw the line.

I would **not** abstract:

```c#
public static Task Handle(SubmitOrder cmd)
```

because:

1. It's already plain C#.
2. No Wolverine dependency appears.
3. It is easy to migrate later.

If one day Wolverine disappears:

```c#
public static Task Handle(SubmitOrder cmd)
```

can be called by:

- MediatR
- MassTransit
- Rebus
- Custom dispatcher
- ASP.NET endpoint

with very little change.

---

## The Real Lock-In Risk

From my experience, the biggest lock-in is not:

```c#
Handle(message)
```


The biggest lock-in is:

```c#
await bus.PublishAsync(...)  
await bus.SendAsync(...)
```

because now Wolverine concepts are scattered everywhere.

---

## The Architecture I'd Build

```
Company.Messaging.Abstractions
│
├── ICommand
├── IEvent
├── ICommandDispatcher
└── IEventPublisher
```


```
Company.Messaging.Wolverine
│
├── Wolverine configuration
├── NATS integration
├── JetStream conventions
└── Adapter implementations
```

Application code:

```c#
public class OrderService
{
    private readonly IEventPublisher _events;

    public async Task Submit(...)
    {
        ...
        await _events.PublishAsync(
            new OrderCreated(...));
    }
}
```

The application knows:

```
Your abstractions
```

The infrastructure knows:

```
Wolverine  
NATS  
```

---

## My Honest Assessment

For Wolverine specifically, I'd rate the licensing risk as lower than MediatR because:

- It's open source.
- Its programming model is mostly plain C#.
- Handlers are not tightly coupled to framework interfaces.
- Business logic can remain in services and aggregates.

However, I'd still avoid letting `IMessageBus` spread throughout every module.

That gives you a nice middle ground:

- Hide NATS ✅  
- Hide Wolverine bus ✅  
- Keep handlers ✅  
- Keep business services ✅

If Wolverine were to disappear tomorrow, most of your migration effort would be concentrated in a single messaging package rather than across hundreds of handlers and services. That's generally the architecture I'd recommend to a senior engineer optimizing for long-term maintainability and framework independence.
