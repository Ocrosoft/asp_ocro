<%@ Page Title="欢迎" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3_2.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3_2" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form"  runat="server" style="text-align:center;">
        <h1 class="text-success">欢迎!</h1>
        <h1><asp:Label runat="server" ID="labelIden" CssClass="text-success"></asp:Label></h1><br/>
        <br />
    </form>
</asp:Content>

<asp:Content ID="stdContentSideBar" ContentPlaceHolderID="stdContentSideBar" runat="server">
    <div class="panel panel-success">
        <div class="panel-heading">提示</div>
        <div class="panel-body" style="text-align:center;">
            <label for="hint" style="text-align:center;">
                在右上角可以登出。
            </label>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">提示</div>
        <div class="panel-body" style="text-align:center;">
            <label for="hint" style="text-align:center;">
                在右上角，<br/>
                学生可以修改自己的信息，<br/>
                教师可以查看所有已注册学生。
            </label>
        </div>
    </div>
</asp:Content>

<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
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
    </script>
</asp:Content>