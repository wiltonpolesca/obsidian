---

---
Gerar valores em Hexadecimal

RandomNumberGenerator is less performative than Random

```javascript
        private static string GenerateHexadecimalValue(int lenght = 8, int groupSize = 4, string separatorChar = "-")
        {
            var data = RandomNumberGenerator.GetBytes(lenght / 2);

            var value = Convert.ToHexString(data).ToUpper();

            if (groupSize > 0)
            {
                var splitValues = Enumerable.Range(0, value.Length / groupSize)
                    .Select(i => value.Substring(i * groupSize, groupSize));

                value = string.Join(separatorChar, splitValues);
            }

            return value;
        }

```

Exemplos de uso

```javascript
GenerateHexadecimalValue(8, 4, "-"); => xxxx-xxxx
GenerateHexadecimalValue(12, 2, ":") => xx:xx:xx:xx:xx:xx
```