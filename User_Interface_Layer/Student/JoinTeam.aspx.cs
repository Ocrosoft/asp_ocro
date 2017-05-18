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
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ButtonJoin")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                TextBox textBoxTeamID = (TextBox)GridView1.Rows[rowIndex].FindControl("TeamID");
                string teamID = textBoxTeamID.Text;

            }
        }
    }
}