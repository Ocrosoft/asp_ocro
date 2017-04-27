using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Student
{
    public partial class ProjectWork : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region 添加表头
            TableHeaderRow headerRow = new TableHeaderRow();
            TableHeaderCell headerCell = new TableHeaderCell();
            headerCell.Text = "编号";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "类型";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "项目名称";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "项目要求";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "提交截止";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "答辩序号";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "互评成绩";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "提交项目";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "项目互评";
            headerRow.Cells.Add(headerCell);
            headerRow.BackColor = System.Drawing.Color.FromArgb(68, 114, 196);
            currentClass.Rows.Add(headerRow);
            #endregion
        }
    }
}