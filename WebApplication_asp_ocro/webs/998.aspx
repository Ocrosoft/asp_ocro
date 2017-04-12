<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="998.aspx.cs" Inherits="WebApplication_asp_ocro.webs._998" %>

<asp:Content ID="cssCusImportHead" ContentPlaceHolderID="cssCusImportHead" runat="server">
    <link type="text/css" rel="stylesheet" href="/css/leaflet.css" />
    <!-- leftlet -->
    <script src="/js/leaflet.js"></script>
    <!-- leaflet -->
    <script src="/js/d3.v3.min.js" charset="utf-8"></script>
    <!-- d3.js -->
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
    </style>
</asp:Content>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-9 column">
                <div id="map"></div>
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

                feature.attr("fill", function (d, i) { return color(i);}).attr("d", path); // 使用路径生成器
            };

            // 使用 leaflet 的函数进行坐标转化
            function projectPoint(x, y) {
                var point = map.latLngToLayerPoint(new L.LatLng(y, x));
                this.stream.point(point.x, point.y);
            }
        });
    </script>
</asp:Content>
