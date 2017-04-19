using Business_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Teacher
{
    public partial class ManagerPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginSession"] == null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                return;
            }
            else
            {
                if (Session["loginIden"].ToString() != "Teacher")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "location.href='/Login.aspx';", true);
                    return;
                }
            }

            if (Session["editID"] == null)
            {
                refreshBind();
            }
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
            if (BLL_Student.deleteByID(id))
            {
                ScriptManager.RegisterStartupScript(UpdatePanel1, GetType(), "", "$('#refresh').click();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(UpdatePanel1, GetType(), "error", "alert('删除失败！');", true);
                ScriptManager.RegisterStartupScript(UpdatePanel1, GetType(), "transfer", "$('#refresh').click();", true);
            }
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
            List<Models.Student> list = BLL_Student.queryAllStudent();

             #region 添加表头
            TableHeaderRow headerRow = new TableHeaderRow();
            TableHeaderCell headerCell = new TableHeaderCell();
            headerCell.Text = "用户名";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "性别";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "年级";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "年龄";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "专业";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "IP";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "注册时间";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "编辑";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "删除";
            headerRow.Cells.Add(headerCell);
            headerRow.BackColor = System.Drawing.Color.FromArgb(68, 114, 196);
            registedUser.Rows.Add(headerRow);
#endregion

            int index = 0;
            foreach (Models.Student student in list)
            {
                TableRow row = new TableRow();
                if (index++ % 2 == 0) row.BackColor = System.Drawing.Color.FromArgb(217, 226, 243); // 奇偶行颜色不同
                else row.BackColor = System.Drawing.Color.FromArgb(255, 255, 255);

                #region 主要信息
                TableCell cell_username = new TableCell();
                TableCell cell_sex = new TableCell();
                TableCell cell_grade = new TableCell();
                TableCell cell_age = new TableCell();
                TableCell cell_major = new TableCell();
                TableCell cell_IP = new TableCell();
                TableCell cell_regtime = new TableCell();
                if (edit && Int32.Parse(student.id)==editID)
                {
                    // 用户名
                    TextBox tb_username = new TextBox();
                    tb_username.Text = student.username;
                    cell_username.Controls.Add(tb_username);
                    // 性别
                    DropDownList ddl_sex = new DropDownList();
                    ddl_sex.Items.Add(new ListItem("男", "1"));
                    ddl_sex.Items.Add(new ListItem("女", "0"));
                    ddl_sex.SelectedIndex = student.sex == "True" ? 0 : 1;
                    cell_sex.Controls.Add(ddl_sex);
                    // 年级
                    DropDownList ddl_grade = new DropDownList();
                    ddl_grade.Items.Add(new ListItem("2016", "2016"));
                    ddl_grade.Items.Add(new ListItem("2015", "2015"));
                    ddl_grade.Items.Add(new ListItem("2014", "2014"));
                    ddl_grade.Items.Add(new ListItem("2013", "2013"));
                    ddl_grade.SelectedValue = student.grade;
                    cell_grade.Controls.Add(ddl_grade);
                    // 年龄
                    TextBox tb_age = new TextBox();
                    tb_age.Text = student.age;
                    cell_age.Controls.Add(tb_age);
                    // 专业
                    DropDownList ddl_major = new DropDownList();
                    ddl_major.Items.Add(new ListItem("电子商务", "电子商务"));
                    ddl_major.Items.Add(new ListItem("计算机", "计算机"));
                    ddl_major.Items.Add(new ListItem("软件工程", "软件工程"));
                    ddl_major.Items.Add(new ListItem("信息技术", "信息技术"));
                    ddl_major.SelectedValue = student.major;
                    cell_major.Controls.Add(ddl_major);
                    // IP
                    cell_IP.Text = student.IP;
                    // 注册时间
                    cell_regtime.Text = student.regtime;
                }
                else
                {
                    cell_username.Text = student.username;
                    cell_sex.Text = student.sex == "True" ? "男" : "女";
                    cell_grade.Text = student.grade;
                    cell_age.Text = student.age;
                    cell_major.Text = student.major;
                    cell_IP.Text = student.IP;
                    cell_regtime.Text = student.regtime;
                }
                row.Cells.Add(cell_username);
                row.Cells.Add(cell_sex);
                row.Cells.Add(cell_grade);
                row.Cells.Add(cell_age);
                row.Cells.Add(cell_major);
                row.Cells.Add(cell_IP);
                row.Cells.Add(cell_regtime);
                #endregion

                TableCell cell_edit_accept = new TableCell();
                LinkButton lb_edit_accept = new LinkButton();
                if(edit && Int32.Parse(student.id)==editID)
                {
                    lb_edit_accept.CssClass = "linkButtonAccept";
                    lb_edit_accept.ID = "LinkAcceptButton_" + student.id;
                    lb_edit_accept.Text = "确认";
                    lb_edit_accept.Click += new EventHandler(Button_AcceptEdit);
                }
                else
                {
                    lb_edit_accept.CssClass = "linkButtonEdit";
                    lb_edit_accept.ID = "LinkEditButton_" + student.id;
                    lb_edit_accept.Text = "修改";
                    lb_edit_accept.Click += new EventHandler(Button_Edit);
                }
                cell_edit_accept.Controls.Add(lb_edit_accept);
                row.Cells.Add(cell_edit_accept);

                TableCell cell_delete = new TableCell();
                LinkButton lb_delete = new LinkButton();
                lb_delete.CssClass = "DeleteButton";
                lb_delete.ID = "LinkButton_" + student.id;
                lb_delete.Text = "删除";
                lb_delete.Click += new EventHandler(Button_Delete);
                cell_delete.Controls.Add(lb_delete);
                row.Cells.Add(cell_delete);
                registedUser.Rows.Add(row);
            }
        }

        protected void Button_AcceptEdit(object sender, EventArgs e)
        {
            //ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "", "alert('确定');", true);
        }

    }
}