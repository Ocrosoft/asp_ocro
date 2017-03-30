using MySql.Data.MySqlClient;
using System;
using System.Data;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3_3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
            else
            {
                string sql = "select username,sex,grade,age,major from users where username=?1;";
                MySqlParameter[] para = new MySqlParameter[1];
                para[0] = new MySqlParameter("?1", Session["loginSession"]);
                DataTable dataTable = MysqlHelper.ExecuteDataTable(sql, para);
                if (dataTable != null)
                {
                    int rows = dataTable.Rows.Count;
                    inputUsername.Text = dataTable.Rows[0]["username"].ToString();
                    if ((bool)dataTable.Rows[0]["sex"]) selectorSex.SelectedIndex = 0;
                    else selectorSex.SelectedIndex = 1;
                    inputYear.Text = dataTable.Rows[0]["age"].ToString();
                    selectGrade.SelectedIndex = (int)dataTable.Rows[0]["grade"]- 1;
                    inputMajor.Text = dataTable.Rows[0]["major"].ToString();
                }
            }
        }
    }
}