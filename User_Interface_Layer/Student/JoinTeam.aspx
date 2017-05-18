<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="JoinTeam.aspx.cs" Inherits="User_Interface_Layer.Student.JoinClass" %>

<asp:Content ID="cssCusImportHead" ContentPlaceHolderID="cssCusImportHead" runat="server">
    <style>
        #MainForm td {
            padding-top: 13px;
        }
        #MainForm .operation{
            padding-top: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="stdContentMoudle" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12">
                <form runat="server" id="MainForm">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:ScriptManager runat="server"></asp:ScriptManager>
                            <div class="table-responsive">
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
                                    SelectMethod="queryAllTeam"
                                    TypeName="Business_Logic_Layer.BLL_Team"></asp:ObjectDataSource>
                                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" ForeColor="#333333" GridLines="None" CssClass="table" AllowPaging="True" PageSize="20" DataKeyNames="TeamID" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="TeamID" HeaderText="团队编号" ControlStyle-CssClass="form-control" ControlStyle-Width="119px">
                                            <ControlStyle CssClass="form-control" Width="119px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CourceName" HeaderText="课程名称" ControlStyle-CssClass="form-control" ControlStyle-Width="119px">
                                            <ControlStyle CssClass="form-control" Width="119px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="StuClass" HeaderText="授课班级" ControlStyle-CssClass="form-control" ControlStyle-Width="119px">
                                            <ControlStyle CssClass="form-control" Width="119px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TeaName" HeaderText="任课教师" ControlStyle-CssClass="form-control" ControlStyle-Width="119px">
                                            <ControlStyle CssClass="form-control" Width="119px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CourceTerm" HeaderText="课程学期" ControlStyle-CssClass="form-control" ControlStyle-Width="119px">
                                            <ControlStyle CssClass="form-control" Width="119px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AnswerStatus" HeaderText="答辩状态" ControlStyle-CssClass="form-control" ControlStyle-Width="119px">
                                            <ControlStyle CssClass="form-control" Width="119px" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="加入状态">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="JoinStatus"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="操作" ItemStyle-CssClass="operation">
                                            <ItemTemplate>
                                                <asp:Button ID="ButtonJoin" runat="server" Text="加入" CssClass="btn btn-primary form-control" CommandArgument="<%#Container.DataItemIndex %>" CommandName="JoinTeam" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EditRowStyle BackColor="#2461BF" />
                                    <FooterStyle BackColor="#4472C4" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#4472C4" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#D9E2F3" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                </asp:GridView>
                            </div>
                            <input style="display: none" type="submit" id="refresh" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
</asp:Content>
