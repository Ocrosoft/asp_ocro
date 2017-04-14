using System;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3_2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
            {
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }

            if (Session["loginIden"].ToString() == "User") labelIden.Text = "你是学生，用户名是：";
            else labelIden.Text = "您是教师，<br/>用户名是：";
            labelIden.Text += Session["loginSession"];
        }
    }
}