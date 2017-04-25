using System;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace User_Interface_Layer.Admin
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminSession"] != null) // 已经登录
            {
                
                return;
            }
            if (Session["adminLoginError"] != null) // 登录失败
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "",
                    "$(document).ready(function(){changeBorderColor('#" + Session["adminLoginErrorID"] + "','" + Session["adminLoginError"] + "');});", true);
                Session["adminLoginErrorID"] = null;
                Session["adminLoginError"] = null;
            }
        }
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
            
            if (!checkcode_user.Equals(checkcode_correct)) // 校验验证码
            {
                Session["adminLoginErrorID"] = "stdContentMoudle_stdContent_checkCode";
                Session["adminLoginError"] = "验证码错误！";
                Response.Write("<script>location.href='Default.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='Default.aspx';", true);
                return;
            }

            bool loginResult = false;

            if (!loginResult) // 登录失败
            {
                Session["adminLoginErrorID"] = "stdContentMoudle_stdContent_inputPassword";
                Session["adminLoginError"] = "用户名或密码错误！";
                Response.Write("<script>location.href='Default.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='Default.aspx';", true);
            }
            else
            {
                Session["adminLoginError"] = username;
            }
        }
    }
}