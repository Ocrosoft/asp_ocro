using System;

namespace User_Interface_Layer.Student
{
    public partial class Default : System.Web.UI.Page
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
                if(Session["loginIden"].ToString()!="Student")
                {
                    Response.Write("<script>location.href='/Login.aspx';</script>");
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                    return;
                }
            }
            //labelIden.Text = Session["loginSession"].ToString();
        }
    }
}