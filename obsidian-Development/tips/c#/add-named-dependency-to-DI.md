```
services.AddSingleton<Func<enum, GenericType>(x => name switch {
   item1 => x.GetRequiredService<DesiredType>(),
   item2 => x.GetRequiredService<DesiredType>(),
   itemN => x.GetRequiredService<DesiredType>(),
})
```

Practical example:

```
services.AddSingleton<Func<ApplicationPagesName, PageViewModel>(x => name switch {
   ApplicationPagesName.Home => x.GetRequiredService<HomePageViewModel>(),
   ApplicationPagesName.Process => x.GetRequiredService<ProcessPageViewModel>(),
   ApplicationPagesName.Macros => x.GetRequiredService<MacrosPageViewModel>(),
   ApplicationPagesName.Settings => x.GetRequiredService<SettingsPageViewModel>(),
})
```