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
            if (Session["loginSession"] != null)
            {
                Response.Write("<script>window.location.href='/webs/3_2.aspx';</script>");
                return;
            }
            if (Session["regError"] != null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "",
                    "$(document).ready(function(){changeBorderColor('#" + Session["regErrorID"] + "','" + Session["regError"] + "');});", true);
                Session["regErrorID"] = null;
                Session["regError"] = null;
            }
        }
        protected void buttonSubmit_Click(object sender, EventArgs e)
        {
            string username = inputUsername.Text.Trim();
            string password = inputPassword.Text.Trim();
            string repassword = inputRepeatPassword.Text.Trim();
            string sex = selectorSex.SelectedValue;
            string year = inputYear.Text.Trim();
            string grade = selectGrade.SelectedValue;
            string major = selectMajor.SelectedValue;
            string check_code = Session["CheckCode"].ToString();
            string checkcode = checkCode.Text;
            string ip = GetIP();
            DateTime dtime = DateTime.Now;
            string time = dtime.ToString();

            if(!Regex.IsMatch(username,@"^[0-9a-zA-Z_]{1,21}$") ||
                !Regex.IsMatch(password, @"^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$") ||
                password!=repassword 
                ) // 非法请求均不提示
            {
                return;
            }
            if (!check_code.Equals(checkcode))
            {
                Response.Write("<script>alert('Incorrect checkcode!');</script>");
                Response.Write("<script>window.location.href='/webs/3_1.aspx';</script>");
                return;
            }
            password = MyMD5.MD5(password);
            password = password.ToUpper();

            try
            {
                string sql = "insert into users(username, password, sex, grade, age, major, IP, regtime) values(?0,?1,?2,?3,?4,?5,?6,?7);";
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
                    Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                }
                else
                {
                    Session["regErrorID"] = "stdContentMoudle_stdContent_inputUsername";
                    Session["regError"] = "注册失败，请更换用户名后重试！";
                    Response.Write("<script>window.location.href='/webs/3_1.aspx';</script>");
                }
            }
            catch
            {
                Session["regErrorID"] = "stdContentMoudle_stdContent_inputUsername";
                Session["regError"] = "注册失败，请更换用户名后重试！";
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