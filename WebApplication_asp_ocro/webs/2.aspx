<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="2.aspx.cs" Inherits="WebApplication_asp_ocro.webs._2" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form id="form1" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:TextBox CssClass="form-control" ID="number1" runat="server"></asp:TextBox><br />
                <asp:DropDownList ID="operation" runat="server" CssClass="form-control">
                    <asp:ListItem Value="+">+</asp:ListItem>
                    <asp:ListItem>-</asp:ListItem>
                    <asp:ListItem Value="*">x</asp:ListItem>
                    <asp:ListItem Value="/">÷</asp:ListItem>
                </asp:DropDownList><br />
                <asp:TextBox CssClass="form-control" ID="number2" runat="server"></asp:TextBox><br />
                <label for="res">Result is:</label>
                <asp:TextBox CssClass="form-control" ID="result" runat="server"></asp:TextBox><br />
                <p />
                <asp:Button CssClass="btn btn-primary form-control" ID="calculate" runat="server" OnClientClick="return calc();" Text="计算(JS版)" /><br />
                <p />
                <asp:Button CssClass="btn btn-primary form-control" ID="calculate2" runat="server" Text="计算(ASP版)" OnClick="calculate2_Click" /><br />
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
<asp:Content ID="Content12" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        //计算
        function calc() {
            var number1 = document.getElementById('number1').value;
            var number2 = document.getElementById('number2').value;
            var operation = document.getElementById('operation');
            var op = operation.options[operation.selectedIndex].value;
            if (number1 === "" || number2 === "" || (number2 == "0" && op == '/')) {
                document.getElementById('result').value = "ERROR!";
                return false;
            }
            var number3;
            if (op == '+')
                number3 = parseInt(number1) + parseInt(number2);
            else if (op == '-')
                number3 = parseInt(number1) - parseInt(number2);
            else if (op == '*')
                number3 = parseInt(number1) * parseInt(number2);
            else if (op == '/')
                number3 = parseInt(number1) / parseInt(number2);
            document.getElementById('result').value = number3;
            return false;
        }
    </script>
</asp:Content>
