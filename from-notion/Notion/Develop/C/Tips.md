---

---
## IOptions

### Startup

`services.Configure<OPTION_TYPE>(config => Configuration.Bind("app-settings-key", config));`

### Classe de extensão

**Parâmetro**

Action<OPTION_TYPE> option,

**Configuração**

```javascript
var optionValues = new OPTION_TYPE();

option(optionValues );

services.Configure(option??= new Action<option>(x => { }));
```

## EFCore

[https://blog.jetbrains.com/dotnet/2021/02/24/entity-framework-core-5-pitfalls-to-avoid-and-ideas-to-try/](https://blog.jetbrains.com/dotnet/2021/02/24/entity-framework-core-5-pitfalls-to-avoid-and-ideas-to-try/)

## Quartz.NET

[Using the CronTrigger | Quartz.NET (quartz-scheduler.net)](https://www.quartz-scheduler.net/documentation/quartz-3.x/how-tos/crontrigger.html#format)

[http://www.cronmaker.com/?0](http://www.cronmaker.com/?0)

## Consumo de memória

[Monitorando o consumo de memória e tempo de execução (linhadecodigo.com.br)](http://www.linhadecodigo.com.br/artigo/3077/monitorando-o-consumo-de-memoria-e-tempo-de-execucao.aspx)

**Analisar Memory Leack**

https://michaelscodingspot.com/find-fix-and-avoid-memory-leaks-in-c-net-8-best-practices/

https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer

https://docs.microsoft.com/en-us/visualstudio/profiling/dotnet-alloc-tool?view=vs-2019