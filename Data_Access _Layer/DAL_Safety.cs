using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Data_Access_Layer
{
    public class DAL_Safety
    {
        /// <summary>
        /// 获取MD5值（大写）
        /// </summary>
        /// <param name="ori">待计算MD5的字符串</param>
        /// <returns></returns>
        public static string getMD5(string ori)
        {
            byte[] result = Encoding.Default.GetBytes(ori);
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] output = md5.ComputeHash(result);
            return BitConverter.ToString(output).Replace("-", "").ToUpper();
        }
    }
}