<%@ Page Title="加入课程" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="JoinClass.aspx.cs" Inherits="User_Interface_Layer.Student.JoinClass" %>

<asp:Content ID="stdContentMoudle" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <h2 class="text-success" style="text-align: center;">加入课程</h2>
            </div>
            <div class="col-md-1 column">
            </div>
            <div class="col-md-10 column">
                <div class="table-responsive">
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"></asp:ObjectDataSource>
                    <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                </div>
            </div>
            <div class="col-md-1 column">
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="stdContentSideBar" ContentPlaceHolderID="stdContentSideBar" runat="server">
</asp:Content>
<asp:Content ID="cusContentSideBar" ContentPlaceHolderID="cusContentSideBar" runat="server">
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
</asp:Content>
