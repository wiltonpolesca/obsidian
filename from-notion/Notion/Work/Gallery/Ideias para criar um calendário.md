---

---
Módulo de calendário para oferecer suporte ao sistema.

A ideia é construir uma estrutura que trabalhe unicamente por reflection, ela irá pesquisar os binários de determinado(s) diretório, obter quem implementa <u>ICalendar</u> e disponibilizar os dados para a aplicação (que também irá conversar apenas com essa estrutura).

Sempre que o calendário for exibido os feriados devem ser apresentados em uma agenda interna (Holidays Calendar)

Objetos envolvidos:

**ICalendar**

- IList<Event>: Events
- string: Source

**People**

- string: Name
- string: Email

**Event**

- string: Calendar name
- string: Title
- string: Description
- datetime: Start date
- datetime: End date
- IList<People>: Peoples
- bool: Can update end date
- bool: Can update start date
- void: Validate dates
- bool: Has more details
- void: View more details
- object: Internal owner

**Holiday**

- int: Day
- int: Month
- string: Name
- bool: IsFederalHoliday

---