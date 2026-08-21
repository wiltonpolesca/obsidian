## Shift prompting with Blueprint

### What a blueprint should contains

- **Goal**: One plain sentence describing what the code does
- **Contraints**: the rules it must obey (for example, money is a decimal, never a float)
- **Expected behavior**: what a correct run looks like
- **Edge case**: the awkward inputs that break naive code, such as an empty file or negative amount.

#### Key Terms

- **Blueprint**: a short written plan (goal, constraints, behavior, edge cases) made before coding.
- **Contraints**: rules the code must obey
- **Edge cases**: unusual inputs that break naive implementations
- **Multi-model strategy**: using a reasoning model to plan and a fast model to execute.
- **Prompt checklist**: standing instructions that make the AI surface binding spots and stay scoped.

---

## Context degredation, decline in accuracy

The **context window** is the fixed amount of information the model can hold at once: your files, your prompts, and its own prior answers. As a thread grows, that window fills with old, half-relevant content, and the useful signal gets buried. This slow loss of accuracy is **context degradation**.

### Habbits to keep the boad clean

#### Habit 1: The reset Heuristic

After achieved the goal, starts a new thread with the next goal (or sub goal), it will preserve the new context and avoid degredation.

####  Habit 2: Scope with @-Mentions

Uses @-mentions to define scope (files, folders, content) to specify relevante files or context, it will reduce the scope having better answer.


>***Scope each prompt to exactly what matters - and reset the rhread once a subgoal is done***


### Key terms

- **Context window**: the fixed amount of information a model can consider at once.
- **Context degradation**: the decline in accuracy as a thread accumulates old content.
- **Reset heuristic**: starting a fresh thread once a subgoal is complete.
- **`@`-mention scoping**: using `@`-file and `@`-folder mentions to limit context to what's relevant.

---

## Demo Blueprint-First prompting

Example:

```
# GOAL: turn a string like "1h30m" into total minutes.
# CONSTRAINTS: return an int; raise ValueError on bad input.
# EDGE CASES: missing hours, missing minutes,
#             empty string, garbage text.
```

```
EDGE CASES: money is a decimal, stored as a string
```


### Excercices

```
GOAL: Create an Expense record class, fields amount (decimal), category (string), description (string) and date (date)
CONSTRAINTS: 
- An `Expense` holds an amount (decimal), a category, a description, and a date.
- The model serializes to and from JSON-safe values, with the amount and date stored as strings, so no precision is lost.
- Saving expenses and loading them back returns the same data across separate runs.
- Loading a **missing** file returns an empty list and does not raise.
- Loading a file that exists but is **corrupt** or is not a JSON array raises `StoreError` with a clear message naming the file.
- Run test_models.py after create the class
EDGE CASES: 
- Amount is a decimal, stored as a string, if empty, default 0.
- Date is a date, stored as a string, if empty or invalid, use min unix time
```


```
GOAL: Implements load_expenses and save_expenses.
CONTRAINTS:
- The model serializes to and from JSON-safe values, with the amount and date stored as strings, so no precision is lost.
- Saving expenses and loading them back returns the same data across separate runs.
- Loading a file that exists but is **corrupt** or is not a JSON array raises `StoreError` with a clear message naming the file.
- Run test_models.py and test_stored after the code is done.
  
EDGE CASES: 
- Amount is a decimal, stored as a string, if empty, default 0.
- Date is a date, stored as a string, if empty or invalid, use min unix time  
```

### Answer

#### What a Good Blueprint Looks Like

Before prompting Cursor, you would write something like this:

**Record:** `Expense`

**Fields:** `amount: Decimal`, `category: str`, `description: str`, `date: date`

**Money constraint:** stored as a string end-to-end — serialized with `str(amount)`, rebuilt with `Decimal(...)` on load

**File edge cases:**

- Missing file → return `[]`, do not raise
- File exists but is corrupt or not a JSON array → raise `StoreError` with a message that names the file

This is the plan you check the generated code against before accepting it.