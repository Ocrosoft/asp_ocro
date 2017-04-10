<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3_3.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3_3" %>

<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form role="form" method="post" runat="server" id="Edit">
        <div class="form-group">
            <label for="inputUsername">Username</label>
            <asp:TextBox runat="server" type="text" ReadOnly="true"
                class="form-control" name="inputUsername" ID="inputUsername" />
        </div>
        <div class="form-group">
            <label for="inputOldPassword">Old Password</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputOldPassword" ID="inputOldPassword" placeholder="Old password is required if you change any profile"/>
        </div>
        <div class="form-group">
            <label for="inputPassword">New Password</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputPassword" ID="inputPassword" placeholder="Remain empty if you don't want to change password" />
        </div>
        <div class="form-group">
            <label for="inputRepeatPassword">Repeat New Password</label>
            <asp:TextBox runat="server"
                type="password" class="form-control" name="inputRepeatPassword"
                ID="inputRepeatPassword" />
        </div>
        <div class="form-group">
            <label for="selectorSex" style="display: block;">Sex&nbsp</label>
            <asp:RadioButtonList ID="selectorSex" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false">
                <asp:ListItem Selected="True" Value="1">&nbspMale&nbsp&nbsp</asp:ListItem>
                <asp:ListItem Value="0">&nbspFemale&nbsp</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="form-group">
            <label for="inputYear" style="display: block;">Year</label>
            <asp:TextBox runat="server"
                class="form-control" name="inputYear" ID="inputYear" />
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
            <asp:TextBox runat="server" ReadOnly="true"
                class="form-control" name="inputMajor" ID="inputMajor" />
        </div>
        <asp:Button runat="server" type="submit" class="btn btn-primary form-control" ID="buttonSubmit" Text="Accept(Not Available Yet)" OnClick="buttonSubmit_Click" />
    </form>
</asp:Content>
<asp:Content ID="stdContentSideBar" ContentPlaceHolderID="stdContentSideBar" runat="server">
    <div class="panel panel-success">
        <div class="panel-heading">提示</div>
        <div class="panel-body" style="text-align:center;">
            <label for="hint" style="text-align:center;">
                部分信息，例如性别，<br/>
                是无法修改的 <s>呢</s> 。
            </label>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">提示</div>
        <div class="panel-body" style="text-align:center;">
            <label for="hint" style="text-align:center;">
                如果修改信息，原密码必须输入，<br/>
                如果不想修改密码，<br/>
                留空新密码和重复密码即可。
            </label>
        </div>
    </div>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        var idFix = "stdContentMoudle_stdContent_";
        $('#Edit').submit(function () {
            var oldpassword = $("#" + idFix + "inputOldPassword")[0].value;
            var password = $("#" + idFix + "inputPassword")[0].value;
            var repassword = $("#" + idFix + "inputRepeatPassword")[0].value;
            var year = $("#" + idFix + "inputYear")[0].value;

            if (oldpassword.length < 7 || password.length > 20) {
                changeBorderColor("#" + idFix + "inputOldPassword", "Please enter you old password");
                return false;
            }
            if (password.length != 0 && (password.length < 7 || password.length > 20)) {
                changeBorderColor("#" + idFix + "inputPassword", "Password's length should be more than 7 and less than 20(Invlusive)");
                return false;
            }
            if (password.length!=0 && password != repassword) {
                changeBorderColor("#" + idFix + "inputRepeatPassword", "Password you entered is not equal");
                return false;
            }
            if (year < 18 || year > 100) {
                changeBorderColor("#" + idFix + "inputYear", "Please enter a valid age");
                return false;
            }

            return true;
        });
    </script>
</asp:Content>
