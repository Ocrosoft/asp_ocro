using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication_asp_ocro.webs
{
    public partial class _2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void calculate2_Click(object sender, EventArgs e)
        {
            double num1, num2;
            try
            {
                num1 = Convert.ToInt32(number1.Text);
                num2 = Convert.ToInt32(number2.Text);
            }
            catch
            {
                result.Text = "ERROR!";
                return;
            }
            string op = operation.SelectedValue;
            if (num2 == 0 && op == "/") { result.Text = "ERROR!"; return; }

            double res = 0;
            if (op == "+") res = num1 + num2;
            else if (op == "-") res = num1 - num2;
            else if (op == "*") res = num1 * num2;
            else if (op == "/") res = num1 / num2;
            result.Text = res.ToString();
        }
    }
}