<%@ Page Title="Welcome" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3_2.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3_2" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form"  runat="server" style="text-align:center;">
        <h1 class="text-success">Welcome!</h1>
        <h1><asp:Label runat="server" ID="labelIden" CssClass="text-success"></asp:Label></h1><br/>
        <asp:Button ID="Button1" runat="server" Text="Return to login page" CssClass="btn btn-primary" Style="width: 50%;" OnClick="Click_Back" /><br />
        <br />
    </form>
</asp:Content>

<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        $('#loginOperation').poshytip('destroy');
        $('#loginOperation').poshytip({
            content: 'Logout here!',
            className: 'tip-skyblue',
            showOn: 'none',
            alignTo: 'target',
            alignX: 'left',
            alignY: 'center',
            offsetX: 10
        });
        $('#loginOperation').poshytip('show');

        var it = setInterval(function () { $('#loginOperation').poshytip('destroy'); clearInterval(it); }, 10000);
    </script>
</asp:Content>