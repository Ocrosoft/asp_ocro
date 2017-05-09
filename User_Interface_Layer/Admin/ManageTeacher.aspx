<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="ManageTeacher.aspx.cs" Inherits="User_Interface_Layer.Admin.ManageTeacher" %>
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
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                    SelectMethod="qeruyAllStudent" 
                                    DeleteMethod="deleteByID"
                                    UpdateMethod="modify"
                                    TypeName="Business_Logic_Layer.BLL_Student">
                                </asp:ObjectDataSource>
                                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" ForeColor="#333333" GridLines="None" CssClass="table" AllowPaging="True" PageSize="20" DataKeyNames="id" OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating1">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True"/>
                                        <asp:BoundField DataField="username" HeaderText="用户名"  ControlStyle-CssClass="form-control" ControlStyle-Width="119px" />
                                         <asp:TemplateField HeaderText="性别">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="sex" Text='<%# Bind("sex") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="editSex" runat="server" SelectedValue='<%# Bind("sex") %>' CssClass="form-control">
                                                    <asp:ListItem Value="男">男</asp:ListItem>
                                                    <asp:ListItem Value="女">女</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="年级">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="grade" Text='<%# Bind("grade") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="editGrade" runat="server" SelectedValue='<%# Bind("grade") %>' CssClass="form-control">
                                                    <asp:ListItem Value="2016">2016</asp:ListItem>
                                                    <asp:ListItem Value="2015">2015</asp:ListItem>
                                                    <asp:ListItem Value="2014">2014</asp:ListItem>
                                                    <asp:ListItem Value="2013">2013</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="age" HeaderText="年龄"  ControlStyle-CssClass="form-control"  />
                                        <asp:TemplateField HeaderText="专业">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="major" Text='<%# Bind("major") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="editMajor" runat="server"  SelectedValue='<%# Bind("major") %>' CssClass="form-control">
                                                    <asp:ListItem Value="电子商务">电子商务</asp:ListItem>
                                                    <asp:ListItem Value="计算机">计算机</asp:ListItem>
                                                    <asp:ListItem Value="软件工程">软件工程</asp:ListItem>
                                                    <asp:ListItem Value="信息技术">信息技术</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ip" HeaderText="IP" ReadOnly="true"  />
                                        <asp:BoundField DataField="regtime" HeaderText="注册时间" ReadOnly="true" />
                                        <asp:BoundField DataField="id" HeaderText="ID" Visible="False" ReadOnly="true" />
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
