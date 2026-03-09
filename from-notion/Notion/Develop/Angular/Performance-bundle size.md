---

---
npm install source-map-explorer —save-dev

Permite visualizar o conteúdo do bundle para localizar o que está impactando no tamanho do mesmo.

Angular.json : sourceMap: true (ou objeto)

```javascript
sourceMap: {
"scripts": true,
"styles": true,
"hidden": true,
"vendor": true
}
```

Script:

“explorer”: source-map-explorer dist/**/*.js

and then: **npm run explorer**

---

use date-fns instead of moment.js