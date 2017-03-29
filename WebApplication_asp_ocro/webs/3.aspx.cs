using MySql.Data.MySqlClient;
using System;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Click_Login(object sender, EventArgs e)
        {
            string user_name, pass_word;
            user_name = inputUsername.Text.Trim();
            pass_word = inputPassword.Text.Trim();
            pass_word = MyMD5.MD5(pass_word);
            pass_word = pass_word.ToUpper();
            string check_code = Session["CheckCode"].ToString();
            string check_Code = checkCode.Text.Trim();
            if (user_name.Trim().Length == 0)
            {
                Response.Write("<script>alert('Please enter your username!');</script>");
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            else if (pass_word.Trim().Length == 0)
            {
                Response.Write("<script>alert('Please enter your password!');</script>");
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            if (!check_code.Equals(check_Code))
            {
                Response.Write("<script>alert('Incorrect checkcode!');</script>");
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            object obj = null;
            try
            {
                string sql = "select username from users where username=?1 and password=?2;";
                MySqlParameter[] para = new MySqlParameter[2];
                para[0] = new MySqlParameter("?1", user_name);
                para[1] = new MySqlParameter("?2", pass_word);
                obj = MysqlHelper.ExecuteScalar(sql, para);
            }
            catch
            {
                Response.Write("<script>alert('Services is not available!');</script>");
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            if (Equals(obj, null))
            {
                Response.Write("<script>alert('Username or password wrong!');</script>");
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
                return;
            }
            else
            {
                Response.Write("<script>window.location.href='/webs/3_2.aspx';</script>");
            }
        }
    }
}