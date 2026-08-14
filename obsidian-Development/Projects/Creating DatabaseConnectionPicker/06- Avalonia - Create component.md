# Goal: Migrate Windows form component to avalonia component

- Create an Avalonia UserControl with the same behaviour and the same name of WindowsForm DatabaseComponentPicker.
- Use the best way to organize the components on screen
- You can use the same base class as windows form component, in this case, move the class shared to an appropriate folder

## Constraints:

- Must use Avalonia best practice
- The new component must be part of Cyme.DI.UI project
- Create unit test to the new component
- Avoid code duplication
- Use SOLID principles
- Avoid `else` clause always when possible