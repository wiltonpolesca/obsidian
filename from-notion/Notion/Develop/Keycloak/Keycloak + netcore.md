---

---

## Obter os dados de configuração

[http://[IP:Port]/realms/[realmName]/.well-known/openid-configuration](http://localhost:9090/realms/gallery/.well-known/openid-configuration)

Example: [http://localhost:9090/realms/gallery/.well-known/openid-configuration](http://localhost:9090/realms/gallery/.well-known/openid-configuration)

## Obter os dados do usuário logado

https://stackoverflow.com/questions/60444977/how-to-get-identity-user-from-his-authentication-jwt-token-in-net-core-api

## net core

[https://www.reddit.com/r/dotnet/comments/6rl7qj/question_securing_an_aspnet_core_api_with_keycloak/](https://www.reddit.com/r/dotnet/comments/6rl7qj/question_securing_an_aspnet_core_api_with_keycloak/)

[https://auth0.com/docs/quickstart/backend/aspnet-core-webapi/01-authorization](https://auth0.com/docs/quickstart/backend/aspnet-core-webapi/01-authorization)

```javascript
public void ConfigureServices(IServiceCollection services) 
{ 
    // Some code omitted for brevity... 
    string domain = $"https://{Configuration["Auth0:Domain"]}/"; 
    services 
        .AddAuthentication(JwtBearerDefaults.AuthenticationScheme) 
        .AddJwtBearer(options => 
        { 
            options.Authority = domain; 
            options.Audience = Configuration["Auth0:Audience"]; 
            // If the access token does not have a `sub` claim, `User.Identity.Name` will be `null`. Map it to a different claim by setting the NameClaimType below. 
            options.TokenValidationParameters = new TokenValidationParameters 
            { 
                NameClaimType = ClaimTypes.NameIdentifier 
            }; 
        }); 
}
```

```javascript
public void Configure(IApplicationBuilder app, IHostingEnvironment env) 
{ 
    // Some code omitted for brevity... 
    app.UseAuthentication(); 
    app.UseAuthorization(); 
    app.UseMvc(routes => 
    { 
        routes.MapRoute( 
            name: "default", 
            template: "{controller=Home}/{action=Index}/{id?}"); 
    }); 
}
```

```javascript
var options = new JwtBearerOptions 
{ 
    Audience = "***your-app-id***", 
    Authority = "https://KEYCLOAKINSTANCEURL/auth/realms/YOURREALM/" 
}; 
app.UseJwtBearerAuthentication(options);
```