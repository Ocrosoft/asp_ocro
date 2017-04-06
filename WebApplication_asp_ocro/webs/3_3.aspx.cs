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
            {
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
            }
            else
            {
                if ((string)Session["loginIden"] == "Teacher")
                {
                    Response.Write("<script>alert('You can't edit your profile as teacher!')</script>");
                    Response.Write("<script>history.go(-1);</script>");
                    return;
                }
                if (!IsPostBack)
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
                        selectGrade.SelectedIndex = (int)dataTable.Rows[0]["grade"] - 1;
                        inputMajor.Text = dataTable.Rows[0]["major"].ToString();
                    }
                }
            }
        }

        protected void buttonSubmit_Click(object sender, EventArgs e)
        {
            if ((string)Session["loginIden"] == "Teacher") return;

            string username = inputUsername.Text.Trim();
            string user_name = Session["loginSession"].ToString();
            if (username != user_name) return;
            string oldpassword = inputOldPassword.Text;
            oldpassword = MyMD5.MD5(oldpassword);

            string password = inputPassword.Text.Trim();
            if (password.Length != 0)
            {
                password = MyMD5.MD5(password);
                password = password.ToUpper();
            }
            string year = inputYear.Text;
            string grade = selectGrade.SelectedValue;

            try
            {
                string sql = "";
                int res = 0;
                if(password.Length!=0)
                {
                    sql = "update users set password=?1, grade=?2, age=?3 where username=?4 and password=?5;";
                    MySqlParameter[] para = new MySqlParameter[5];
                    para[0] = new MySqlParameter("?1", password);
                    para[1] = new MySqlParameter("?2", grade);
                    para[2] = new MySqlParameter("?3", year);
                    para[3] = new MySqlParameter("?4", username);
                    para[4] = new MySqlParameter("?5", oldpassword);
                    res = MysqlHelper.ExecuteNonQuery(sql, para);
                }
                else
                {
                    sql = "update users set grade=?1, age=?2 where username=?3 and password=?4;";
                    MySqlParameter[] para = new MySqlParameter[4];
                    para[0] = new MySqlParameter("?1", grade);
                    para[1] = new MySqlParameter("?2", year);
                    para[2] = new MySqlParameter("?3", username);
                    para[3] = new MySqlParameter("?4", oldpassword);
                    res = MysqlHelper.ExecuteNonQuery(sql, para);
                }
                if (res > 0)
                {
                    Response.Write("<script>alert('Succeed! Refresh for you to see the result!');</script>");
                    Response.Write("<script>window.location.href='/webs/3_3.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Faild, please check your password!');</script>");
                    Response.Write("<script>window.location.href='/webs/3_3.aspx';</script>");
                }
            }
            catch
            {
                Response.Write("<script>alert('Faild, server error!');</script>");
                Response.Write("<script>window.location.href='/webs/3_3.aspx';</script>");
                return;
            }
        }
    }
}