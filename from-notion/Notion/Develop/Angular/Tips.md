---

---
## HTTPS localhost

Como criar um certificado local

[https://medium.com/@richardr39/using-angular-cli-to-serve-over-https-locally-70dab07417c8](https://medium.com/@richardr39/using-angular-cli-to-serve-over-https-locally-70dab07417c8)

Melhor forma de configurar o projeto, usando o angular.json

[https://stackoverflow.com/questions/39210467/get-angular-cli-to-ng-serve-over-https](https://stackoverflow.com/questions/39210467/get-angular-cli-to-ng-serve-over-https)

## Voltar uma página na navegação

```javascript
import { Router } from '@angular/router'

// Retorna para a página anterior
this.location.back();
// Vai para uma determinada página  
this.router.navigate('/users');
//TESTAR retornar um path relativopu
this.router.navigate(['..'], {relativeTo: this.activatedRoute});

export class UserDetailComponent {  
	constructor(private router: Router) {}    
	
	goBackToPrevPage(): void 
	{
		this.location.back();  
	}
}
```

## Detectar mudanças em um array

https://www.concretepage.com/angular/angular-ngdocheck

## Compound components

[https://medium.com/angular-in-depth/write-compound-components-1001449c67f0](https://medium.com/angular-in-depth/write-compound-components-1001449c67f0)

## Recuperar controle de validação internamente

[https://www.freecodecamp.org/news/angular-generic-form-validator/](https://www.freecodecamp.org/news/angular-generic-form-validator/)

## Recuperar um atributo a partir do controller

[https://indepth.dev/tutorials/angular/get-attribute-value](https://indepth.dev/tutorials/angular/get-attribute-value)