---

---
[https://martinfowler.com/articles/feature-toggles.html](https://martinfowler.com/articles/feature-toggles.html)

[https://learn.microsoft.com/en-us/devops/operate/progressive-experimentation-feature-flags](https://learn.microsoft.com/en-us/devops/operate/progressive-experimentation-feature-flags)

[https://github.com/microsoft/FeatureManagement-Dotnet](https://github.com/microsoft/FeatureManagement-Dotnet)

[https://code-maze.com/aspnetcore-feature-flags/](https://code-maze.com/aspnetcore-feature-flags/)

[https://timdeschryver.dev/blog/feature-flags-in-net-from-simple-to-more-advanced](https://timdeschryver.dev/blog/feature-flags-in-net-from-simple-to-more-advanced)

[https://featureflags.io/](https://featureflags.io/)

[https://martinfowler.com/articles/feature-toggles.html#CategoriesOfToggles](https://martinfowler.com/articles/feature-toggles.html#CategoriesOfToggles)

[https://www.boxuk.com/insight/coding-with-feature-flags/](https://www.boxuk.com/insight/coding-with-feature-flags/)

Dependências:

- Microsoft.FeatureManagement.AspNetCore
- [Microsoft.FeatureManagement.FeatureFilters](https://learn.microsoft.com/en-us/dotnet/api/microsoft.featuremanagement.featurefilters) ( to use filters)
    - [<u>AddFeatureFilters</u>](https://learn.microsoft.com/en-us/dotnet/api/microsoft.featuremanagement.ifeaturemanagementbuilder.addfeaturefilter)

Configurações:

Exemplo de uso através de Depenency Injection

using Microsoft.FeatureManagement;

public class HomeController : Controller

{

private readonly IFeatureManager _featureManager;

public HomeController(ILogger<HomeController> logger, IFeatureManager featureManager)

{

_featureManager = featureManager;

}

}

....

if (await featureManager.IsEnabledAsync(MyFeatureFlags.FeatureA))

{

// Run the following code

}

Exemplo de uso em Controller

NA CONTROLLER INTEIRA

[FeatureGate(MyFeatureFlags.FeatureA)]

public class HomeController : Controller

{

...

}

EM UM MÉTODO ESPECÍFICO

[FeatureGate(MyFeatureFlags.FeatureA)]

public IActionResult Index()

{

return View();

}