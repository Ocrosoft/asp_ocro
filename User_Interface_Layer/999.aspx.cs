using Business_Logic_Layer;
using System;

namespace User_Interface_Layer
{
    public partial class _999 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataSource = BLL_DataViewer.QueryAQI();
            GridView1.DataBind();
        }
    }
}