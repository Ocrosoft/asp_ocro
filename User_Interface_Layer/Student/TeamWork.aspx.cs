using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Interface_Layer.Student
{
    public partial class TeamWork : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region 添加表头
            TableHeaderRow headerRow = new TableHeaderRow();
            TableHeaderCell headerCell = new TableHeaderCell();
            headerCell.Text = "课程号";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "课程";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "班级";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "所在学期";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "任课教师";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "当前状态";
            headerRow.Cells.Add(headerCell);
            headerCell = new TableHeaderCell();
            headerCell.Text = "操作";
            headerRow.Cells.Add(headerCell);
            headerRow.BackColor = System.Drawing.Color.FromArgb(68, 114, 196);
            currentClass.Rows.Add(headerRow);
            #endregion
        }
    }
}