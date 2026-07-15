# New gateway UI using Avalonia UI

[  ] I18n
[  ] Componentization
[  ] Styles

### I18N

- JSON-based translations
- Microsoft Loacalization abstraction (IStringLocalizer)
- Avalonia Integration (MVVM)
- XAML Helper
- 

## Styles

```xml
<Application.Styles>
   <FluentTheme />
   <StyleIncludde Source="<<MY STYLES>>" /> <---  Add custom styles here
</Application.Styles>
```

### Resources

To define resources to be used

```xml
<Application.Resources>
<!-- Defines "PrimaryBackground" resouce key to be used by the project, avoiding hardcoded values, improves maintenability -->
	<SolidColorBrush x:Key="PrimaryBackground">#FFFFFF</SolidColorBrush>
</Application.Resources>
```

#### How to use

```xml
<Grid Background="DynamicResource ResourceKey=PrimaryBackground}" ColumnDefinitions="200, *">
</Grid>
```

### Styles tips



---

### How to add multiples elements to page

A container is required for that, example:

```xml
<StackPanel Orientation="Horizontal | Default is Vertical">
	<Button Content="Button 1"></Button>
	<Button Content="Button 2"></Button>
</StackPanel>

Example 2

<Grid ColumDefinitions="*,*"> <!-- Two dinamic coluns (50% each),other example: "200, *" defines the size of the first column  -->
	
	<Button Grid.Column="0" Content="Button 1"></Button> <!-- Add button to column 1 -->
	<Button Grid.Column="1" Content="Button 2"></Button> <!-- Add button to column 2 -->
</Grid>

```

---

Steps:
- Project type


Tips:
- Project type: 

Sections:
- Grid
	- ComumnDefinitions

## How to use Avalonia UI

1) Requirements:
	1) Visual Studio 2026 or later
	2) .NET 8 SDK Installed (min requirement, `dotnet --version` to check current version)
2) Install the template: dotnet new install Avalonia.Templates
	- `dotnet new install Avalonia.Templates`, this command will install the template globally, some warnings may appear during install and it can be ignored.
	- `dotnet new list avalonia` to verify installation, follow the result as example
		- ![[project-ui-modernization-avalonia-dependency-check.png]]
	- Visual Sutdio
		- ![[project-ui-modernization-avalonia-dependency-check-vs.png]]