using Azure.Identity;
using Azure.Core;
using System.Configuration;
using System.Web;
using System;

public static class clsAccesstoken
{
    static string _tenantId = ConfigurationManager.AppSettings["_tenantId"];
    static string _clientId = ConfigurationManager.AppSettings["_clientId"];
    
    public static string getazureAccessToken()
    {
        string _clientSecret =Convert.ToString(HttpContext.Current.Application["_clientSecret"]);
        var credential = new Azure.Identity.ClientSecretCredential(_tenantId, _clientId, _clientSecret);
        var token = credential.GetToken(new Azure.Core.TokenRequestContext(new[] { "https://database.windows.net/.default" }));
        return token.Token;
    }
}