<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3_3.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3_3" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form role="form" method="post" runat="server">
        <div class="form-group">
            <label for="inputUsername">Username</label>
            <asp:TextBox runat="server" type="text" ReadOnly="true"
                class="form-control" name="inputUsername" ID="inputUsername" />
        </div>
        <div class="form-group">
            <label for="inputOldPassword">Old Password</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputOldPassword" ID="inputOldPassword" />
        </div>
        <div class="form-group">
            <label for="inputPassword">Password</label>
            <asp:TextBox runat="server" type="password"
                class="form-control" name="inputPassword" ID="inputPassword" />
        </div>
        <div class="form-group">
            <label for="inputRepeatPassword">Repeat Password</label>
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
            <asp:TextBox runat="server" ReadOnly="true"
                class="form-control" name="inputYear" ID="inputYear" />
        </div>
        <div class="form-group">
            <label for="selectorGrade" style="display: block;">Grade</label>
            <asp:DropDownList runat="server" name="selectGrade" ID="selectGrade" CssClass="form-control" Enabled="false">
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
        <asp:Button runat="server" type="submit" class="btn btn-primary form-control" ID="buttonSubmit" Text="Accept(Not Available Yet)" />
    </form>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
</asp:Content>
