<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3" %>

<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form" runat="server" method="post">
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
            <asp:TextBox runat="server" type="text" ID="checkCode" name="checkCode" value=""
                class="form-control" Style="width: 75%; display: inline;"
                placeholder="Enter checkcode" />
            <img
                style="cursor: pointer; float: right; width: 12%;" alt="CheckCode" id="imageCode"
                src="/webs/CheckCode.aspx" />
        </div>
        <div class="form-group">
            <div>
                <asp:Button runat="server" Text="Login" OnClick="Click_Login" class="btn btn-primary form-control" />
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
    </script>
</asp:Content>
