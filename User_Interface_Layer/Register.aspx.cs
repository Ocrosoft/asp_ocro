using Business_Logic_Layer;
using System;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace User_Interface_Layer
{
    public partial class Register : System.Web.UI.Page
    {
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
            string age = inputYear.Text.Trim();
            string grade = selectGrade.SelectedValue;
            string major = selectMajor.SelectedValue;
            string checkcode_correct = Session["CheckCode"].ToString(); // 正确验证码
            string checkcode_user = checkCode.Text.Trim();
            string ip = BLL_IP.GetIP();
            DateTime dtime = DateTime.Now;
            string time = dtime.ToString();

            if (!Regex.IsMatch(username, @"^[0-9a-zA-Z_]{1,21}$") ||
                !Regex.IsMatch(password, @"^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$") ||
                password != repassword
                ) // 非法请求
            {
                return;
            }
            if (!checkcode_correct.Equals(checkcode_user))
            {
                Session["regErrorID"] = "stdContentMoudle_stdContent_checkCode";
                Session["regError"] = "验证码错误！";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Register.aspx';", true);
                return;
            }

            Models.Student student =  new Models.Student(username, password, sex, grade, age, major, ip, time); ;
            if(BLL_Student.register(student))
            {
                Session["regSuccess"] = username;
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
            }
            else
            {
                Session["regErrorID"] = "stdContentMoudle_stdContent_inputUsername";
                Session["regError"] = "注册失败，请更换用户名后重试！";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Register.aspx';", true);
            }
        }
    }
}