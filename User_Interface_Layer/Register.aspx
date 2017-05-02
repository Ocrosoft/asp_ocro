<%@ Page Title="注册" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="User_Interface_Layer.Register" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form role="form" method="post" runat="server" id="Register">
        <div class="form-group">
            <label for="inputUsername">用户名</label>
            <asp:TextBox runat="server" type="text"
                class="form-control" name="inputUsername" ID="inputUsername"
                placeholder="邮箱 / 姓名 / 手机号" />
        </div>
        <div class="form-group">
            <label for="inputPassword">密码</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputPassword" ID="inputPassword"
                placeholder="请输入你的密码" />
        </div>
        <div class="form-group">
            <label for="inputRepeatPassword">确认密码</label>
            <asp:TextBox runat="server"
                type="password" class="form-control" name="inputRepeatPassword"
                ID="inputRepeatPassword" placeholder="请重复你的密码" />
        </div>
        <div class="form-group">
            <label for="selectorSex" style="display: block;">性别&nbsp</label>
            <asp:RadioButtonList ID="selectorSex" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Selected="True" Value="男">&nbsp 男 &nbsp&nbsp</asp:ListItem>
                <asp:ListItem Value="女">&nbsp 女 &nbsp</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="form-group">
            <label for="inputYear" style="display: block;">年龄</label>
            <asp:TextBox runat="server"
                type="text" class="form-control" name="inputYear" ID="inputYear"
                placeholder="请填写你的年龄" />
        </div>
        <div class="form-group">
            <label for="selectorGrade" style="display: block;">年级</label>
            <asp:DropDownList runat="server" name="selectGrade" ID="selectGrade" CssClass="form-control">
                <asp:ListItem Value="2016">2016</asp:ListItem>
                <asp:ListItem Value="2015">2015</asp:ListItem>
                <asp:ListItem Value="2014">2014</asp:ListItem>
                <asp:ListItem Value="2013">2013</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label for="selectorMajor" style="display: block;">专业</label>
            <asp:DropDownList runat="server" name="selectMajor" ID="selectMajor" CssClass="form-control">
                <asp:ListItem Value="电子商务">电子商务</asp:ListItem>
                <asp:ListItem Value="计算机">计算机</asp:ListItem>
                <asp:ListItem Value="软件工程">软件工程</asp:ListItem>
                <asp:ListItem Value="信息技术">信息技术</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label for="inputCheckCode" style="display: block;">验证码</label>
            <asp:TextBox runat="server" type="text" ID="checkCode" name="checkCode" value=""
                class="form-control" Style="width: 75%; display: inline;"
                placeholder="请输入验证码" />
            <img
                style="cursor: pointer; float: right; width: 12%;" alt="CheckCode" id="imageCode"
                src="/CheckCode.aspx" />
        </div>
        <asp:Button runat="server" type="submit" class="btn btn-primary form-control" ID="buttonSubmit" Text="注册" OnClick="buttonSubmit_Click" />
        <a href="/Login.aspx">
            <input type="button" class="btn btn-link" style="outline: none; right: 0; position: absolute;" value="登录->" />
        </a>
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
        $('#Register').submit(function () {
            var username = $("#" + idFix + "inputUsername")[0].value;
            var password = $("#" + idFix +"inputPassword")[0].value;
            var repassword = $("#" + idFix + "inputRepeatPassword")[0].value;
            var year = $("#" + idFix + "inputYear")[0].value.trim();
            var checkcode = $("#" + idFix +"checkCode")[0].value;

            var reg = new RegExp("^[0-9a-zA-Z_]{1,21}$");
            if (!reg.test(username)){
                changeBorderColor("#" + idFix + "inputUsername", "用户名需要满足:<br/>1.长度在1到20之间。<br/>2.只包含下划线、大小写字母、数字。");
                return false;
            }
            reg = new RegExp("^[!@#$%^&*()0-9a-zA-Z_?<>.]{7,20}$");
            if (!reg.test(password)) {
                changeBorderColor("#" + idFix + "inputPassword", "密码需要满足:<br/>1.长度在7到20之间。<br/>2.只包含数字、大小写字母、特殊字符。");
                return false;
            }
            if (password != repassword) {
                changeBorderColor("#" + idFix +"inputRepeatPassword", "两次输入的密码不一致！");
                return false;
            }
            if (year < 18 || year > 100) {
                changeBorderColor("#" + idFix +"inputYear", "年龄需要满足:<br/>1.已年满十八周岁。<br/>2.不能超过100岁。");
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
