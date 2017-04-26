using Business_Logic_Layer;
using System;
using System.Web.UI;

namespace User_Interface_Layer.Teacher
{
    public partial class Modify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
            {
                Response.Write("<script>location.href='/Login.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                return;
            }
            else
            {
                if (Session["loginIden"].ToString() != "Teacher")
                {
                    Response.Write("<script>location.href='/Login.aspx';</script>");
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                    return;
                }
                if (Session["modifyErrorMsg"] != null) // 修改失败
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "errorMsg",
                        "$(document).ready(function(){changeBorderColor('#" + Session["modifyErrorID"] + "','" + Session["modifyErrorMsg"] + "');});", true);
                    Session["modifyErrorID"] = null;
                    Session["modifyErrorMsg"] = null;
                }
                if (!IsPostBack)
                {
                    Models.Teacher teacher = BLL_Teacher.query(Session["loginSession"].ToString());
                    inputUsername.Text = teacher.username;
                    selectorSex.SelectedIndex = Boolean.Parse(teacher.sex) ? 0 : 1;
                    inputYear.Text = teacher.age;
                }
            }
        }

        protected void buttonSubmit_Click(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null || Session["loginIden"].ToString() != "Teacher") return;

            string username = Session["loginSession"].ToString();
            string oldpassword = inputOldPassword.Text.Trim();
            string sex = selectorSex.SelectedValue;
            string password = inputPassword.Text.Trim();
            string age = inputYear.Text.Trim();

            if (!BLL_Teacher.login(username, oldpassword))
            {
                Session["modifyErrorID"] = "stdContentMoudle_stdContent_inputOldPassword";
                Session["modifyErrorMsg"] = "原密码输入错误！";
                Response.Write("<script>location.href='/Teacher/Modify.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Teacher/Modify.aspx';", true);
                return;
            }

            Models.Teacher teacher = null;
            if (password.Length == 0) teacher = new Models.Teacher(username, "", sex, age);
            else teacher = new Models.Teacher(username, password, sex, age);

            if (BLL_Teacher.modify(teacher))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('修改成功，刷新页面查看更新后的内容！');", true);
                Response.Write("<script>location.href='/Teacher/Modify.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "transfer", "location.href='/Teacher/Modify.aspx';", true);
            }
            else
            {
                Session["modifyErrorID"] = "stdContentMoudle_stdContent_inputOldPassword";
                Session["modifyErrorMsg"] = "原密码输入错误！";
                Response.Write("<script>location.href='/Teacher/Modify.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Teacher/Modify.aspx';", true);
            }
        }
    }
}