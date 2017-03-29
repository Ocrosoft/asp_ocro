using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication_asp_ocro.webs
{
    public partial class _2_2 : Page
    {
        public decimal _num1
        {
            get { return (decimal)ViewState["num1"]; }
            set { ViewState["num1"] = value; }
        }
        public decimal _num2
        {
            get { return (decimal)ViewState["num2"]; }
            set { ViewState["num2"] = value; }
        }
        public decimal _result
        {
            get { return (decimal)ViewState["result"]; }
            set { ViewState["result"] = value; }
        }
        public string _operator
        {
            get { return (string)ViewState["operator"]; }
            set { ViewState["operator"] = value; }
        }
        public bool _calFinished
        {
            get { return (bool)ViewState["calFinished"]; }
            set { ViewState["calFinished"] = value; }
        }
        public bool _firstOperator
        {
            get { return (bool)ViewState["firstOperator"]; }
            set { ViewState["firstOperator"] = value; }
        }
        public bool _seCalFinished
        {
            get { return (bool)ViewState["seCalFinished"]; }
            set { ViewState["seCalFinished"] = value; }
        }
        public bool _changeOperator
        {
            get { return (bool)ViewState["changeOperator"]; }
            set { ViewState["changeOperator"] = value; }
        }
        public bool _spOped // 进行过特殊操作（sqr、sqrt）
        {
            get { return (bool)ViewState["spOped"]; }
            set { ViewState["spOped"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (Object o in ViewState.Keys)
            {
                if (o.ToString().IndexOf("loaded") != -1) return;
            }

            ViewState["loaded"] = true;
            textBoxPath.ReadOnly = true;
            textBoxRes.ReadOnly = true;
            titleLine.ReadOnly = true;
            textBoxRes.Text = "0";

            _num1 = 0; _num2 = 0; _result = 0;
            _operator = "#";
            _calFinished = true; _firstOperator = false; _seCalFinished = true; _changeOperator = false; _spOped = false;
        }
        protected void num_Click(object sender, EventArgs e)
        {
            _changeOperator = false; // 如果点击了数字，认为不会再切换运算符
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; } // 除0错误
            if (_spOped) // 如果进行过特殊运算，但是又没有点击运算符，则取消特殊运算，认为是修改为输入的数字
            {
                int opIndex = textBoxPath.Text.LastIndexOf(operatorToView(_operator));
                if (opIndex != -1) // 如果没有操作符，表示第一个数字就进行了特殊运算
                {
                    textBoxPath.Text = textBoxPath.Text.Substring(0, opIndex + 2);
                }
                else textBoxPath.Text = "";

                textBoxRes.Text = "0";
                _spOped = false;
            }
            if (_calFinished)
            {
                textBoxRes.Text = "0";
                _calFinished = false;
                _firstOperator = true;
            }
            if (_seCalFinished)
            {
                textBoxRes.Text = "0";
                _seCalFinished = false;
            }
            if (textBoxRes.Text.Length < 19 || textBoxRes.Text.IndexOf("E") != -1) // 防止输入过长
            {
                Button s = (Button)sender;
                if (textBoxRes.Text == "0") textBoxRes.Text = s.Text;
                else textBoxRes.Text = textBoxRes.Text + s.Text;
            }
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected void dot_Click(object sender, EventArgs e)
        {
            _changeOperator = false;
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; }
            if (_spOped) { textBoxRes.Text = "0"; _spOped = false; }
            if (textBoxRes.Text.IndexOf(".") == -1)
            {
                if (_calFinished == true)
                {
                    textBoxRes.Text = "0";
                    _calFinished = false;
                    _firstOperator = true;
                }
                if (_seCalFinished == true)
                {
                    textBoxRes.Text = "0";
                    _seCalFinished = false;
                }
                textBoxRes.Text = textBoxRes.Text + ".";
            }
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected void op_Click(object sender, EventArgs e)
        {
            Button s = (Button)sender;
            if (_changeOperator && _operator != viewToOperator(s.Text)) // 改变符号
            {
                string path = textBoxPath.Text;
                string subStr = path.Substring(path.LastIndexOf(operatorToView(_operator)));
                subStr = subStr.Replace(operatorToView(_operator)[0], s.Text[0]);
                textBoxPath.Text = path.Substring(0, path.LastIndexOf(operatorToView(_operator))) + subStr;
                _operator = viewToOperator(s.Text);
                return;
            }
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; } // 除0错误
            try
            {
                if (_calFinished == false && _firstOperator == false)
                {
                    if (!_spOped) // 如果进行过特殊计算，Path会重复添加结果
                    {
                        textBoxPath.Text = textBoxPath.Text +
                          ((textBoxRes.Text.IndexOf('-') != -1) ? "(" : "") +
                          textBoxRes.Text + ((textBoxRes.Text.IndexOf('-') != -1) ? ")" : "") + " " + s.Text + " ";
                    }
                    else
                    {
                        textBoxPath.Text = textBoxPath.Text + " " + s.Text + " ";
                        _spOped = false;
                    }
                    _num2 = Convert.ToDecimal(textBoxRes.Text);
                    if (_operator == "+") _num1 += _num2;
                    else if (_operator == "-") _num1 -= _num2;
                    else if (_operator == "*") _num1 *= _num2;
                    else if (_operator == "/") _num1 /= _num2;
                    else if (_operator == "%") _num1 %= _num2;
                    textBoxRes.Text = Convert.ToString(_num1);
                    _operator = viewToOperator(s.Text);
                    _seCalFinished = true;
                }
                else // 如果计算已经结束，直接填充Res；是第一个运算符，Res填充0
                {
                    if (!_spOped) { textBoxPath.Text = textBoxRes.Text + " " + s.Text + " "; }
                    else textBoxPath.Text = textBoxPath.Text + " " + s.Text + " ";
                    _operator = viewToOperator(s.Text);
                    _num1 = Convert.ToDecimal(textBoxRes.Text);
                    _num2 = _num1;
                    textBoxRes.Text = "0";
                    _firstOperator = false;
                    _calFinished = false;
                }
                _changeOperator = true;
            }
            catch
            {
                string tmp = textBoxPath.Text;
                buttonClear_Click(null, null);
                textBoxRes.Text = "Cannot divide by zero";
                textBoxPath.Text = tmp;
            }
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected void equ_Click(object sender, EventArgs e)
        {
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; }
            if (_firstOperator) { textBoxPath.Text = ""; }
            try
            {
                if (textBoxPath.Text.IndexOf('=') != -1) // 1,+,2,=,5,=,error
                    textBoxPath.Text = "";
                if (textBoxPath.Text == "") { _calFinished = true; return; } // 1,=,error
                if (_calFinished) return; // 计算已结束

                _num2 = Convert.ToDecimal(textBoxRes.Text);
                if (_operator == "+") _result = _num1 + _num2;
                else if (_operator == "-") _result = _num1 - _num2;
                else if (_operator == "*") _result = _num1 * _num2;
                else if (_operator == "/") _result = _num1 / _num2;
                else if (_operator == "%") _result = _num1 % _num2;
                if (!_spOped)
                {
                    textBoxPath.Text = textBoxPath.Text +
                        ((textBoxRes.Text.IndexOf('-') != -1) ? "(" : "") +
                        Convert.ToString(_num2) +
                        ((textBoxRes.Text.IndexOf('-') != -1) ? ")" : "") + " =";
                }
                else
                {
                    textBoxPath.Text = textBoxPath.Text + " =";
                    _spOped = false;
                }
                textBoxRes.Text = _result.ToString();
                _operator = "#";
                _calFinished = true;
            }
            catch
            {
                string tmp = textBoxPath.Text;
                buttonClear_Click(null, null);
                textBoxRes.Text = "Cannot divide by zero";
                textBoxPath.Text = tmp;
            }
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected void buttonCE_Click(object sender, EventArgs e)
        {
            textBoxRes.Text = "0";
            if (_spOped)
            {
                int opIndex = textBoxPath.Text.LastIndexOf(operatorToView(_operator));
                if (opIndex != -1) // 如果没有操作符，表示第一个数字就进行了特殊运算
                {
                    textBoxPath.Text = textBoxPath.Text.Substring(0, opIndex + 2);
                }
                else textBoxPath.Text = "";
                _spOped = false;
            }
        }
        protected void buttonClear_Click(object sender, EventArgs e)
        {
            textBoxRes.Text = "0";
            textBoxPath.Text = "";
            _firstOperator = false;
            _calFinished = true;
            _operator = "#";
            _spOped = false;
            _seCalFinished = true;
            _num1 = 0; _num2 = 0;
        }
        protected void buttonBksp_Click(object sender, EventArgs e)
        {
            if (errorJudge()) { buttonClear_Click(null, null); return; }
            if (textBoxRes.Text.Length <= 1) textBoxRes.Text = "0";
            else textBoxRes.Text = textBoxRes.Text.Substring(0, textBoxRes.Text.Length - 1);
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected void buttonNega_Click(object sender, EventArgs e)
        {
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; }
            _num2 = Convert.ToDecimal(textBoxRes.Text);
            _num2 = -_num2;
            textBoxRes.Text = _num2.ToString();
            if (_spOped) // 经过特殊操作后nega需要改变path
            {
                int opIndex = textBoxPath.Text.LastIndexOf(operatorToView(_operator));
                if (opIndex != -1) // 如果没有操作符，表示第一个数字就进行了特殊运算
                {
                    string s1 = textBoxPath.Text.Substring(0, opIndex + 2);
                    if (_num2 < 0)
                    {
                        string s3 = textBoxPath.Text.Substring(opIndex + 2);
                        textBoxPath.Text = s1 + "-" + s3;
                    }
                    else
                    {
                        if (_operator == "-")
                        {
                            int opIndex2 = textBoxPath.Text.Substring(0, opIndex - 1).LastIndexOf('-');
                            s1 = s1.Substring(0, opIndex2 + 2);
                            string s3 = textBoxPath.Text.Substring(opIndex2 + 2);
                            textBoxPath.Text = s1 + s3.Remove(s3.IndexOf('-'), 1);
                        }
                        else
                        {
                            string s3 = textBoxPath.Text.Substring(opIndex + 2);
                            textBoxPath.Text = s1 + s3.Remove(s3.IndexOf('-'), 1);
                        }
                    }
                }
                else
                {
                    if (_num2 < 0)
                    {
                        textBoxPath.Text = "-" + textBoxPath.Text;
                    }
                    else
                    {
                        textBoxPath.Text = textBoxPath.Text.Remove(textBoxPath.Text.IndexOf("-"), 1);
                    }
                }
                //ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "alert('bug*1');", true);
            }
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected void buttonClose_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>window.opener=null;window.open('','_self');window.close();</script>");
        }
        protected string operatorToView(string Operator)
        {
            if (Operator == "+") return "+";
            else if (Operator == "-") return "-";
            else if (Operator == "*") return "×";
            else if (Operator == "/") return "÷";
            else if (Operator == "%") return "%";
            return "#";
        }
        protected string viewToOperator(string View)
        {
            if (View == "+") return "+";
            else if (View == "-") return "-";
            else if (View == "×") return "*";
            else if (View == "÷") return "/";
            else if (View == "%") return "%";
            return "#";
        }
        protected void buttonSqrt_Click(object sender, EventArgs e) // 计算Res数值的平方根
        {
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; } // 除0错误
            if (_calFinished) // 计算已经结束，
            {
                string tmp = textBoxRes.Text;
                buttonClear_Click(null, null);
                textBoxRes.Text = tmp;
            }

            _num2 = Convert.ToDecimal(textBoxRes.Text);
            string num2 = textBoxRes.Text;
            if (_num2 < 0)
            {
                string tmp = textBoxPath.Text;
                buttonClear_Click(null, null);
                textBoxRes.Text = "Invalid input";
                textBoxPath.Text = tmp;
            }
            else
            {
                _num2 = (decimal)Math.Sqrt((double)_num2);
                textBoxRes.Text = _num2.ToString();

                string path = textBoxPath.Text;
                int lastOperator = -1;
                for (int i = path.Length - 1; i >= 0; i--)
                    if (path[i] == '+' || path[i] == '-' || path[i] == operatorToView("*")[0] || path[i] == operatorToView("/")[0]) { lastOperator = i; break; }
                if (lastOperator != -1)
                {
                    lastOperator++;
                    string subStr = path.Substring(0, lastOperator);
                    string subStr2 = path.Substring(lastOperator + 1);
                    if (subStr2.IndexOf("√") != -1)
                    {
                        subStr2 = "√(" + subStr2;
                        subStr2 += ")";
                        textBoxPath.Text = subStr + subStr2;
                    }
                    else
                    {
                        textBoxPath.Text += "√(" + num2 + ")";
                    }
                }
                else
                {
                    if (path.IndexOf("√") != -1)
                        textBoxPath.Text = "√(" + textBoxPath.Text + ")";
                    else
                        textBoxPath.Text += "√(" + num2 + ")";
                }
                _spOped = true;
            }
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
        protected bool errorJudge()
        {
            if (textBoxRes.Text.IndexOf("Cannot") != -1) return true;
            if (textBoxRes.Text.IndexOf("Invalid") != -1) return true;
            return false;
        }
        protected void buttonSqr_Click(object sender, EventArgs e)
        {
            if (errorJudge()) { textBoxPath.Text = ""; textBoxRes.Text = "0"; } // 除0错误
            if (_calFinished) // 计算已经结束，
            {
                string tmp = textBoxRes.Text;
                buttonClear_Click(null, null);
                textBoxRes.Text = tmp;
            }

            _num2 = Convert.ToDecimal(textBoxRes.Text);
            string num2 = textBoxRes.Text;
            _num2 = (decimal)_num2 * _num2;
            textBoxRes.Text = _num2.ToString();

            string path = textBoxPath.Text;
            int lastOperator = -1;
            for (int i = path.Length - 1; i >= 0; i--)
                if (path[i] == '+' || path[i] == '-' || path[i] == operatorToView("*")[0] || path[i] == operatorToView("/")[0]) { lastOperator = i; break; }
            if (lastOperator != -1)
            {
                lastOperator++;
                string subStr = path.Substring(0, lastOperator);
                string subStr2 = path.Substring(lastOperator + 1);
                if (subStr2.IndexOf("sqr") != -1)
                {
                    subStr2 = "sqr(" + subStr2;
                    subStr2 += ")";
                    textBoxPath.Text = subStr + subStr2;
                }
                else
                {
                    textBoxPath.Text += "sqr(" + num2 + ")";
                }
            }
            else
            {
                if (path.IndexOf("sqr") != -1)
                    textBoxPath.Text = "sqr(" + textBoxPath.Text + ")";
                else
                    textBoxPath.Text += "sqr(" + num2 + ")";
            }
            _spOped = true;
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.Page.GetType(), "", "set_text_value_position('textBoxPath',-1);", true);
        }
    }
}