using System;

namespace WebApplication_asp_ocro
{
    public partial class Naster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();
            Server.Transfer("/webs/3.aspx");
            //Response.Write("<script>window.loaction.href='/webs/3.aspx';</script>");
        }
    }
}