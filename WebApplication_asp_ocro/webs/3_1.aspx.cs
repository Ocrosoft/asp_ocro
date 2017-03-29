using MySql.Data.MySqlClient;
using System;
using System.Text.RegularExpressions;
using System.Web;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3_1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void buttonSubmit_Click(object sender, EventArgs e)
        {
            string username = inputUsername.Text;
            string password = inputPassword.Text;
            password = MyMD5.MD5(password);
            password = password.ToUpper();
            string sex = selectorSex.SelectedValue;
            string year = inputYear.Text;
            string grade = selectGrade.SelectedValue;
            string major = selectMajor.SelectedValue;
            string check_code = Session["CheckCode"].ToString();
            string checkcode = checkCode.Text;
            string ip = GetIP();
            DateTime dtime = DateTime.Now;
            string time = dtime.ToString();

            if (!check_code.Equals(checkcode))
            {
                Response.Write("<script>alert('Incorrect checkcode!');</script>");
                Response.Write("<script>window.location.href='http://debug.ocrosoft.com:8001/webs/3.aspx';</script>");
                return;
            }

            try
            {
                string sql = "insert into users values(?0,?1,?2,?3,?4,?5,?6,?7);";
                MySqlParameter[] para = new MySqlParameter[8];
                para[0] = new MySqlParameter("?0", username);
                para[1] = new MySqlParameter("?1", password);
                para[2] = new MySqlParameter("?2", sex);
                para[3] = new MySqlParameter("?3", grade);
                para[4] = new MySqlParameter("?4", year);
                para[5] = new MySqlParameter("?5", major);
                para[6] = new MySqlParameter("?6", ip);
                para[7] = new MySqlParameter("?7", time);
                int res = MysqlHelper.ExecuteNonQuery(sql, para);
                if (res > 0)
                {
                    Response.Write("<script>alert('Register successful! Turning to login page...');</script>");
                    Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Faild, server returned an error message(1)!');</script>");
                    Response.Write("<script>window.location.href='/webs/3_1.aspx';</script>");
                }
            }
            catch
            {
                Response.Write("<script>alert('Faild, server returned an error message(0)!');</script>");
                Response.Write("<script>window.location.href='/webs/3_1.aspx';</script>");
                return;
            }
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
            return Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
        }
    }
}