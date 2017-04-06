<%@ Page Title="Register" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3_1.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3_1" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form role="form" method="post" runat="server" id="Register">
        <div class="form-group">
            <label for="inputUsername">Username</label>
            <asp:TextBox runat="server" type="text"
                class="form-control" name="inputUsername" ID="inputUsername"
                placeholder="Email/Phone Number/Name/ID" />
        </div>
        <div class="form-group">
            <label for="inputPassword">Password</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputPassword" ID="inputPassword"
                placeholder="Enter your password" />
        </div>
        <div class="form-group">
            <label for="inputRepeatPassword">Repeat Password</label>
            <asp:TextBox runat="server"
                type="password" class="form-control" name="inputRepeatPassword"
                ID="inputRepeatPassword" placeholder="Repeat your password" />
        </div>
        <div class="form-group">
            <label for="selectorSex" style="display: block;">Sex&nbsp</label>
            <asp:RadioButtonList ID="selectorSex" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Selected="True" Value="1">&nbspMale&nbsp&nbsp</asp:ListItem>
                <asp:ListItem Value="0">&nbspFemale&nbsp</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="form-group">
            <label for="inputYear" style="display: block;">Year</label>
            <asp:TextBox runat="server"
                type="text" class="form-control" name="inputYear" ID="inputYear"
                placeholder="Enter your year" />
        </div>
        <div class="form-group">
            <label for="selectorGrade" style="display: block;">Grade</label>
            <asp:DropDownList runat="server" name="selectGrade" ID="selectGrade" CssClass="form-control">
                <asp:ListItem Value="1">Grade 1</asp:ListItem>
                <asp:ListItem Value="2">Grade 2</asp:ListItem>
                <asp:ListItem Value="3">Grade 3</asp:ListItem>
                <asp:ListItem Value="4">Grade 4</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label for="selectorMajor" style="display: block;">Major</label>
            <asp:DropDownList runat="server" name="selectMajor" ID="selectMajor" CssClass="form-control">
                <asp:ListItem Value="Software Engineering">Software Engineering</asp:ListItem>
                <asp:ListItem Value="Computer">Computer</asp:ListItem>
                <asp:ListItem Value="Infomation">Infomation</asp:ListItem>
                <asp:ListItem Value="Electronic Commerce">Electronic Commerce</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label for="inputCheckCode" style="display: block;">CheckCode</label>
            <asp:TextBox runat="server" type="text" ID="checkCode" name="checkCode" value=""
                class="form-control" Style="width: 75%; display: inline;"
                placeholder="Enter checkcode" />
            <img
                style="cursor: pointer; float: right; width: 12%;" alt="CheckCode" id="imageCode"
                src="/webs/CheckCode.aspx" />
        </div>
        <asp:Button runat="server" type="submit" class="btn btn-primary form-control" ID="buttonSubmit" Text="Register" OnClick="buttonSubmit_Click" />
        <a href="/webs/3.aspx">
            <input type="button" class="btn btn-link" style="outline: none; right: 0; position: absolute;" value="Login->" />
        </a>
    </form>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        function reloadCode() {
            var time = new Date().getTime();
            document.getElementById("imageCode").src = "CheckCode.aspx?" + time;
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
        String.prototype.trim = function () {
            return this.replace(/(^\s*)|(\s*$)/g, "");
        }

        var idFix = "stdContentMoudle_stdContent_";
        $('#Register').submit(function () {
            var username = $("#" + idFix + "inputUsername")[0].value;
            var password = $("#" + idFix +"inputPassword")[0].value;
            var repassword = $("#" + idFix + "inputRepeatPassword")[0].value;
            var year = $("#" + idFix + "inputYear")[0].value.trim();
            var checkcode = $("#" + idFix +"checkCode")[0].value;

            var reg = new RegExp("^[0-9a-zA-Z_]{1,21}$");
            if (!reg.test(username)){
                changeBorderColor("#" + idFix + "inputUsername", "Username should satisfy:<br/>1.Length at least 1, at most 20.<br/>2.Include '0-9','a-z','A-Z','_' only.");
                return false;
            }
            reg = new RegExp("^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$");
            if (!reg.test(password)) {
                changeBorderColor("#" + idFix + "inputPassword", "Password should satisfy:<br/>1.Length at least 7, at most 20.<br/>2.Include '0-9','a-z','A-Z'<br/>and special character(such as '!') only.");
                return false;
            }
            if (password != repassword) {
                changeBorderColor("#" + idFix +"inputRepeatPassword", "Repeat password is not equal to password.");
                return false;
            }
            if (year < 18 || year > 100) {
                changeBorderColor("#" + idFix +"inputYear", "Age should satisfy:<br/>1.You are at least 18 years old.<br/>2.You can't older than 100 years old.");
                return false;
            }
            reg = new RegExp("^[a-zA-Z0-9]{4}$");
            if (!reg.test(checkcode)) {
                changeBorderColor("#" + idFix +"checkCode", "Checkcode should satisfy:<br>1.Length must be 4.<br/>2.Include '0-9','a-z','A-Z' only.");
                return false;
            }
            return true;
        });
    </script>
</asp:Content>
