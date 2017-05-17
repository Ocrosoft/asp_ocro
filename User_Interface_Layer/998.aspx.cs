using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer
{
    public partial class _998 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string url = Request.QueryString["url"];
                splj.Text = url;
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "play", "$(document).ready(function(){play();});", true);
            }
            catch { }
        }
    }
}