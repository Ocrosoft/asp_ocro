using System;
using System.Security.Cryptography;
using System.Text;

namespace WebApplication_asp_ocro
{
    public class MyMD5
    {
        public static string MD5(string ori)
        {
            byte[] result = Encoding.Default.GetBytes(ori);
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] output = md5.ComputeHash(result);
            return BitConverter.ToString(output).Replace("-", "");
        }
    }
}