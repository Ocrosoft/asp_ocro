using Business_Logic_Layer;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
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
            Session["loginSession"] = "Teacher01";
            Session["loginIden"] = "Teacher";
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
            if (!IsPostBack) lastShow.Value = null;
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
            else if(e.CommandName=="ShowMember")
            {
                try
                {
                    int index = Convert.ToInt32(lastShow.Value);
                    GridView gv = (GridView)ListView1.Items[index].FindControl("panel_hide").FindControl("members");
                    gv.DataSource = null;
                    gv.DataBind();
                }
                catch { }
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                TextBox textBoxTeamID = (TextBox)ListView1.Items[rowIndex].FindControl("TeamID");
                string teamID = textBoxTeamID.Text;
                GridView gridView = (GridView)ListView1.Items[rowIndex].FindControl("panel_hide").FindControl("members");
                DataSet ds = BLL_Team.queryMember(teamID);
                ds.Tables[0].Columns[0].ColumnName = "用户名";
                ds.Tables[0].Columns[1].ColumnName = "专业";
                ds.Tables[0].Columns[2].ColumnName = "审核状态";
                gridView.DataSource = ds;
                gridView.DataBind();
                lastShow.Value = rowIndex.ToString();
            }
        }
        protected void GridView_RowDataBinding(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells.Count < 4) return;
                Button button_Operation = (Button)e.Row.Cells[0].Controls[1];
                string auditStatus = e.Row.Cells[3].Text;
                if (auditStatus != "待审核") button_Operation.Enabled = false;
                e.Row.Cells.Add(e.Row.Cells[0]);
            }
        }
    }
}