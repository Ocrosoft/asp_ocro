<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="ManagerPanel.aspx.cs" Inherits="User_Interface_Layer.Teacher.ManagerPanel" %>
<asp:Content ID="stdContentMoudle" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12">
                <form runat="server" id="usersForm">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="hiddenFieldEdit" runat="server" />
                            <asp:HiddenField ID="hiddenFieldAccept" runat="server" />
                            <asp:HiddenField ID="hiddenFieldValue" runat="server" />
                            <asp:ScriptManager runat="server"></asp:ScriptManager>
                            <div class="table-responsive">
                                <asp:Table runat="server" CssClass="table" ID="registedUser">
                                </asp:Table>
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="qeruyAllStudent_DataSet" TypeName="Business_Logic_Layer.BLL_Student" DataObjectTypeName="Models.Student" DeleteMethod="deleteByID" UpdateMethod="modify">
                                    <DeleteParameters>
                                        <asp:Parameter Name="ID" Type="String" />
                                    </DeleteParameters>
                                </asp:ObjectDataSource>
                                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" ForeColor="#333333" GridLines="None" CssClass="table" AllowPaging="True">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                                        <asp:BoundField DataField="username" HeaderText="用户名" />
                                        <asp:BoundField DataField="sex" HeaderText="性别" />
                                        <asp:BoundField DataField="grade" HeaderText="年级" />
                                        <asp:BoundField DataField="age" HeaderText="年龄" />
                                        <asp:BoundField DataField="major" HeaderText="专业" />
                                        <asp:BoundField DataField="IP" HeaderText="IP" />
                                        <asp:BoundField DataField="regtime" HeaderText="注册时间" />
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
    <script>
        $('.DeleteButton').click(function () {
            if (confirm("确定要删除这个学生吗?")) {
                return true;
            }
            else return false;
        });
        $('.linkButtonEdit').click(function () {
            this.innerText = '请稍候...';
        });
    </script>
    <script>
        var prm = Sys.WebForms.PageRequestManager.getInstance(); // updatepanel 刷新会导致js失效，需要重新注册
        prm.add_endRequest(function () {
            $('.DeleteButton').click(function () {
                if (confirm("确定要删除这个学生吗?")) {
                    return true;
                }
                else return false;
            });

            $('.linkButtonEdit').click(function () {
                this.innerText = '请稍候...';
            });
        }
        );
    </script>
</asp:Content>
