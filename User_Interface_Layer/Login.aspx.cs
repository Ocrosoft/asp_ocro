using Business_Logic_Layer;
using System;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace User_Interface_Layer
{
    public partial class Login : Page
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] != null) // 已经登录
            {
                if (Session["loginIden"].ToString() == "Teacher")
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Teacher/Default.aspx';", true);
                else if (Session["loginIden"].ToString() == "Student")
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Student/Default.aspx';", true);
                return;
            }
            if (Session["loginError"] != null) // 登录失败
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "",
                    "$(document).ready(function(){changeBorderColor('#" + Session["loginErrorID"] + "','" + Session["loginError"] + "');});", true);
                Session["loginErrorID"] = null;
                Session["loginError"] = null;
            }
            if (!IsPostBack)
            {
                if(Session["regSuccess"]!=null) // 刚刚注册成功了
                {
                    inputUsername.Text = Session["regSuccess"].ToString();
                    Session["regSuccess"] = null;
                    return;
                }
                if (Request.Cookies["loginCookies"] != null) // 记住用户名
                {
                    string savedUsername = Request.Cookies["loginCookies"].Value;
                    checkBoxRemember.Checked = true;
                    inputUsername.Text = savedUsername;
                }
            }
        }
        /// <summary>
        /// 登录按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Click_Login(object sender, EventArgs e)
        {
            string username = inputUsername.Text.Trim();
            string password = inputPassword.Text.Trim();
            string checkcode_correct = Session["CheckCode"].ToString(); // 正确验证码
            string checkcode_user = checkCode.Text.Trim();
            checkcode_user = checkcode_user.ToLower();
            if (!Regex.IsMatch(username, @"^[0-9a-zA-Z_]{1,21}$") ||
                !Regex.IsMatch(password, @"^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$")
                ) // 非法请求
            {
                return;
            }
            if (checkBoxRemember.Checked) // 记住用户名
            {
                Response.Cookies["loginCookies"].Value = username;
                Response.Cookies["loginCookies"].Expires = DateTime.Now.AddDays(7);
            }
            else
            {
                Response.Cookies["loginCookies"].Value = "";
                Response.Cookies["loginCookies"].Expires = DateTime.Now.AddDays(-7);
            }
            if (!checkcode_user.Equals(checkcode_correct)) // 校验验证码
            {
                Session["loginErrorID"] = "stdContentMoudle_stdContent_checkCode";
                Session["loginError"] = "验证码错误！";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                return;
            }

            bool loginResult = false;
            if (checkBoxTeacher.Checked) loginResult = BLL_Teacher.login(username, password);
            else loginResult = BLL_Student.login(username, password);

            if (!loginResult) // 登录失败
            {
                Session["loginErrorID"] = "stdContentMoudle_stdContent_inputPassword";
                Session["loginError"] = "用户名或密码错误！";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
            }
            else
            {
                Session["loginSession"] = username;
                if (checkBoxTeacher.Checked)
                {
                    Session["loginIden"] = "Teacher";
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "","location.href='/Teacher/Default.aspx';", true);
                }
                else
                {
                    Session["loginIden"] = "Student";
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Student/Default.aspx';", true);
                }
            }
        }
    }
}