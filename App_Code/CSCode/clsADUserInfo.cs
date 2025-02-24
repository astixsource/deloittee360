using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Configuration;
using System.Security.Claims;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using RestSharp;
using System.Web.Script.Serialization;
using System.Net;
using System.Text;
using System.IO;
using Newtonsoft.Json.Linq;

/// <summary>
/// Summary description for clsADUserInfo
/// </summary>
public class clsADUserInfo
{

	private string clientId = ConfigurationManager.AppSettings["ida:ClientId"];
	private string appKey = ConfigurationManager.AppSettings["ida:ClientSecret"];
    private string TenantId = ConfigurationManager.AppSettings["ida:TenantId"];
    private string aadInstance = EnsureTrailingSlash(ConfigurationManager.AppSettings["ida:AADInstance"]);
    private string graphResourceID = "https://graph.microsoft.com";//"https://graph.windows.net";
    string Logpath = AppDomain.CurrentDomain.BaseDirectory + "\\Logs\\DailyLogs_" + HttpContext.Current.Session.SessionID + "_" + DateTime.Now.ToString("yyyyMMdd") + ".txt";

    public clsADUserInfo()
	{
		//
		// TODO: Add constructor logic here
		//
	}
   public async Task<string> fnGetUserDetail()
    {
        using (StreamWriter logfile = new StreamWriter(Logpath, true))
        {
            logfile.WriteLine("Date- " + DateTime.Now.ToString());
            logfile.WriteLine("Token:" + await GetTokenForApplication());
        }

        var client = new RestClient("https://graph.microsoft.com/v1.0/me/");
        client.Timeout = -1;
        var request = new RestRequest(Method.GET);
        request.AddHeader("Authorization", "Bearer "+ await GetTokenForApplication());
        IRestResponse response = client.Execute(request);
        var serializer = new JavaScriptSerializer();
        serializer.MaxJsonLength = Int32.MaxValue;
        var data = serializer.Deserialize<dynamic>(response.Content);
        string mail = data["mail"];
        return mail;
    }
    public async Task<string> fnGetToken()
    {
        return await GetTokenForApplication();
    }

  
    public async Task<string> GetTokenForApplication()
    {
        string signedInUserID = ClaimsPrincipal.Current.FindFirst(ClaimTypes.NameIdentifier).Value;
        string tenantID = ClaimsPrincipal.Current.FindFirst("http://schemas.microsoft.com/identity/claims/tenantid").Value;
        string userObjectID = ClaimsPrincipal.Current.FindFirst("http://schemas.microsoft.com/identity/claims/objectidentifier").Value;

        // get a token for the Graph without triggering any user interaction (from the cache, via multi-resource refresh token, etc)
        ClientCredential clientcred = new ClientCredential(clientId, appKey);
        // initialize AuthenticationContext with the token cache of the currently signed in user, as kept in the app's database
        AuthenticationContext authenticationContext = new AuthenticationContext(aadInstance + tenantID);
        AuthenticationResult authenticationResult = await authenticationContext.AcquireTokenSilentAsync(graphResourceID, clientcred, new UserIdentifier(userObjectID, UserIdentifierType.UniqueId));
        
        return authenticationResult.AccessToken;
    }
    private static string EnsureTrailingSlash(string value)
    {
        if (value == null)
        {
            value = string.Empty;
        }

        if (!value.EndsWith("/", StringComparison.Ordinal))
        {
            return value + "/";
        }
        return value;
    }
}