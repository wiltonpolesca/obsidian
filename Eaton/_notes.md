Servidores para testar o projeto DGST:
- Oficial (oru3): [Swagger UI](http://10.106.28.65:2901/docs/index.html)
- [http://10.106.28.66:2901/docs/index.html](http://10.106.28.66:2901/docs/index.html "http://10.106.28.66:2901/docs/index.html")
- [http://10.106.28.227:2901/docs/index.html](http://10.106.28.66:2901/docs/index.html "http://10.106.28.66:2901/docs/index.html")

Server-Creds
- User name: admin
- Pwd: cyme1234

---

Cyme.Model.Enum.DataSourceMainTypestringEnum:  
[ NotDefined, FileDS, EquipmentDS, NetworkDS, ProjectDS, RepositoryDS, ProfileDS, BillingDS, ResultDS, ConfigurationDS ]

---

Ce sont les endpoints:

/api/cyme-server/security/authorize/tokens/methods/server-creds
/api/cyme-server/security/authorize/tokens/methods/windows

Tu fais "Try it out", ensuite tu rentres les valeurs que tu veux, ça te donne l'équivalent curl:

```shell
curl -X 'POST' \  'http://10.106.28.227:2901/api/cyme-server/security/authorize/tokens/methods/server-creds' \  -H 'accept: text/plain' \  -H 'Content-Type: application/json-patch+json' \  -d '{  "loginName": "admin",  "password": "cyme1234"}'
```

Ensuite ça te donne la réponse du serveur:

200
```shell
{
  "success": true,
  "errors": [],
  "value": "eyJ0eXAiOiJKV1QiLCJhbGciOiJTSEEyNTYifQ==.eyJqdGkiOiJkMmNkZjViYy0wZTczLTQ4OGYtOGMxNi1iZThmOGIyMjc3ZTAiLCJpYXQiOiIyMDI2LTA2LTA0VDE0OjMzOjU5LTA0OjAwIiwiZXhwIjoiMjAyNi0wNi0wNFQxNDo0ODo1OS0wNDowMCIsInN1YiI6IjVlZmFiYzVjLTA0MzEtNGZkMS1hOTkxLWIyNGYzMmQ5M2M0YiIsIm5hbWUiOiJhZG1pbiIsImdpcyI6WyJmZmZmZmZmZi1mZmZmLWZmZmYtZmZmZi1mZmZmZmZmZmZmZmYiLCI1ZjZhZTJjZS0zZWRhLTQ2Y2MtYTQ3MC01MDQzYjcxMTUxY2YiXSwibWlkIjoiOTJjY2RkNmEtZGI3OC00MTQyLWE1M2YtMDNjNWYwZmYxOGVjIn0=.CJheBJ9Bi4b+ErCqq48rYDwEc0u3n25419YFEXoCGJzk5ts117xX3+EWTk/H74exHh4szJ08Jq1DuEdaXJW68g=="
}
```

Donc tu peux tout essayer manuellement avant de coder! On peut faire une couple d'appels ensemble si tu veux.


---

Bom dia!

Para atender a esta tarefa, primeiro foi necessário atualizar a versão das dependências do projeto, o que adicionou novas sub-dependências requeridas pela biblioteca `Cyme.Framework.Gateway` e alguns ajustes no código a resolver Break changes.

A tarefa retira um campo da configuração, devido a isso a seguinte mensagem será vista ao abrir o Config Tool após a atualização:


Exite um erro na string de conexão SQL Server que ocorre na migração do arquivo de configuração após a atualização das dependências e deve ser ajustado manualmente:

----------

Bom dia Carl,

Primeiramente gostaria de dizer que a autenticação usando `server-cred` funcionou perfeitamente após sua ajuda.

Agora eu gostaria de validar o método `windows` porém eu não entendi o payload desse endpoint.

Você poderia me ajudar?


- est prêt et en attente de validation

- pour empêcher l’action GitHub de s’exécuter inutilement
- Aujourd'hui, j'ai demandé à Carl Poirier de m'aider à terminer la tâche de connexion à Active Directory.



Cyme.Server.Common.Public.Services.Models.ServiceRequest.Security.UserSynchronizationConditionstringEnum:  
[ Never, Always, OnlyWhenMissing ]


---
            var dllConfig = ConfigurationManager.OpenExeConfiguration(Assembly.GetExecutingAssembly().Location);
            authServerAuthUrl = dllConfig.AppSettings.Settings["CymeServerAuthorizeMethodsUrl"].Value 
                ?? "api/cyme-server/security/authorize";
            
        private async Task<(bool, IEnumerable<ApiError>)> TestConnectionWithCredentials()
        {
            var loginInfo = new
            {
                LoginName = User,
                Password,
            };

            var url = $"{Protocol.ToLower()}://{Server}/{authServerAuthUrl}/tokens/methods/server-creds";

            var result = await HttpClientHelper.PostAsync<string>(url, loginInfo);
            return (result.Success, result.Errors);
        }

        private Task<(bool, string)> TestConnectionWithActivateDirectory()
        {


            using (var context = new PrincipalContext(ContextType.Domain))
            {
                // 2. Get current logged-in username
                string username = Environment.UserName;

                // 3. Find user in AD
                var user = UserPrincipal.FindByIdentity(
                    context,
                    IdentityType.SamAccountName,
                    username
                );

                // 4. Use the data
                if (user != null)
                {
                    Console.WriteLine(
                        $"Name: {user.DisplayName}\nEmail: {user.EmailAddress}"
                    );
                }
                else
                {
                    Console.WriteLine("User not found in Active Directory");
                }
            }


            //var context = new PrincipalContext(
            //    ContextType.Domain,
            //    Domain,
            //    User,
            //    Password
            //);

            //var user = UserPrincipal.FindByIdentity(
            //    context,
            //    IdentityType.SamAccountName,
            //    User
            //);

            //if (user != null)
            //{
            //    string username = user.SamAccountName;
            //    string email = user.EmailAddress;
            //    string displayName = user.DisplayName;
            //}

            //var groups = user.GetAuthorizationGroups();

            //foreach (var group in groups)
            //{
            //    Console.WriteLine(group.Name);
            //}

            //// Example model
            //var localUser = GetLocalUser();

            //// Username
            //if (syncOptions.syncUserName != "Never")
            //{
            //    localUser.UserName = user.SamAccountName;
            //}

            //// Email
            //if (syncOptions.syncEmailAddress == "Always" ||
            //   (syncOptions.syncEmailAddress == "OnlyWhenMissing" && string.IsNullOrEmpty(localUser.Email)))
            //{
            //    localUser.Email = user.EmailAddress;
            //}

            //// Groups
            //if (syncOptions.syncGroupAssignations == "Always")
            //{
            //    localUser.Groups = user.GetAuthorizationGroups()
            //                           .Select(g => g.Name)
            //                           .ToList();
            //}

            return Task.FromResult((true, string.Empty));
        }
                        api/cyme-server/security/authorize/tokens/methods/windows
`http://10.106.28.227:2901/api/cyme-server/security/authorize/tokens/methods/windows`