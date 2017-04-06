<%@ Page Title="Login" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3" %>

<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form" runat="server" method="post" id="Login">
        <div class="form-group">
            <label for="inputUsername">Username</label>
            <div>
                <asp:TextBox runat="server" CssClass="form-control" ID="inputUsername" placeholder="Email/Name/Phone Number"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword">Password</label>
            <div>
                <asp:TextBox runat="server" CssClass="form-control" ID="inputPassword" placeholder="Password" TextMode="Password"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="inputCheckCode" style="display: block;">CheckCode</label>
            <asp:TextBox runat="server" ID="checkCode"
                CssClass="form-control" Style="width: 75%; display: inline;"
                placeholder="Enter checkcode" />
            <img
                style="cursor: pointer; float: right; width: 12%;" alt="CheckCode" id="imageCode"
                src="/webs/CheckCode.aspx" />
        </div>
        <div class="form-group">
            <asp:CheckBox runat="server" Text="&nbspRemember me" ID="checkBoxRemember"/>
            <asp:CheckBox runat="server" Text="&nbspTeacher" ID="checkBoxTeacher"  style="position:absolute;right:0;"/>
        </div>
        <div class="form-group">
            <div>
                <asp:Button runat="server" Text="Login" OnClick="Click_Login" CssClass="btn btn-primary form-control" />
            </div>
            <a href="/webs/3_1.aspx">
                <input type="button" class="btn btn-link" style="outline: none; right: 0; position: absolute;" value="Register->" />
            </a>
        </div>
    </form>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        function reloadCode() {
            var time = new Date().getTime();
            document.getElementById("imageCode").src = "/webs/CheckCode.aspx?" + time;
        }
        $("#imageCode").bind('click', reloadCode);

        function changeBorderColor(id, message) {
            $(id).css('border-color', '#f00');
            $(id).poshytip('destroy');
            $(id).poshytip({
                content: message,
                className: 'tip-skyblue',
                showOn: 'none',
                alignTo: 'target',
                alignX: 'inner-right',
                offsetY: '10'
            });
            $(id).poshytip('show');
            $(id).focus(function () {
                $(id).css('border-color', '#ccc');
                $(id).poshytip('destroy');
            });
        }

        var idFix = "stdContentMoudle_stdContent_";
        $('#Login').submit(function () {
            var username = $("#"+idFix+"inputUsername")[0].value;
            var password = $("#" + idFix +"inputPassword")[0].value;
            var checkcode = $("#" + idFix +"checkCode")[0].value;

            var reg = new RegExp("^[0-9a-zA-Z_]{1,21}$");
            if (!reg.test(username)) {
                changeBorderColor("#" + idFix + "inputUsername", "Username should satisfy:<br/>1.Length at least 1, at most 20.<br/>2.Include '0-9','a-z','A-Z','_' only.");
                return false;
            }
            reg = new RegExp("^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$");
            if (!reg.test(password)) {
                changeBorderColor("#" + idFix + "inputPassword", "Password should satisfy:<br/>1.Length at least 7, at most 20.<br/>2.Include '0-9','a-z','A-Z'<br/>and special character(such as '!') only.");
                return false;
            }
            reg = new RegExp("^[a-zA-Z0-9]{4}$");
            if (!reg.test(checkcode)) {
                changeBorderColor("#" + idFix + "checkCode", "Checkcode should satisfy:<br>1.Length must be 4.<br/>2.Include '0-9','a-z','A-Z' only.");
                return false;
            }
            return true;
        });
    </script>
</asp:Content>
