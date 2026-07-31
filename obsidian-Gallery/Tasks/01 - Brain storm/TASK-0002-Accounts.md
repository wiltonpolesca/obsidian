# TASK-0002: Accounts

Autor: Wilton Polesca
Date: 2026-07-31
Last change: 2026-07-31

---

## Goal: 

- Provide an user page to input the account info

Each account must have:

| Field              | Type    | Description                                     | Constraints                                    |
| ------------------ | ------- | ----------------------------------------------- | ---------------------------------------------- |
| Name               | string  | Account name                                    | Required, max-length: 100                      |
| Type               | string  | Account type, list received from backend        | Required                                       |
| Initial balance    | double  | Initial balance value                           |                                                |
| Initial balance at | Date    | Date of initial balance value                   | Required if `initial balance` greater than `0` |
| Is active          | boolean | Flag indicating if the account is active or not | Default:false                                  |

## Constraints:

- 
## Edge case:

- 