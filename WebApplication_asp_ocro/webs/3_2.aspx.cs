using System;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3_2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
            if (!IsPostBack)
            {
                labelIden.Text = Session["loginIden"] + " " + Session["loginSession"];
            }
        }
        protected void Click_Back(object sender, EventArgs e)
        {
            Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
        }
    }
}