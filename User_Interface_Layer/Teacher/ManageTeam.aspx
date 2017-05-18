<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="ManageTeam.aspx.cs" Inherits="User_Interface_Layer.Teacher.ManageTeam" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="cssCusImportHead" ContentPlaceHolderID="cssCusImportHead" runat="server">
    <style>
        .teams .btn {
            margin-top: 8px;
        }
    </style>
</asp:Content>
<asp:Content ID="stdContentMoudle" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12">
                <form runat="server">
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="queryAllTeam" TypeName="Business_Logic_Layer.BLL_Team"></asp:ObjectDataSource>
                    <asp:ListView ID="ListView1" runat="server" DataSourceID="ObjectDataSource1" OnItemCommand="ListView1_ItemCommand">
                        <LayoutTemplate>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                        </LayoutTemplate>
                        <ItemTemplate>
                            <table class="table table-bordered">
                                <tbody class="teams">
                                    <tr class="firstRow">
                                        <td width="119" valign="top" style="word-break: break-all;">团队编号
                                        </td>
                                        <td valign="top" colspan="2" style="word-break: break-all;">
                                            <asp:TextBox ID="TeamID" Enabled="false" Text='<%#Bind("TeamID") %>' runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td width="119" valign="top" style="word-break: break-all;">任课教师
                                        </td>
                                        <td valign="top" colspan="8" style="word-break: break-all;">
                                            <asp:TextBox ID="TeaID" Enabled="false" Text='<%#Bind("TeaName") %>' runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="119" valign="top" style="word-break: break-all;">答辩状态
                                        </td>
                                        <td valign="top" colspan="2" style="word-break: break-all;">
                                            <asp:DropDownList ID="AnswerStatus" runat="server" SelectedValue='<%#Bind("AnswerStatus") %>' CssClass="form-control">
                                                <asp:ListItem Value="未开始">未开始</asp:ListItem>
                                                <asp:ListItem Value="进行中">进行中</asp:ListItem>
                                                <asp:ListItem Value="已结束">已结束</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td width="119" valign="top" style="word-break: break-all;">审核模式
                                        </td>
                                        <td valign="top" colspan="8" style="word-break: break-all;">
                                            <asp:DropDownList ID="AuditMode" runat="server" SelectedValue='<%#Bind("AuditMode") %>' CssClass="form-control">
                                                <asp:ListItem Value="自动审核">自动审核</asp:ListItem>
                                                <asp:ListItem Value="手动审核">手动审核</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="119" valign="top" style="word-break: break-all;">评分模式
                                        </td>
                                        <td valign="top" colspan="2" style="word-break: break-all;">
                                            <asp:DropDownList ID="ScoreType" runat="server" SelectedValue='<%#Bind("ScoreType") %>' CssClass="form-control">
                                                <asp:ListItem Value="百分制">百分制</asp:ListItem>
                                                <asp:ListItem Value="五级制">五级制</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td width="119" valign="top" style="word-break: break-all;">所在学期
                                        </td>
                                        <td valign="top" colspan="8" style="word-break: break-all;">
                                            <asp:DropDownList ID="CourceTerm" runat="server" SelectedValue='<%#Bind("CourceTerm") %>' CssClass="form-control">
                                                <asp:ListItem Value="11-12(2)">11-12(2)</asp:ListItem>
                                                <asp:ListItem Value="12-13(1)">12-13(1)</asp:ListItem>
                                                <asp:ListItem Value="12-13(2)">12-13(2)</asp:ListItem>
                                                <asp:ListItem Value="13-14(1)">13-14(1)</asp:ListItem>
                                                <asp:ListItem Value="13-14(2)">13-14(2)</asp:ListItem>
                                                <asp:ListItem Value="14-15(1)">14-15(1)</asp:ListItem>
                                                <asp:ListItem Value="14-15(2)">14-15(2)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="119" valign="top" style="word-break: break-all;">课程名称
                                        </td>
                                        <td valign="top" colspan="11" style="word-break: break-all;" rowspan="1">
                                            <div class="col-md-10" style="padding:0;">
                                                <asp:TextBox ID="CourceName" runat="server" Text='<%#Bind("CourceName") %>' CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <label style="padding-left:10px;padding-top:8px;">(不超过10个字符)</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="119" valign="top" style="word-break: break-all;">学生班级
                                        </td>
                                        <td valign="top" colspan="11" style="word-break: break-all;" rowspan="1">
                                            <div class="col-md-10" style="padding:0;">
                                                <asp:TextBox ID="StuClass" runat="server" Text='<%#Bind("StuClass") %>' CssClass="form-control"></asp:TextBox>
                                            </div>
                                             <label style="padding-left:10px;padding-top:8px;">(不超过14个字符)</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="119" valign="top" style="word-break: break-all;">团队简介
                                        </td>
                                        <td valign="top" colspan="11" style="word-break: break-all;" rowspan="1">
                                            <asp:TextBox Height="100px" ID="Introduce" runat="server" Text='<%#Bind("Introduce") %>' CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                            <div class="col-md-8"><label style="padding-top:10px;">(如答辩时间、答辩地点、答辩要求、注意事项等)</label></div>
                                            <div class="col-md-2">
                                                <asp:Button ID="ButtonDelete" runat="server" Text="删除" CssClass="btn btn-warning form-control" CommandArgument="<%#Container.DataItemIndex %>" CommandName="DeleteTeam" />
                                            </div>
                                            <div class="col-md-2">
                                                <asp:Button ID="ButtonSave" runat="server" Text="保存" CssClass="btn btn-primary form-control" CommandArgument="<%#Container.DataItemIndex %>" CommandName="SaveTeam" />
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ItemTemplate>
                    </asp:ListView>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="cusContentSideBar" ContentPlaceHolderID="cusContentSideBar" runat="server">
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        var alpha_div = 0.00;
        var interval_fsm;
        function addFSMDiv(msg) {
            $('#FSMDiv').remove();
            var div = document.createElement('div');
            div.id = 'FSMDiv';
            div.style.textAlign = 'center';
            div.style.height = '100%';
            div.style.width = '100%';
            div.style.position = 'absolute';
            div.style.left = '0px';
            div.style.top = '0px';
            div.style.display = 'none';
            div.style.background = 'rgba(255,255,255,0)';
            var h1 = document.createElement('h1');
            h1.id = 'FSMH1';
            h1.innerText = msg;
            h1.height = '100px';
            div.appendChild(h1);
            $('body')[0].appendChild(div);
            $('#FSMH1').css('padding-top', (parseInt($('#FSMDiv').css('height').split('p')[0]) / 2)-50 + 'px');
        }
        //addFSMDiv('666');
        function hideFullScreenMessage(divID) {
            
            interval_fsm = setInterval(function () {
                alpha_div -= 0.02;
                $('#' + divID).css('background', 'rgba(255,255,255,' + alpha_div + ')');
                if (alpha_div <= 0) {
                    $('#' + divID).css('display', 'none');
                    clearInterval(interval_fsm);
                }
            }, 10);
        }
        function showFullScreenMessage(divID) {
            $('#' + divID).css('display', 'block');
            interval_fsm = setInterval(function () {
                alpha_div += 0.02;
                console.log(alpha_div);
                $('#' + divID).css('background', 'rgba(255,255,255,' + alpha_div + ')');
                if (alpha_div >= 1) {
                    clearInterval(interval_fsm);
                    setTimeout(hideFullScreenMessage(divID), 2000);
                }
            }, 10);
        }
        //showFullScreenMessage('FSMDiv');
    </script>
</asp:Content>
