<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="998.aspx.cs" Inherits="User_Interface_Layer._998" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cssCusImportHead" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="col-md-10">
            <form runat="server">
                <asp:TextBox ID="splj" runat="server" placeholder="要播放的视频链接（例：http://www.iqiyi.com/v_19rraybix0.html?fc=87bbded392d221f5）" CssClass="form-control"></asp:TextBox>
            </form>
            <!--<input type="text" id="splj" title="视频链接" placeholder="要播放的视频链接（例：http://www.iqiyi.com/v_19rraybix0.html?fc=87bbded392d221f5）" class="form-control" />-->
        </div>
        <div class="col-md-2">
            <input type="button" id="bfsp" title="播放视频" class="btn btn-success form-control" value="播放视频" onclick="play();" />
        </div>
        <br />
        <div id="spck" class="col-md-12" style="height: 555px; background-color: #000; border-radius: 4px; margin-top: 40px;">
            <iframe id="spbf" style="width: 100%; height: 100%;"></iframe>
        </div>
        <div class="col-md-4"></div>
        <div class="col-md-8" style="margin-top: 20px; text-align: right;">
            <p style="color: #808080">本页面不提供任何视频解析、缓存及下载服务，所有内容均收集自互联网</p>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content12" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        function play() {
            var qz = 'https://api.47ks.com/webcloud/?v=';
            var splj = $('#stdContentMoudle_splj')[0].value;
            if (splj == null || splj == '') { // 没有输入视频链接
                alert('请输入正确的视频链接！');
                return;
            }
            var exp = new RegExp('^http.*$');
            if (!exp.test(splj)) {
                splj = 'http://' + splj;
                $('#stdContentMoudle_splj')[0].value = splj;
            }
            var cb = qz + splj;
            $('#spbf')[0].src = cb;
        }
    </script>
    <script>
        /*
        var tt = ['C++程序设计', '经济学基础', 'Java Web 开发技术', '线性代数', '高等数学', '新编大学英语综合教程', '概率论与数理统计', '中国近现代史纲要', '基础会计', 'ASP.NET 开发技术', '数据库原理', '经济学原理', 'ERP系统原理和实施'];
        var i = parseInt(Math.random() * 100 % tt.length);
        document.title = tt[i];
        */
    </script>
</asp:Content>
