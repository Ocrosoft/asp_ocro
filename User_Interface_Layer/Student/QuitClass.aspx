﻿<%@ Page Title="退出课程" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="QuitClass.aspx.cs" Inherits="User_Interface_Layer.Student.QuitClass" %>

<asp:Content ID="stdContent" ContentPlaceHolderID="stdContent" runat="server">
    <h1 class="text-success" style="text-align: center;">退出课程</h1>
    <div class="table-responsive">
        <asp:Table runat="server" CssClass="table" ID="currentClass">
        </asp:Table>
    </div>
</asp:Content>
<asp:Content ID="stdContentSideBar" ContentPlaceHolderID="stdContentSideBar" runat="server">
</asp:Content>
<asp:Content ID="cusContentSideBar" ContentPlaceHolderID="cusContentSideBar" runat="server">
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
</asp:Content>