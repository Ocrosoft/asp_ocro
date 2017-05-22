using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Student
{
    public partial class JoinClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["loginSession"] = "stu01";
            Session["loginIden"] = "Student";
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
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (Session["loginSession"] == null) return;
            if(e.Row.RowType==DataControlRowType.DataRow &&
                (e.Row.RowState==DataControlRowState.Normal||e.Row.RowState==DataControlRowState.Alternate))
            {
                string teamID = ((DataRowView)e.Row.DataItem).Row.ItemArray[0].ToString();
                string auditStatus = BLL_Team.queryJoinStatus(teamID, Session["loginSession"].ToString());
                Label labelAuditStatus = (Label)e.Row.FindControl("JoinStatus");
                labelAuditStatus.Text = auditStatus;
                if (auditStatus != "未加入")
                {
                    Button joinButton = (Button)e.Row.FindControl("ButtonJoin");
                    joinButton.Text = "退出";
                    joinButton.CssClass = "btn btn-warning form-control";
                    //joinButton.Enabled = false;
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "JoinTeam")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string teamID = GridView1.Rows[rowIndex].Cells[0].Text;
                string status = BLL_Team.queryJoinStatus(teamID, Session["loginSession"].ToString());
                if (status == "未加入")
                {
                    if (BLL_Team.joinTeam(teamID, Session["loginSession"].ToString()))
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('加入成功！');", true);
                    else Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('加入失败！');", true);
                }
                else
                {
                    if (BLL_Team.quitTeam(teamID, Session["loginSession"].ToString()))
                                   Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('退出成功！');", true);
                    else Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('退出失败！');", true);
                }
                    GridView1.DataBind();
            }
        }
    }
}