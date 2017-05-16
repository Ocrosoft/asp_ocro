using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Teacher
{
    public partial class ManageTeam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if(e.CommandName=="DeleteTeam")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                TextBox TeamID = (TextBox)ListView1.Items[rowIndex].FindControl("TeamID");
            }
        }
    }
}