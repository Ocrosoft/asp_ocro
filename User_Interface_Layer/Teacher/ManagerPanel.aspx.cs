using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Teacher
{
    public partial class ManagerPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["loginSession"] == null)
            //{
            //    Response.Write("<script>location.href='/Login.aspx';</script>");
            //    return;
            //}
            //else
            //{
            //    if (Session["loginIden"].ToString() != "Teacher")
            //    {
            //        Response.Write("<script>location.href='/Login.aspx';</script>");
            //        return;
            //    }
            //}
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //如果是绑定数据行 
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.Cells[0].Controls[2]).Attributes.Add("onclick", "javascript:return confirm('你确认要删除吗?')");
                }
            } 
        }

        protected void GridView1_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {

        }
    }
}