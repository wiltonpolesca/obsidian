# Goal

Create a agnostic function responsible to parse the SQL instructions according to the database type.
The function must receive a standard SQL instructions, using "@" to define used parameters and return the same SQL with the correct parameter prefix according to database type
Creates a unit test to validate all situations
## Constraints

Prefix table, please check if there are any mistake before create the function

| Database       | Parameter Prefix | Positional vs. Named | `IDbCommand.CreateParameter()` behavior |
| -------------- | ---------------- | -------------------- | --------------------------------------- |
| **SQL Server** | `@`              | Named                | Creates `SqlParameter`                  |
| **Oracle**     | `:`              | Named                | Creates `OracleParameter`               |
| **MySQL**      | `@`              | Named                | Creates `MySqlParameter`                |
| **PostgreSQL** | `@` / `$`        | Named or Positional  | Creates `NpgsqlParameter`               |
| **MS Access**  | `?`              | **Positional only**  | Creates `OleDbParameter`                |
| **SQLite**     | `$`, `:`, `@`    | Named                | Creates `SqliteParameter`               |

