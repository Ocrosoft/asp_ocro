using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.UI;
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
                return;
            }
            else
            {
                if ((string)Session["loginIden"] != "Teacher")
                {
                    Response.Write("<script>history.go(-1);</script>");
                    return;
                }
            }

            if (Session["editID"] == null) refreshBind();
            else
            {
                refreshBind(true, (int)Session["editID"]);
                Session["editID"] = null;
            }
        }

        protected void Button_Delete(object sender, EventArgs e)
        {
            LinkButton lb = (LinkButton)sender;
            string id = lb.ID;
            id = id.Substring(id.IndexOf("_") + 1);
            string sql = "delete from users where id=?1";
            MySqlParameter[] para = new MySqlParameter[1];
            para[0] = new MySqlParameter("?1", id);
            int res = MysqlHelper.ExecuteNonQuery(sql, para);
            if (res > 0) ScriptManager.RegisterStartupScript(UpdatePanel1, GetType(), "", "$('#refresh').click();", true);
        }

        protected void Button_Edit(object sender, EventArgs e)
        {
            LinkButton lb = (LinkButton)sender;
            string id = lb.ID;
            id = id.Substring(id.IndexOf("_") + 1);
            Session["editID"] = Int32.Parse(id);
            ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "", "$('#refresh').click();", true);
        }

        protected void refreshBind(bool edit = false, int editID = 0)
        {
            string sql = "select username,sex,grade,age,major,IP,regtime,id from users;";
            DataTable table = MysqlHelper.ExecuteDataTable(sql);

            TableHeaderRow row = new TableHeaderRow();
            TableHeaderCell cell = new TableHeaderCell();
            cell.Text = "用户名";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "性别";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "年级";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "年龄";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "专业";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "IP";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "注册时间";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "编辑";
            row.Cells.Add(cell);
            cell = new TableHeaderCell();
            cell.Text = "删除";
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
                    if (edit && (int)dr[7] == editID && i >= 0 && i <= 4)
                    {
                        DropDownList ddl;
                        TextBox tb;
                        switch (i)
                        {
                            case 0:
                                tb = new TextBox();
                                tb.Text = dr[i].ToString();
                                myCell.Controls.Add(tb);
                                break;
                            case 1:
                                ddl = new DropDownList();
                                ddl.Items.Add(new ListItem("男", "1"));
                                ddl.Items.Add(new ListItem("女", "0"));
                                ddl.SelectedIndex = dr[i].ToString() == "True" ? 0 : 1;
                                myCell.Controls.Add(ddl);
                                break;
                            case 2:
                                ddl = new DropDownList();
                                ddl.Items.Add(new ListItem("2016", "2016"));
                                ddl.Items.Add(new ListItem("2015", "2015"));
                                ddl.Items.Add(new ListItem("2014", "2014"));
                                ddl.Items.Add(new ListItem("2013", "2013"));
                                ddl.SelectedValue = dr[i].ToString();
                                myCell.Controls.Add(ddl);
                                break;
                            case 3:
                                tb = new TextBox();
                                tb.Text = dr[i].ToString();
                                myCell.Controls.Add(tb);
                                break;
                            case 4:
                                ddl = new DropDownList();
                                ddl.Items.Add(new ListItem("电子商务", "电子商务"));
                                ddl.Items.Add(new ListItem("计算机", "计算机"));
                                ddl.Items.Add(new ListItem("软件工程", "软件工程"));
                                ddl.Items.Add(new ListItem("信息技术", "信息技术"));
                                ddl.SelectedValue = dr[i].ToString();
                                myCell.Controls.Add(ddl);
                                break;
                        }
                    }
                    else
                    {
                        if (i == 1) myCell.Text = (dr[i].ToString() == "True" ? "男" : "女");
                        else myCell.Text = dr[i].ToString();
                    }
                    myRow.Cells.Add(myCell);
                }
                TableCell delCell = new TableCell();
                LinkButton lb = new LinkButton();
                lb.CssClass = "linkButtonEdit";
                if (edit && (int)dr[7] == editID)
                {
                    lb.ID = "LinkAcceptButton_" + dr[7].ToString();
                    lb.Text = "确认";
                    lb.Click += new EventHandler(Button_AcceptEdit);
                }
                else
                {
                    lb.ID = "LinkEditButton_" + dr[7].ToString();
                    lb.Text = "修改";
                    lb.Click += new EventHandler(Button_Edit);
                }
                delCell.Controls.Add(lb);
                myRow.Cells.Add(delCell);
                delCell = new TableCell();
                lb = new LinkButton();
                lb.CssClass = "DeleteButton";
                lb.ID = "LinkButton_" + dr[7].ToString();
                lb.Text = "删除";
                lb.Click += new EventHandler(Button_Delete);
                delCell.Controls.Add(lb);
                myRow.Cells.Add(delCell);
                registedUser.Rows.Add(myRow);
            }
        }

        protected void Button_AcceptEdit(object sender, EventArgs e)
        {
            Response.Write("<script>location.href=/webs/3.aspx;</script>");
        }
    }
}