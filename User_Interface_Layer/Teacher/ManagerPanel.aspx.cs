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

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = GridView1.DataKeys[e.RowIndex].Value.ToString();
            BLL_Student.deleteByID(id);
            GridView1.DataBind();
        }
    }
}