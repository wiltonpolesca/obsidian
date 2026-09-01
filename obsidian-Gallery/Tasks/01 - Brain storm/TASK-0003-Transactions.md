# TASK-0003: Transaction

Autor: Wilton Polesca
Date: 2026-07-31
Last change: 2026-07-31

---

## Goal: 

- Provide an user page to input the transaction info
- The transaction can be an expense, an income or a transfer, each type of transaction request different type of information, more details into rules section

### Rules

#### Expense input

- Account (Mandatory)
- Date (Mandatory)
- Detail
- Beneficiary (Mandatory)
- Value (Mandatory)
	- Has fees?
		- fees value
	- Has tip?
		- tip value

#### Income input

- Account (Mandatory)
- Date (Mandatory)
- Detail
- Payer (Mandatory)
- Value (Mandatory)

#### Transfer input

- Date (Mandatory)
- Origin 
	- Account (Mandatory)
	- Value (Mandatory)
- Destination 
	- Account (Mandatory)
	- Value (Mandatory)

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

- Use the components available on `Components` library
- Must use tailwindcss
- All texts must be i18n correctly
- Always create tests to cover the code
