<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="User_Interface_Layer.Admin.Default" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form" runat="server" method="post" id="Login">
        <div class="form-group">
            <label for="inputUsername">用户名</label>
            <div>
                <asp:TextBox runat="server" CssClass="form-control" ID="inputUsername" placeholder="请输入用户名"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword">密码</label>
            <div>
                <asp:TextBox runat="server" CssClass="form-control" ID="inputPassword" placeholder="请输入密码" TextMode="Password"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="inputCheckCode" style="display: block;">验证码</label>
            <asp:TextBox runat="server" ID="checkCode"
                CssClass="form-control" Style="width: 75%; display: inline;"
                placeholder="请输入验证码" />
            <img
                style="cursor: pointer; float: right; width: 12%;" alt="CheckCode" id="imageCode"
                src="/CheckCode.aspx" />
        </div>
        <div class="form-group">
            <div>
                <asp:Button ID="buttonLogin" runat="server" Text="登录" OnClick="Click_Login" CssClass="btn btn-primary form-control" />
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        function reloadCode() {
            var time = new Date().getTime();
            document.getElementById("imageCode").src = "/CheckCode.aspx?" + time;
        }
        $("#imageCode").bind('click', reloadCode);

        var idFix = "stdContentMoudle_stdContent_";
        $('#Login').submit(function () {
            var username = $("#" + idFix + "inputUsername")[0].value;
            var password = $("#" + idFix + "inputPassword")[0].value;
            var checkcode = $("#" + idFix + "checkCode")[0].value;

            var reg = new RegExp("^[0-9a-zA-Z_]{1,21}$");
            if (!reg.test(username)) {
                changeBorderColor("#" + idFix + "inputUsername", "用户名需要满足:<br/>1.长度在1到20之间。<br/>2.只包含下划线、大小写字母、数字。");
                return false;
            }
            reg = new RegExp("^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$");
            if (!reg.test(password)) {
                changeBorderColor("#" + idFix + "inputPassword", "密码需要满足:<br/>1.长度在7到20之间。<br/>2.只包含数字、大小写字母、特殊字符。");
                return false;
            }
            reg = new RegExp("^[a-zA-Z0-9]{4}$");
            if (!reg.test(checkcode)) {
                changeBorderColor("#" + idFix + "checkCode", "验证码需要满足:<br>1.长度必须为4。<br/>2.只包含数字、大小写字母。");
                return false;
            }
            return true;
        });
    </script>
</asp:Content>
