<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="Modify.aspx.cs" Inherits="User_Interface_Layer.Student.Modify" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form role="form" method="post" runat="server" id="Edit">
        <div class="form-group">
            <label for="inputUsername">用户名</label>
            <asp:TextBox runat="server" type="text" ReadOnly="true"
                class="form-control" name="inputUsername" ID="inputUsername" />
        </div>
        <div class="form-group">
            <label for="inputOldPassword">原密码</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputOldPassword" ID="inputOldPassword" placeholder="修改信息必须输入原密码"/>
        </div>
        <div class="form-group">
            <label for="inputPassword">新密码</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputPassword" ID="inputPassword" placeholder="如果不想修改密码请留空" />
        </div>
        <div class="form-group">
            <label for="inputRepeatPassword">确认密码</label>
            <asp:TextBox runat="server"
                type="password" class="form-control" name="inputRepeatPassword" placeholder="如果不想修改密码请留空"
                ID="inputRepeatPassword" />
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
                class="form-control" name="inputYear" ID="inputYear" />
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
        <asp:Button runat="server" type="submit" class="btn btn-primary form-control" ID="buttonSubmit" Text="修改" OnClick="buttonSubmit_Click" />
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
                changeBorderColor("#" + idFix + "inputOldPassword", "请输入原密码！");
                return false;
            }
            if (password.length != 0 && (password.length < 7 || password.length > 20)) {
                changeBorderColor("#" + idFix + "inputPassword", "密码需要满足:<br/>1.长度在7到20之间。<br/>2.只包含数字、大小写字母、特殊字符。");
                return false;
            }
            if (password.length!=0 && password != repassword) {
                changeBorderColor("#" + idFix + "inputRepeatPassword", "两次输入的密码不一致！");
                return false;
            }
            if (year < 18 || year > 100) {
                changeBorderColor("#" + idFix + "inputYear", "年龄需要满足:<br/>1.已年满十八周岁。<br/>2.不能超过100岁。");
                return false;
            }

            return true;
        });
    </script>
</asp:Content>
