<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="1.aspx.cs" Inherits="WebApplication_asp_ocro.webs._1" %>

<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form id="form1" runat="server" style="text-align: center;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:TextBox CssClass="form-control" ID="TextBox1" runat="server"></asp:TextBox><br />
                <asp:Button CssClass="btn btn-primary form-control" ID="Button1" runat="server" OnClick="Button1_Click" Text="Login" />
                <p />
                <p>
                    <label for="none">
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label><br />
                    </label>
                </p>
            </ContentTemplate>
        </asp:UpdatePanel>
        <p>
            <label for="none" id="Label3"></label>
        </p>
    </form>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script type="text/javascript">
        document.getElementById('Label3').innerText = Date();
        setInterval(function () {
            document.getElementById('Label3').innerText = Date();
        }, 1000);
    </script>
</asp:Content>
