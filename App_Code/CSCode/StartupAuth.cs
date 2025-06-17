using System;
using System.Configuration;
using System.IdentityModel.Claims;
using System.Threading.Tasks;
using System.Web;
using Microsoft.Identity.Client;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OpenIdConnect;
using Owin;

public partial class StartupAuth
{
    // Configuration from Web.config
    private static string clientId = ConfigurationManager.AppSettings["ida:ClientId"];
    private static string clientSecret = Convert.ToString(HttpContext.Current.Application["SSO_clientSecret"]);
    private static string aadInstance = EnsureTrailingSlash(ConfigurationManager.AppSettings["ida:AADInstance"]);
    private static string tenantId = ConfigurationManager.AppSettings["ida:TenantId"];
    private static string postLogoutRedirectUri = ConfigurationManager.AppSettings["ida:PostLogoutRedirectUri"];
    private static string postRedirectUri = ConfigurationManager.AppSettings["ida:PostRedirectUri"];

    public static readonly string Authority = aadInstance + tenantId;

    public void ConfigureAuth(IAppBuilder app)
    {
        app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);
        app.UseCookieAuthentication(new CookieAuthenticationOptions());

        app.UseOpenIdConnectAuthentication(
            new OpenIdConnectAuthenticationOptions
            {
                ClientId = clientId,
                Authority = Authority,
                RedirectUri = postRedirectUri,
                PostLogoutRedirectUri = postLogoutRedirectUri,
                ResponseType = OpenIdConnectResponseType.CodeIdToken,
                Scope = "openid profile email https://graph.microsoft.com/.default",

                TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = false // Set to true for single-tenant apps
                },

                Notifications = new OpenIdConnectAuthenticationNotifications
                {
                    AuthorizationCodeReceived = async context =>
                    {
                        var code = context.Code;

                        var cca = ConfidentialClientApplicationBuilder
                            .Create(clientId)
                            .WithClientSecret(clientSecret)
                            .WithRedirectUri(postRedirectUri)
                            .WithAuthority(new Uri(Authority))
                            .Build();

                        string[] scopes = new string[] { "https://graph.microsoft.com/.default" };

                        AuthenticationResult result = await cca
                            .AcquireTokenByAuthorizationCode(scopes, code)
                            .ExecuteAsync();

                        // You can now use result.AccessToken
                        // Optionally store in session/context if needed
                       // return Task.FromResult(0);
                    }
                    //,

                    //AuthenticationFailed = context =>
                    //{
                    //    // Handle login errors
                    //    context.HandleResponse();
                    //    context.Response.Redirect("/Error?message=" + HttpUtility.UrlEncode(context.Exception.Message));
                    //    return Task.FromResult(0);
                    //}
                }
            });
    }

    private static string EnsureTrailingSlash(string value)
    {
        if (string.IsNullOrEmpty(value))
        {
            return "/";
        }
        return value.EndsWith("/") ? value : value + "/";
    }
}
