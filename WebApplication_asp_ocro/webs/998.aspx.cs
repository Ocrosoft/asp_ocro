using System;
using System.Data;
using System.Web.UI;

namespace WebApplication_asp_ocro.webs
{
    public partial class _998 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string sql = "select recordDate,areaName,value from aqi where recordDate='2013-01-01';";
            DataTable table = MysqlHelper.ExecuteDataTable(sql);
            GridView1.DataSource = table;
            GridView1.DataBind();
        }
    }
}