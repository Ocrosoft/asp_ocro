using System;
using System.Web;

namespace WebApplication_asp_ocro.webs
{
    public partial class _1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Text = "Hello，" + TextBox1.Text + "，your IP Address is：" + GetIP();
        }
        private string GetIP()
        {
            string uip = "";
            if (HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)
            {
                uip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else
            {
                uip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
            }
            if (!string.IsNullOrEmpty(uip) && IsIP(uip))
            {
                return uip;
            }
            return "127.0.0.1";
        }
        public static bool IsIP(string ip)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
        }
    }
}