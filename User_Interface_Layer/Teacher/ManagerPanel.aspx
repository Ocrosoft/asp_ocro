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
