using Business_Logic_Layer;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Teacher
{
    public partial class ManageTeam : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
            {
                Response.Write("<script>location.href='/Login.aspx';</script>");
                return;
            }
            else
            {
                if (Session["loginIden"].ToString() != "Teacher")
                {
                    Response.Write("<script>location.href='/Login.aspx';</script>");
                    return;
                }
            }
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if(e.CommandName=="DeleteTeam")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                TextBox textBoxTeamID = (TextBox)ListView1.Items[rowIndex].FindControl("TeamID");
                string teamID = textBoxTeamID.Text;
                if(BLL_Team.deleteTeamByID(teamID)) Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('删除成功！');", true); 
                else Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('删除失败！');", true); 
            }
            else if(e.CommandName=="SaveTeam")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                TextBox textBoxTeamID = (TextBox)ListView1.Items[rowIndex].FindControl("TeamID");
                DropDownList textBoxAuditMode = (DropDownList)ListView1.Items[rowIndex].FindControl("AuditMode");
                DropDownList textBoxScoreType = (DropDownList)ListView1.Items[rowIndex].FindControl("ScoreType");
                //DropDownList textBoxExcelRatio = (DropDownList)ListView1.Items[rowIndex].FindControl("ExcelRatio");
                DropDownList textBoxAnswerStatus = (DropDownList)ListView1.Items[rowIndex].FindControl("AnswerStatus");
                TextBox textBoxCourceName = (TextBox)ListView1.Items[rowIndex].FindControl("CourceName");
                DropDownList textBoxCourceTerm = (DropDownList)ListView1.Items[rowIndex].FindControl("CourceTerm");
                TextBox textBoxStuClass = (TextBox)ListView1.Items[rowIndex].FindControl("StuClass");
                TextBox textBoxIntroduce = (TextBox)ListView1.Items[rowIndex].FindControl("Introduce");
                //TextBox textBoxComment = (TextBox)ListView1.Items[rowIndex].FindControl("Comment");
                Team team = new Team(textBoxTeamID.Text, "", textBoxAuditMode.SelectedValue, textBoxScoreType.SelectedValue, "",
                    textBoxAnswerStatus.SelectedValue, textBoxCourceName.Text, textBoxCourceTerm.SelectedValue, textBoxStuClass.Text, "", textBoxIntroduce.Text, "");
                if(BLL_Team.modifyTeam(team)) Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('保存成功！');", true);
                else Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('保存失败！');", true);
            }
        }
    }
}