<%@ Page Title="课程项目作业" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="ProjectWork.aspx.cs" Inherits="User_Interface_Layer.Student.ProjectWork" %>

<asp:Content ID="stdContentMoudle" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <h2 class="text-success" style="text-align: center;">课程项目作业</h2>
            </div>
            <div class="col-md-1 column">
            </div>
            <div class="col-md-10 column">
                <div class="col-md-12">
                    <div class="col-md-4" style="text-align: right;">
                        <label for="selectClass">请选择课程</label>
                    </div>
                    <div class="col-md-6">
                        <form runat="server">
                            <asp:DropDownList ID="DropDownList1" runat="server" Width="100%"></asp:DropDownList>
                        </form>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="table-responsive">
                        <asp:Table runat="server" CssClass="table" ID="currentClass">
                        </asp:Table>
                    </div>
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
