---

---
# The Expression Language

The expression language that this library parses is a mix of elements of C# and [VB.NET](http://vb.net/). Since the aim of this library is speed, the language is strongly typed (same rules as C#) and there is no late binding. Unlike C#, the language is **not** case-sensitive. Here is a breakdown of the language elements:

| Element | Description | Example |
| --- | --- | --- |
| +, - | Additive | 100 + a |
| *, /, % | Multiplicative | 100 * 2 / (3 % 2) |
| ^ | Power | 2 ^ 16 |
| - | Negation | -6 + 10 |
| + | Concatenation | "abc" + "def" |
| <<, >> | Shift | 0x80 >> 2 |
| =, <>, <, >, <=, >= | Comparison | 2.5 > 100 |
| And, Or, Xor, Not | Logical | (1 > 10) and (true or not false) |
| And, Or, Xor, Not | Bitwise | 100 And 44 or (not 255) |
| If | Conditional | If(a > 100, "greater", "less") |
| Cast | Cast and conversion | cast(100.25, int) |
| [] | Array index | 1 + arr[i+1] |
| . | Member | varA.varB.function("a") |
| String literal |   | "string!" |
| Char literal |   | 'c' |
| Boolean literal |   | true AND false |
| Real literal | Double and single | 100.25 + 100.25f |
| Integer literal | Signed/unsigned 32/64 bit | 100 + 100U + 100L + 100LU |
| Hex literal |   | 0xFF + 0xABCDU + 0x80L + 0xC9LU |