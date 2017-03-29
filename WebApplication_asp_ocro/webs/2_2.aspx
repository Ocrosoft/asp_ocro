<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="2_2.aspx.cs" Inherits="WebApplication_asp_ocro.webs._2_2" %>
<asp:Content ID="cssCusImportHead" ContentPlaceHolderID="cssCusImportHead" runat="server">
    <style>
        #form1 input {
            width: 60px;
            height: 70px;
            padding: 0 0;
            float: left;
            font-family: "微软雅黑";
            font-size: 20px;
            border: 0px;
            background-color: #f6f6f6;
            cursor: default;
            outline: none;
        }

        #form1 .OTHERBUTTON {
        }

        #form1 .NUMBUTTON {
            font-weight: bold;
        }

        #form1 .OPBUTTON {
            width: 30px;
            height: 30px;
            background-color: #0078d7;
            font-size: 18px;
        }

        #form1 .PATH {
            width: 360px;
            height: 50px;
            text-align: right;
            font-size: 18px;
            color: #9c9c9c;
            background-color: #ffffff;
        }

        #form1 .RES {
            width: 360px;
            height: 80px;
            text-align: right;
            font-size: 30px;
            font-weight: bold;
            background-color: #ffffff;
        }

        #form1 .TITLE {
            width: 330px;
            height: 30px;
            background-color: #0078d7;
            font-size: 13px;
        }

        .mainDiv {
            width: 360px;
            margin: 0 auto;
            clear: both;
        }
    </style>
