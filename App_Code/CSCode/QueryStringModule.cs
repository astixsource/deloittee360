#region Using

using System;
using System.IO;
using System.Web;
using System.Text;
using System.Security.Cryptography;
using System.Linq;

#endregion

/// <summary>
/// Summary description for QueryStringModule
/// </summary>
public class QueryStringModule : IHttpModule
{

  #region IHttpModule Members

  public void Dispose()
  {
    // Nothing to dispose
  }

  public void Init(HttpApplication context)
  {
    context.BeginRequest += new EventHandler(context_BeginRequest);
  }

  #endregion

  private const string PARAMETER_NAME = "enc=";
  private const string ENCRYPTION_KEY = "3sdsdf2343casnds";

  void context_BeginRequest(object sender, EventArgs e)
  {
    HttpContext context = HttpContext.Current;
    if (context.Request.Url.OriginalString.Contains("aspx") && context.Request.RawUrl.Contains("?"))
    {
      string query = ExtractQuery(context.Request.RawUrl);
      string path = GetVirtualPath();

      if (query.StartsWith(PARAMETER_NAME, StringComparison.OrdinalIgnoreCase))
      {
        // Decrypts the query string and rewrites the path.
        string rawQuery = query.Replace(PARAMETER_NAME, string.Empty);
        string decryptedQuery = Decrypt(rawQuery);
        context.RewritePath(path, string.Empty, decryptedQuery);
      }
      else if (context.Request.HttpMethod == "GET")
      {
        // Encrypt the query string and redirects to the encrypted URL.
        // Remove if you don't want all query strings to be encrypted automatically.
        string encryptedQuery = Encrypt(query);
        context.Response.Redirect(path + encryptedQuery);
      }
    }
  }

  /// <summary>
  /// Parses the current URL and extracts the virtual path without query string.
  /// </summary>
  /// <returns>The virtual path of the current URL.</returns>
  private static string GetVirtualPath()
  {
    string path = HttpContext.Current.Request.RawUrl;
    path = path.Substring(0, path.IndexOf("?"));
    path = path.Substring(path.LastIndexOf("/") + 1);
    return path;
  }

  /// <summary>
  /// Parses a URL and returns the query string.
  /// </summary>
  /// <param name="url">The URL to parse.</param>
  /// <returns>The query string without the question mark.</returns>
  private static string ExtractQuery(string url)
  {
    int index = url.IndexOf("?") + 1;
    return url.Substring(index);
  }

  #region Encryption/decryption

  /// <summary>
  /// The salt value used to strengthen the encryption.
  /// </summary>
  private readonly static byte[] SALT = Encoding.ASCII.GetBytes(ENCRYPTION_KEY.Length.ToString());

    /// <summary>
    /// Encrypts any string using the Rijndael algorithm.
    /// </summary>
    /// <param name="inputText">The string to encrypt.</param>
    /// <returns>A Base64 encrypted string.</returns>
    public static string Encrypt(string inputText)
    {
        byte[] salt = GenerateSalt();
        byte[] iv;
        byte[] ciphertext;

        using (Aes aes = Aes.Create())
        {
            aes.Key = DeriveKey(ENCRYPTION_KEY, salt);
            aes.GenerateIV();
            iv = aes.IV;

            using (MemoryStream memoryStream = new MemoryStream())
            {
                using (CryptoStream cryptoStream = new CryptoStream(memoryStream, aes.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    byte[] plaintextBytes = Encoding.UTF8.GetBytes(inputText);
                    cryptoStream.Write(plaintextBytes, 0, plaintextBytes.Length);
                    cryptoStream.FlushFinalBlock();
                    ciphertext = memoryStream.ToArray();
                }
            }
        }

        // Combine salt, IV, and ciphertext
        byte[] encryptedData = CombineArrays(salt, iv, ciphertext);

        // Generate HMAC for integrity
        byte[] hmac = ComputeHMAC(encryptedData, ENCRYPTION_KEY);

        // Combine encrypted data and HMAC
        return "?" + PARAMETER_NAME + Convert.ToBase64String(CombineArrays(encryptedData, hmac));
    }

    /// <summary>
    /// Decrypts a previously encrypted string.
    /// </summary>
    /// <param name="inputText">The encrypted string to decrypt.</param>
    /// <returns>A decrypted string.</returns>
    public static string Decrypt(string inputText)
    {
        byte[] data = Convert.FromBase64String(inputText);

        // Extract components
        byte[] salt = data.Take(16).ToArray();
        byte[] iv = data.Skip(16).Take(16).ToArray();
        byte[] ciphertext = data.Skip(32).Take(data.Length - 64).ToArray();
        byte[] hmac = data.Skip(data.Length - 32).ToArray();

        // Validate HMAC
        byte[] encryptedData = data.Take(data.Length - 32).ToArray();
        if (!VerifyHMAC(encryptedData, hmac, ENCRYPTION_KEY))
            throw new CryptographicException("HMAC validation failed.");

        using (Aes aes = Aes.Create())
        {
            aes.Key = DeriveKey(ENCRYPTION_KEY, salt);
            aes.IV = iv;

            using (MemoryStream memoryStream = new MemoryStream(ciphertext))
            {
                using (CryptoStream cryptoStream = new CryptoStream(memoryStream, aes.CreateDecryptor(), CryptoStreamMode.Read))
                {
                    using (StreamReader reader = new StreamReader(cryptoStream, Encoding.UTF8))
                    {
                        return reader.ReadToEnd();
                    }
                }
            }
        }
    }

    private static byte[] ComputeHMAC(byte[] data, string key)
    {
        using (HMACSHA256 hmac = new HMACSHA256(Encoding.UTF8.GetBytes(key)))
        {
            return hmac.ComputeHash(data);
        }
    }

    private static bool VerifyHMAC(byte[] data, byte[] hmac, string key)
    {
        byte[] computedHmac = ComputeHMAC(data, key);
        return computedHmac.SequenceEqual(hmac);
    }

    private static byte[] CombineArrays(params byte[][] arrays)
    {
        byte[] combined = new byte[arrays.Sum(a => a.Length)];
        int offset = 0;

        foreach (var array in arrays)
        {
            Buffer.BlockCopy(array, 0, combined, offset, array.Length);
            offset += array.Length;
        }

        return combined;
    }

    private static byte[] GenerateSalt()
    {
        byte[] salt = new byte[16];
        using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
        {
            rng.GetBytes(salt);
        }
        return salt;
    }

    private static byte[] DeriveKey(string password, byte[] salt)
    {
        using (var keyDerivationFunction = new Rfc2898DeriveBytes(password, salt, 10000))
        {
            return keyDerivationFunction.GetBytes(32); // 256-bit key
        }
    }




    #endregion

}
