<%@ Page Title="Welcome" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="3_2.aspx.cs" Inherits="WebApplication_asp_ocro.webs._3_2" %>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <form class="form-horizontal" role="form"  runat="server" style="text-align:center;">
        <h1 class="text-success">Welcome!</h1>
        <asp:Button ID="Button1" runat="server" Text="Return to login page" CssClass="btn btn-primary" Style="width: 50%;" OnClick="Click_Back" /><br />
        <br />
    </form>
</asp:Content>