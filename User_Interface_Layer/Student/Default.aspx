<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="User_Interface_Layer.Student.Default" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form"  runat="server" style="text-align:center;">
        <h1 class="text-success">欢迎使用项目答辩评分系统!</h1>
        <br />
    </form>
</asp:Content>

<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        /*
        $('#loginOperation').poshytip('destroy');
        $('#loginOperation').poshytip({
            content: '在这里退出登录',
            className: 'tip-skyblue',
            showOn: 'none',
            alignTo: 'target',
            alignX: 'left',
            alignY: 'center',
            offsetX: 10
        });
        $('#loginOperation').poshytip('show');
        
        var it = setInterval(function () { $('#loginOperation').poshytip('destroy'); clearInterval(it); }, 10000);
        */
    </script>
</asp:Content>