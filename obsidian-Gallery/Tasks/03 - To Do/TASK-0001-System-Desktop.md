# TASK-0001: System desktop

Autor: Wilton Polesca
Date: 2026-07-31
Last change: 2026-07-31

---


## Goal: 

- The system must provide a Desktop with a Topbar (mat-toolbar) and a sidebar.
- The system navigation will use the right side of the side bar to render the user pages
- The right side must be vertical scrollable, keeping the top bar always visible

## Constraints:

- The side bar must starts below from topbar
- The side bar height must be 100% of the screen - topbar height
- The side bar must receive a `Menu` list and provide up to 3 levels of menu
	```
	Root Menu
	   -> Level 1.0
	   ----> Level 1.1 
	   ----> Level 1.2 
	   ----> Level 1.3 
	   -> Level 2.0
	   ----> Level 2.1 
	```
	- If the `Menu` item contains a route, it cannot have sub-levels
	- If the `Menu` item contins a route, it must open the user page related to the link
	- The Levels must be expandable

**`Menu` object structure**

```typescript
export interface Menu {
  label: string;
  // Preferable text to show, `label` if it is null or whitespace
  display?: string;
  // Field used to sort the menu, per level
  order?: number;
  // Page route
  route?:string;
  // Page route fragment
  fragment?: string;
  // Flag indicating if the menu is visible
  visible?: boolean;
  // Show icon from SVG path
  iconSVGPath?: string;
  // Show icon from SVG Name
  iconSVGName?: string;
  // Show icon from font
  iconFontName?: string;
  // Sub level of menu
  children?: Menu;
}
```

## Edge case:

- Do not allow more than 3 levels of menu
- You must respect the code style of the project and never add new libraries without permission
- Must use angular material
- Must use tailwindcss
- Shared components must be created into `Components` library to be reused by other projects
- All texts must be inputted, allowing i18n by application
- Always create tests to cover the code

## Project informations:

### Current shared components (components project):

- tollbar -> Tollbar component
- side-menu -> SideComponents to render the menu