</asp:Content>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form id="form1" runat="server">
        <div class="mainDiv">
            <asp:TextBox ID="titleLine" runat="server" CssClass="TITLE" Text="  计算器"></asp:TextBox>
            <asp:Button ID="buttonClose" runat="server" type="button" Text="×" CssClass="OPBUTTON" OnClick="buttonClose_Click" />
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="mainDiv">
                    <div class="line" style="clear: both;">
                        <asp:TextBox ID="textBoxPath" runat="server" CssClass="PATH"></asp:TextBox><br />
                        <asp:TextBox ID="textBoxRes" runat="server" Wrap="False" CssClass="RES"></asp:TextBox><br />
                        <br />
                    </div>
                    <div class="line" style="clear: both;">
                        <asp:Button ID="buttonMod" Width="120px" runat="server" Text="%" OnClick="op_Click" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonCE" runat="server" Text="CE" OnClick="buttonCE_Click" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonClear" runat="server" Text="C" OnClick="buttonClear_Click" CssClass="OTHERBUTTON" />
                        <asp:ImageButton ID="imageButtonBksp" runat="server" OnClick="buttonBksp_Click" CssClass="OTHERBUTTON" ImageUrl="//debug.ocrosoft.com:8001/pics/bksp.PNG" />
                        <asp:Button ID="buttonDiv" runat="server" Text="÷" OnClick="op_Click" CssClass="OTHERBUTTON" /><br />
                        <br />
                    </div>
                    <div class="line" style="clear: both;">
                        <asp:Button ID="buttonSqrt" runat="server" Text="√" CssClass="OTHERBUTTON" OnClick="buttonSqrt_Click" />
                        <asp:Button ID="buttonSqr" runat="server" Text="x²" CssClass="OTHERBUTTON" Style="font-family: 'Times New Roman'; font-style: italic;" OnClick="buttonSqr_Click" />
                        <asp:Button ID="buttonNum7" runat="server" Text="7" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonNum8" runat="server" Text="8" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonNum9" runat="server" Text="9" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonMul" runat="server" Text="×" OnClick="op_Click" CssClass="OTHERBUTTON" /><br />
                        <br />
                    </div>
                    <div class="line" style="clear: both;">
                        <asp:Button ID="buttonC" runat="server" Text="A" Enabled="False" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonD" runat="server" Text="B" Enabled="False" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonNum4" runat="server" Text="4" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonNum5" runat="server" Text="5" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonNum6" runat="server" Text="6" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonSub" runat="server" Text="-" OnClick="op_Click" CssClass="OTHERBUTTON" /><br />
                        <br />
                    </div>
                    <div class="line" style="clear: both;">
                        <asp:Button ID="buttonE" runat="server" Text="C" Enabled="False" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonF" runat="server" Text="D" Enabled="False" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonNum1" runat="server" Text="1" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonNum2" runat="server" Text="2" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonNum3" runat="server" Text="3" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonAdd" runat="server" Text="+" OnClick="op_Click" CssClass="OTHERBUTTON" /><br />
                        <br />
                    </div>
                    <div class="line" style="clear: both;">
                        <asp:Button ID="buttonLeftPara" runat="server" Text="E" Enabled="False" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonRightPara" runat="server" Text="F" Enabled="False" CssClass="OTHERBUTTON" />
                        <asp:ImageButton ID="imageButtonNega" runat="server" OnClick="buttonNega_Click" CssClass="OTHERBUTTON" ImageUrl="//debug.ocrosoft.com:8001/pics/nega.PNG" />
                        <asp:Button ID="buttonNum0" runat="server" Text="0" OnClick="num_Click" CssClass="NUMBUTTON" />
                        <asp:Button ID="buttonDot" runat="server" Text="." OnClick="dot_Click" CssClass="OTHERBUTTON" />
                        <asp:Button ID="buttonEqual" runat="server" Text="=" OnClick="equ_Click" CssClass="OTHERBUTTON" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script type="text/javascript">
        function buttonMouseOver(Event) {
            var button = Event.currentTarget;
            if (button.value == "=")
                button.style.backgroundColor = "#0078d7";
            else button.style.backgroundColor = "#eeeeee";
        }
        function buttonMouseOut(Event) {
            var button = Event.currentTarget;
            button.style.backgroundColor = "#f6f6f6";
        }
        function buttonMouseDown(Event) {
            var button = Event.currentTarget;
            if (button.value == "=")
                button.style.backgroundColor = "#489cdf";
            else button.style.backgroundColor = "#d4d4d4";
        }
        function buttonMouseUp(Event) {
            var button = Event.currentTarget;
            button.style.backgroundColor = "#f6f6f6";
        }
        function main() {
            $("#form1 .OTHERBUTTON").mouseover(buttonMouseOver);
            $("#form1 .OTHERBUTTON").mouseout(buttonMouseOut);
            $("#form1 .OTHERBUTTON").mousedown(buttonMouseDown);
            $("#form1 .OTHERBUTTON").mouseup(buttonMouseUp);
            $("#form1 .NUMBUTTON").mouseover(buttonMouseOver);
            $("#form1 .NUMBUTTON").mouseout(buttonMouseOut);
            $("#form1 .NUMBUTTON").mousedown(buttonMouseDown);
            $("#form1 .NUMBUTTON").mouseup(buttonMouseUp);
            $("#form1 .OPBUTTON").mouseover(function (Event) {
                var button = Event.currentTarget;
                button.style.backgroundColor = "#ff0000";
            })
            $("#form1 .OPBUTTON").mouseout(function (Event) {
                var button = Event.currentTarget;
                button.style.backgroundColor = "#0078d7";
            })
            $("#form1 .OPBUTTON").mousedown(function (Event) {
                var button = Event.currentTarget;
                button.style.backgroundColor = "#f1707a";
            })
            $("#form1 .OPBUTTON").mouseup(function (Event) {
                var button = Event.currentTarget;
                button.style.backgroundColor = "#0078d7";
            })
        };
        setInterval(main, 100);
        document.onkeydown = function (e) {
            if (e.keyCode >= 96 && e.keyCode <= 105) {
                var num = e.keyCode - 96;
                var str = "#buttonNum" + num;
                $(str).click();
                return false;
            }
            else if (e.keyCode == 53 && e.shiftKey) {
                $('#buttonMod').click();
                return false;
            }
            else if (e.keyCode >= 48 && e.keyCode <= 57) {
                var num = e.keyCode - 48;
                var str = "#buttonNum" + num;
                $(str).click();
                return false;
            }
            else if (e.keyCode == 8) {
                $('#imageButtonBksp').click();
                return false;
            }
            else if (e.keyCode == 13) {
                $('#buttonEqual').click();
                return false;
            }
            else if (e.keyCode == 106) {
                $('#buttonMul').click();
                return false;
            }
            else if (e.keyCode == 107) {
                $('#buttonAdd').click();
                return false;
            }
            else if (e.keyCode == 109) {
                $('#buttonSub').click();
                return false;
            }
            else if (e.keyCode == 111) {
                $('#buttonDiv').click();
                return false;
            }
            else if (e.keyCode == 110) {
                $('#buttonDot').click();
                return false;
            }
        }
        function set_text_value_position(obj, spos) {
            var tobj = document.getElementById(obj);
            if (spos < 0)
                spos = tobj.value.length;
            if (tobj.setSelectionRange) { //兼容火狐,谷歌
                setTimeout(function () {
                    tobj.setSelectionRange(spos, spos);
                    tobj.focus();
                }
                    , 0);
            } else if (tobj.createTextRange) { //兼容IE
                var rng = tobj.createTextRange();
                rng.move('character', spos);
                rng.select();
            }
        }
    </script>
</asp:Content>
