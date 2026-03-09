---

---
ideia de como trocar a cor de fundo do snak

https://stackblitz.com/edit/angular-material-notification-service?file=src%2Fstyles.scss

---

Non-persistent acknowledgments such as “snack bars” should disappear from the screen after a minimum of **four seconds and a maximum of eight seconds**, with an option to dismiss it sooner and “undo” where appropriate

---

![[Untitled 14.png]]

**High-attention**

- Alerts (immediate attention required)
- Errors (immediate action required)
- Exceptions (system anomalies, something didn’t work)
- Confirmations (potentially destructive actions that need user confirmation to proceed)

**Medium-attention**

- Warnings (no immediate action required)
- Acknowledgments (feedback on user actions)
- Success messages

**Low-attention**

- Informational messages (aka passive notifications, something is ready to view)
- Badges (typically on icons, signifying something new since last interaction)
- Status indicators (system feedback)

---

Once armed with the list, the next step is to categorize the notifications based on the desired attention level and attributes. Again, because **notifications should not be intrusive**, this needs to be done carefully. Some of the questions to ask during this process are:

- What would trigger the notification?
- What type of feedback is being communicated?
- Where would the notification appear and how?
- Which notification would require an immediate interaction?
- Is the notification persistent or non-persistent?

---

Next, [<u>color-coding</u>](https://www.toptal.com/designers/ux/color-in-ux) and icons need to be determined and put into a design system (or style guide). When going through this process, designers need to consider **every instance where a notification would appear** and make sure they render correctly on all backgrounds.

![[Untitled 15.png]]

![[Untitled 16.png]]

### Best Practices for Error Messages

- Error messages should be simple and direct, preferably actionable, written in a language that is easy to read and quick to comprehend.
- Avoid obscure codes and abbreviations such as “*received response success is false.*”
- Provide concise, clear descriptions of the problem instead of “*an error has occurred.*”
- Avoid blaming people or telling them they did something wrong—for example, by saying it was an “*illegal command.*”
- Provide in-context constructive error messages so that people can fix the issue.
- Avoid indicating an error just by turning the field red. It doesn’t make it accessible to people with disabilities. It’s always best to include other visual cues that the colorblind can see.
- Use [<u>inline validation</u>](https://medium.com/wdstack/inline-validation-in-forms-designing-the-experience-123fb34088ce#.fl86493cl) for input fields on forms.
- Error messages should not disappear until people have fixed the problem.

### References:

[A Comprehensive Guide to Notification Design | Toptal®](https://www.toptal.com/designers/ux/notification-design)