<%@ Page Title="管理团队" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="TeamWork.aspx.cs" Inherits="User_Interface_Layer.Student.TeamWork" %>
<asp:Content ID="stdContentMoudle" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <h2 class="text-success" style="text-align: center;">管理团队</h2>
            </div>
            <div class="col-md-1 column">
            </div>
            <div class="col-md-10 column">
                <div class="table-responsive">
                    <asp:Table runat="server" CssClass="table" ID="currentClass">
                    </asp:Table>
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
