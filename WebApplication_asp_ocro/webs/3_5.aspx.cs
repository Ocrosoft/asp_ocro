using System;
using System.Data;
using System.Web.UI.WebControls;

namespace WebApplication_asp_ocro.webs
{
    public partial class _3_5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
            {
                Response.Write("<script>window.location.href='/webs/3.aspx';</script>");
            }
            else
            {
                if ((string)Session["loginIden"] != "Teacher")
                {
                    Response.Write("<script>alert('You can't be view this page!')</script>");
                    Response.Write("<script>history.go(-1);</script>");
                    return;
                }
            }
            //if (!IsPostBack)
            {
                string sql = "select username,sex,grade,age,major,IP,regtime from users;";
                DataTable table = MysqlHelper.ExecuteDataTable(sql);

                TableHeaderRow row = new TableHeaderRow();
                TableHeaderCell cell = new TableHeaderCell();
                cell.Text = "Username";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "Sex";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "Grade";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "Age";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "Major";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "IP";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "RegTime";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "Edit";
                row.Cells.Add(cell);
                cell = new TableHeaderCell();
                cell.Text = "Delete";
                row.Cells.Add(cell);
                row.BackColor = System.Drawing.Color.FromArgb(68, 114, 196);
                registedUser.Rows.Add(row);

                int index = 0;
                foreach (DataRow dr in table.Rows)
                {
                    TableRow myRow = new TableRow();
                    if (index++ % 2 == 0) myRow.BackColor = System.Drawing.Color.FromArgb(217, 226, 243);
                    else myRow.BackColor = System.Drawing.Color.FromArgb(255, 255, 255);
                    for (int i = 0; i < 7; i++)
                    {
                        TableCell myCell = new TableCell();
                        if (i == 1) myCell.Text = (dr[i].ToString() == "True" ? "Male" : "Female");
                        else myCell.Text = dr[i].ToString();
                        myRow.Cells.Add(myCell);
                    }
                    TableCell delCell = new TableCell();
                    LinkButton lb = new LinkButton();
                    lb.ID = "LinkEditButton_" + (index - 1).ToString();
                    lb.Text = "Edit";
                    lb.Click += new EventHandler(Button_Edit);
                    delCell.Controls.Add(lb);
                    myRow.Cells.Add(delCell);
                    delCell = new TableCell();
                    lb = new LinkButton();
                    lb.ID = "LinkButton_" + (index - 1).ToString();
                    lb.Text = "Delete";
                    lb.Click += new EventHandler(Button_Delete);
                    delCell.Controls.Add(lb);
                    myRow.Cells.Add(delCell);
                    registedUser.Rows.Add(myRow);
                }
            }
        }

        protected void Button_Delete(object sender, EventArgs e)
        {
            LinkButton lb = (LinkButton)sender;
            string id = lb.ID;
            id = id.Substring(id.IndexOf("_") + 1);
            Response.Write("<script>alert('行ID:"+id+"(目前不会真正删除)');</script>");
        }

        protected void Button_Edit(object sender, EventArgs e)
        {
            Response.Write("<script>alert('未完成');</script>");
        }
    }
}