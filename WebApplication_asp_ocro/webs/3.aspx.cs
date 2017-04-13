using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Security.Cryptography;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] != null)
            {
                Response.Write("<script>window.location.href='/webs/3_2.aspx';</script>");
                return;
            }
            if(Session["loginError"]!=null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "",
                    "$(document).ready(function(){changeBorderColor('#"+Session["loginErrorID"]+"','" + Session["loginError"] + "');});", true);
                Session["loginErrorID"] = null;
                Session["loginError"] = null;
            }
            if (!IsPostBack)
            {
                if (Request.Cookies["loginCookies"] != null)
                {
                    string savedUsername = Request.Cookies["loginCookies"].Value;
                    checkBoxRemember.Checked = true;
                    inputUsername.Text = savedUsername;
                }
            }
        }
        protected void Click_Login(object sender, EventArgs e)
        {
            string user_name, pass_word;
            user_name = inputUsername.Text.Trim();
            pass_word = inputPassword.Text.Trim();
            string check_code = Session["CheckCode"].ToString();
            string check_Code = checkCode.Text.Trim();
            if (!Regex.IsMatch(user_name, @"^[0-9a-zA-Z_]{1,21}$") ||
                !Regex.IsMatch(pass_word, @"^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$")
                )
            {
                return;
            }
            if (checkBoxRemember.Checked)
            {
                Response.Cookies["loginCookies"].Value = user_name;
                Response.Cookies["loginCookies"].Expires = DateTime.Now.AddDays(7);
            }
            else
            {
                Response.Cookies["loginCookies"].Value = "";
                Response.Cookies["loginCookies"].Expires = DateTime.Now.AddDays(-7);
            }
            if (!check_code.Equals(check_Code))
            {
                Session["loginErrorID"] = "stdContentMoudle_stdContent_checkCode";
                Session["loginError"] = "Incorrect checkcode!";
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            pass_word = MyMD5.MD5(pass_word);
            pass_word = pass_word.ToUpper();
            object obj = null;
            try
            {
                string sql = "select username from " + (checkBoxTeacher.Checked ? "teacher" : "users") + " where username=?1 and password=?2;";
                MySqlParameter[] para = new MySqlParameter[2];
                para[0] = new MySqlParameter("?1", user_name);
                para[1] = new MySqlParameter("?2", pass_word);
                obj = MysqlHelper.ExecuteScalar(sql, para);
            }
            catch
            {
                Session["loginErrorID"] = "stdContentMoudle_stdContent_buttonLogin";
                Session["loginError"] = "Server error!";
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            if (Equals(obj, null))
            {
                Session["loginErrorID"] = "stdContentMoudle_stdContent_inputPassword";
                Session["loginError"] = "Username or password wrong!";
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            else
            {
                Session["loginSession"] = user_name;
                if (checkBoxTeacher.Checked) Session["loginIden"] = "Teacher";
                else Session["loginIden"] = "User";
                Response.Write("<script>window.location.href='/webs/3_2.aspx';</script>");
            }
        }
    }
};