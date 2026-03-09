---

---
2023-06-06

[EF Core In depth – Soft deleting data with Global Query Filters – The Reformed Programmer](https://www.thereformedprogrammer.net/ef-core-in-depth-soft-deleting-data-with-global-query-filters/)

2023-05-09

[c# - How to make soft delete in cascade with Entity Framework Core including navigation properties? - Stack Overflow](https://stackoverflow.com/questions/49242151/how-to-make-soft-delete-in-cascade-with-entity-framework-core-including-navigati#:~:text=You%20can%20implement%20these%20two,a%20event%20for%20override%20SaveChanges.&text=Secondly%2C%20just%20make%20navigation%20property%20cascade%20delete%20on%20configuration.&text=This%20looks%20pretty%20good%2C%20even%20cascade%20delete%20is%20working.)

2023-06-02

[How to make soft delete in cascade with Entity Framework Core including navigation properties? · Issue #11240 · dotnet/efcore (github.com)](https://github.com/dotnet/efcore/issues/11240)

---

Primeira tentativa:

[https://stackoverflow.com/quaestions/49242151/how-to-make-soft-delete-in-cascade-with-entity-framework-core-including-navigati](https://stackoverflow.com/questions/49242151/how-to-make-soft-delete-in-cascade-with-entity-framework-core-including-navigati)

[https://entityframeworkcore.com/knowledge-base/51561126/soft-delete-the-childs-of-my-entity](https://entityframeworkcore.com/knowledge-base/51561126/soft-delete-the-childs-of-my-entity)

[https://github.com/JonPSmith/EfCore.SoftDeleteServices](https://github.com/JonPSmith/EfCore.SoftDeleteServices)

[https://www.ryansouthgate.com/2019/01/07/entity-framework-core-soft-delete/](https://www.ryansouthgate.com/2019/01/07/entity-framework-core-soft-delete/)

[https://github.com/dotnet/efcore/issues/11240](https://github.com/dotnet/efcore/issues/11240)

[https://entityframework.net/knowledge-base/38998535/how-do-i-cascade-a-softdelete](https://entityframework.net/knowledge-base/38998535/how-do-i-cascade-a-softdelete)-

- Exemplo onde não permite salvar um item se caso uma dependência esta soft-deleted

[https://stackoverflow.com/questions/65030007/c-sharp-entity-framework-core-throw-an-error-when-child-item-gets-added-to-a-s](https://stackoverflow.com/questions/65030007/c-sharp-entity-framework-core-throw-an-error-when-child-item-gets-added-to-a-s)

- Interessante, uma biblioteca que dispara um evento antes de salvar o objeto em banco, não ajuda no problema em questão

[https://dejanstojanovic.net/aspnet/2021/may/implementing-soft-delete-in-ef-core-using-triggers/](https://dejanstojanovic.net/aspnet/2021/may/implementing-soft-delete-in-ef-core-using-triggers/)