<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="998.aspx.cs" Inherits="WebApplication_asp_ocro.webs._998" %>

<asp:Content ID="cssCusImportHead" ContentPlaceHolderID="cssCusImportHead" runat="server">
    <!-- leftlet -->
    <link type="text/css" rel="stylesheet" href="/css/leaflet.css" />
    <!-- leaflet -->
    <script src="/js/leaflet.js"></script>
    <!-- d3 -->
    <script src="/js/d3.v3.min.js" charset="utf-8"></script>
    <!-- heatmap -->
    <script src="/js/heatmap.js" charset="utf-8"></script>
    <!-- baidu map -->
    <script src="//api.map.baidu.com/api?v=1.3"></script>
    <style>
        #map {
            width: 100%;
        }

        svg {
            position: relative;
        }

        path {
            fill-opacity: .2; /* 填充透明度 */
            stroke: #fff; /* 线色 */
            stroke-width: 1.5px; /* 线宽 */
        }

            path:hover { /* 鼠标悬停时 */
                /*fill: brown;*/
                fill-opacity: .7;
            }

        #baidu_map {
            display: none;
        }

        #layer {
            z-index: 99999;
            background-color: rgba(255,255,255,0.8);
            width: 100%;
            height: 100%;
            position: fixed;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <script>
        var dv = document.createElement("div");
        dv.innerHTML = '<h1 id="loading" class="text-success">加载中，请稍候</h1>';
        dv.id = 'layer';
        var page = document.getElementsByTagName("body")[0];
        page.insertBefore(dv, page.firstChild);

        var loading_interval = setInterval(function () {
            var loading_h1 = document.getElementById('loading');
            if (loading_h1 == null) clearInterval(loading_interval);
            else {
                var text = loading_h1.innerText.trim();
                if (text.length == 10) loading_h1.innerText = "加载中，请稍候";
                else if (text.length == 7) loading_h1.innerText = "加载中，请稍候.";
                else if (text.length == 8) loading_h1.innerText = "加载中，请稍候..";
                else if (text.length == 9) loading_h1.innerText = "加载中，请稍候...";
            }
        }, 1000);
    </script>
    <form runat="server" style="display: none;">
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </form>
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-9 column">
                <div id="map"></div>
                <div id="baidu_map"></div>
            </div>
            <div class="col-md-3 column">
                <label for="sideBar">SideBar</label>
                <br />
                <label for="none">Σ( ° △ °|||)︴</label>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="stdContentSideBar" ContentPlaceHolderID="stdContentSideBar" runat="server">
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <script>
        $('#map').css('height', $('.container').css('height'));

        var map = new L.Map("map", { center: [34, 105], zoom: 4 })
            .addLayer(new L.TileLayer("https://api.mapbox.com/styles/v1/ocrosoft/cj1euool700ha2ro4ylwb373e/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoib2Nyb3NvZnQiLCJhIjoiY2oxZXVpdmxhMDA5MjJ3dXNidHYzbzc3ayJ9.jRFWntgGrOk28RaSBmfJNg", {
                attribution: '<a href="https://www.mapbox.com/">Mapbox</a> | <a href="https://www.ocrosoft.com">Ocrosoft</a>'
            }));

        var svg = d3.select(map.getPanes().overlayPane).append("svg"),
            g = svg.append("g").attr("class", "leaflet-zoom-hide");

        d3.json("china.json", function (error, collection) {
            if (error) throw error;

            var transform = d3.geo.transform({ point: projectPoint }),
                path = d3.geo.path().projection(transform);

            var color = d3.scale.category20();
            var feature = g.selectAll("path")
                .data(collection.features)
                .enter().append("path");

            map.on("viewreset", reset);
            reset();

            // 当地图大小变化的时候重新绘制
            function reset() {
                var bounds = path.bounds(collection),
                    topLeft = bounds[0],
                    bottomRight = bounds[1];

                svg.attr("width", bottomRight[0] - topLeft[0]) // 右(下角)-左(上角)=宽度
                    .attr("height", bottomRight[1] - topLeft[1]) // (右)下(角)-(左)上(角)=高度
                    .style("left", topLeft[0] + "px") // 左边距=左(上角)
                    .style("top", topLeft[1] + "px"); // 上边距=(左)上(角)

                g.attr("transform", "translate(" + -topLeft[0] + "," + -topLeft[1] + ")"); // 偏移

                feature.attr("fill", function (d, i) { return color(i); }).attr("d", path); // 使用路径生成器
            };

            // 使用 leaflet 的函数进行坐标转化
            function projectPoint(x, y) {
                var point = map.latLngToLayerPoint(new L.LatLng(y, x));
                this.stream.point(point.x, point.y);
            }
        });
        var query_finished = false;
        var baidu_map = new BMap.Map("baidu_map");
        var localSearch = new BMap.LocalSearch(baidu_map);
        // 根据省市名称查询经纬度（同时(指上一查询结果还未返回)查询返回多次，但是结果是最后一次查询的结果）
        function searchByStationName(keyword, hash, i) { // 名称，哈希表，当前查询的记录id
            localSearch.enableAutoViewport();
            localSearch.setSearchCompleteCallback(function (searchResult) {
                var poi = searchResult.getPoi(0);
                //console.log(poi.point.lng + "," + poi.point.lat);
                var lng = poi.point.lng;
                var lat = poi.point.lat;
                hash[keyword] = poi.point;
                //console.log(keyword + "=" + hash[keyword]);
                continuee(i + 1); // 查询结束后查询下一个
            });
            localSearch.search(keyword);
        }

    </script>
    <script>
        var hash = new Array();
        var data = $('#stdContentMoudle_GridView1')[0];
        var row_count = data.rows.length;
        function continuee(i) {
            if (i >= row_count) {
                query_finished = true;
                $('#layer').remove();
                return;
            }
            var html = data.rows[i].innerHTML;
            var recordDate, areaName, value;
            for (var j = 0; j < 3; j++) {
                html = html.substring(html.indexOf('>') + 1);
                //console.log(html);
                if (j == 0) recordDate = html.substring(0, html.indexOf('<'));
                else if (j == 1) areaName = html.substring(0, html.indexOf('<'));
                else if (j == 2) value = html.substring(0, html.indexOf('<'));
                html = html.substring(html.indexOf('>') + 1);
            }
            if (hash[areaName] == null) { // 如果没有查询过，则查询
                searchByStationName(areaName, hash, i);
            }
            else {
                continuee(i + 1); // 如果查询过了，直接下一个
            }
        }
        continuee(1); // 开始查询
    </script>
    <script>
        var it = setInterval(function () {
            if (query_finished) {
                console.log(hash['杭州']);
                console.log(map.latLngToLayerPoint(new L.LatLng(hash['杭州'].lat, hash['杭州'].lng)))

                clearInterval(it);
            }
            else {
                console.log('not finished');
            }
        }, 2000);
    </script>
</asp:Content>
