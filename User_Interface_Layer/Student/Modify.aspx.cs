using Business_Logic_Layer;
using System;
using System.Web.UI;

namespace User_Interface_Layer.Student
{
    public partial class Modify : Page
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
                if (Session["loginIden"].ToString() != "Student")
                {
                    Response.Write("<script>location.href='/Login.aspx';</script>");
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                    return;
                }
                if (Session["modifyErrorMsg"] != null) // 修改失败
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "errorMsg",
                        "$(document).ready(function(){changeBorderColor('#" + Session["modifyErrorMsg"] + "','" + Session["modifyErrorMsg"] + "');});", true);
                    Session["modifyErrorID"] = null;
                    Session["modifyErrorMsg"] = null;
                }
                if (!IsPostBack)
                {
                    Models.Student student = BLL_Student.query(Session["loginSession"].ToString());
                    inputUsername.Text = student.username;
                    selectorSex.SelectedIndex = Boolean.Parse(student.sex) ? 0 : 1;
                    inputYear.Text = student.age;
                    selectGrade.SelectedValue = student.grade;
                    selectMajor.SelectedValue = student.major;
                }
            }
        }

        protected void buttonSubmit_Click(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null || Session["loginIden"].ToString() != "Student") return;

            string username = Session["loginSession"].ToString();
            string oldpassword = inputOldPassword.Text.Trim();
            string password = inputPassword.Text.Trim();
            string sex = selectorSex.SelectedIndex == 0 ? "1" : "0";
            string age = inputYear.Text.Trim();
            string grade = selectGrade.SelectedValue;
            string major = selectMajor.SelectedValue;

            if (!BLL_Student.login(username, oldpassword))
            {
                Session["modifyErrorID"] = "stdContentMoudle_stdContent_inputOldPassword";
                Session["modifyErrorMsg"] = "原密码输入错误！";
                Response.Write("<script>location.href='/Student/Modify.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Student/Modify.aspx';", true);
                return;
            }

            Models.Student student = null;
            if (password.Length == 0) student = new Models.Student(username, "", sex, grade, age, major, "", "");
            else student = new Models.Student(username, password, sex, grade, age, major, "", "");

            if (BLL_Student.modify(student))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('修改成功，刷新页面查看更新后的内容！');", true);
                Response.Write("<script>location.href='/Student/Modify.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "transfer", "location.href='/Student/Modify.aspx';", true);
            }
            else
            {
                Session["modifyErrorID"] = "stdContentMoudle_stdContent_inputOldPassword";
                Session["modifyErrorMsg"] = "原密码输入错误！";
                Response.Write("<script>location.href='/Student/Modify.aspx';</script>");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Student/Modify.aspx';", true);
            }
        }
    }
}