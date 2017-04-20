<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="999.aspx.cs" Inherits="User_Interface_Layer._999" %>

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
    <!-- leaflet-heatmap -->
    <script src="/js/leaflet-heatmap.js"></script>
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
            background-color: rgba(0,0,0,1);
            width: 100%;
            height: 100%;
            position: fixed;
            text-align: center;
            top: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <div id="layer">
        <img src="image/Loading.gif" /><br/>
        <div>
            <h1 id="loadingMessageH1">
                <label id="loadingMessage" for="loadingMessage" style="padding-top: 50px;">读取数据中...</label>
            </h1>
        </div>
    </div>
    <script>
        $('#layer').css('height', $('window').height); // 调节 layer 大小
        
        var loading_interval = setInterval(function () {
            var loading_h1 = document.getElementById('loading');
            if (loading_h1 == null) {
                clearInterval(loading_interval);
            }
        }, 2000);

        var loadingStep = 0;

        function loadingNext() {
            loadingStep++;
            $('#loadingMessage').animate({ paddingTop: '', opacity: '0' }, 1000, function () {
                $('#loadingMessage').remove();
                var label = document.createElement('label');
                label.id = 'loadingMessage';
                label.for = 'loadingMessage';
                label.style.paddingTop = '100px';
                label.style.opacity = 0;
                if (loadingStep == 1) {
                    label.innerText = '数据处理中...';
                }
                else if (loadingStep == 2) {
                    label.innerText = '加载完成！';
                    var it = setInterval(function () { $('#layer').fadeOut(1000, function () { $('#layer').remove(); }); }, 2000);
                }
                document.getElementById('loadingMessageH1').appendChild(label);
                $('#loadingMessage').animate({ paddingTop: '50', opacity: '1' }, 1000);
            });
        }
    </script>
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-9 column">
                <div id="map"></div>
                <div id="baidu_map"></div>
            </div>
            <div class="col-md-3 column">
                <div class="panel panel-success">
                    <div class="panel-heading">时间选择</div>
                    <div class="panel-body">
                        <label for="year" style="left: 5px;" id="labelTime">2000年1月1日</label>
                        <input id="sliderYear" type="range" min="0" max="15" value="0"/><br/>
                        <input id="sliderMonth" type="range" min="1" max="12" value="1"/><br/>
                        <input id="sliderDay" type="range" min="1" max="31" value="1"/>
                    </div>
                </div>
                <script>
                    var labelTime = $('#labelTime');

                    function changeValue() {
                        //console.log($('#sliderYear'));
                        var year = $('#sliderYear')[0].value;
                        var month = $('#sliderMonth')[0].value;
                        var day = $('#sliderDay')[0].value;
                        if (year < 10) year = 200 + year;
                        else year = 20 + year;
                        $('#labelTime').html(year + "年" + month + "月" + day + "日");
                    }
                    $('#sliderYear').change(changeValue);
                    $('#sliderMonth').change(changeValue)
                    $('#sliderDay').change(changeValue);
                </script>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <!-- 全局变量声明 -->
    <script>
        var hash = new Array(); // 保存 中文名 -> 经纬度 的哈希表
        var data; // 数据表格
        var row_count; // 数据量
        var data_list = []; // 保存经纬度和AQI的数组
        var map; // leaflet 地图
        var svg; // d3 绘制地图的使用的 svg 对象
        var query_finished = false; // 百度API调用结束指示
        var baidu_map; // 百度地图对象
        var localSearch; // 百度地图经纬度查询对象
    </script>
    <!-- 加载leafalet，baidu，绘制地图边框，查询经纬度 -->
    <script>
        $('#map').css('height', $('.container').css('height')); // 改变 leaflet 地图大小

        map = new L.Map("map", { center: [34, 105], zoom: 4 })
            .addLayer(new L.TileLayer("https://api.mapbox.com/styles/v1/ocrosoft/cj1euool700ha2ro4ylwb373e/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoib2Nyb3NvZnQiLCJhIjoiY2oxZXVpdmxhMDA5MjJ3dXNidHYzbzc3ayJ9.jRFWntgGrOk28RaSBmfJNg", {
                attribution: '<a href="https://www.mapbox.com/">Mapbox</a> | <a href="https://www.ocrosoft.com">Ocrosoft</a>'
            })); // 生成地图

        svg = d3.select(map.getPanes().overlayPane).append("svg"),
            g = svg.append("g").attr("class", "leaflet-zoom-hide");

        /**
        * d3 绘制中国地图
        */
        d3.json("china.json", function (error, collection) {
            if (error) throw error;

            var transform = d3.geo.transform({ point: projectPoint }),
                path = d3.geo.path().projection(transform);
            var color = d3.scale.category20();
            var feature = g.selectAll("path")
                .data(collection.features)
                .enter().append("path");

            map.on("viewreset", reset); // 绑定地图缩放变化函数
            reset(); // 调用一次 reset 函数生成地图

            /**
             * 地图缩放变化时会调用的函数。
             */
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

        baidu_map = new BMap.Map("baidu_map");
        localSearch = new BMap.LocalSearch(baidu_map);
        /**
         * 根据省市名称查询经纬度（同时(指上一查询结果还未返回)查询返回多次，但是结果是最后一次查询的结果）
         * @param keyword 要查询的地点名称
         * @param i 当前查询的记录id
         */
        function searchByStationName(keyword, i) {
            localSearch.enableAutoViewport();
            localSearch.setSearchCompleteCallback(function (searchResult) { // 构造回调函数
                var poi = searchResult.getPoi(0); // 返回的点
                var lng = poi.point.lng; // 纬度
                var lat = poi.point.lat; // 精度
                hash[keyword] = poi.point; // 保存结果为 {lat: , lng: }

                var val = data[i].value; // 获取 AQI
                var POINT = {
                    lat: lat,
                    lng: lng,
                    value: val
                };
                data_list.push(POINT); // 构造数据并加入到列表中

                continuee(i + 1); // 查询结束后查询下一个
            });

            localSearch.search(keyword); // 进行查询，等待返回
        }
    </script>
    <!-- 数据处理 -->
    <script>
        /**
        * 加载 数据
        */
        function loadingData() {
            d3.csv("/AQI.csv", function (datas) {
                data = datas; // 获取数据
                row_count = data.length; // 数据量
                loadingNext(); // 加载下一步
                continuee(1); // 开始查询
            });
        }
        loadingData();
        /**
         * 处理数据：将地名转化为经纬度，并和 AQI 数值一起加入到数据表中
         * @param i 处理第 i 条数据
         */
        function continuee(i) {
            if (i >= row_count) { // 加载完了所有数据
                query_finished = true;
                return;
            }
            var recordDate, areaName, value;
            recordDate = data[i].recordDate;
            areaName = data[i].areaName;
            value = data[i].value;
            if (hash[areaName] == null) { // 如果没有查询过，则查询
                searchByStationName(areaName, i);
            }
            else { // 如果查询过则直接读取经纬度
                var POINT = {
                    lat: hash[areaName].lat,
                    lng: hash[areaName].lng,
                    value: value
                };
                continuee(i + 1); // 如果查询过了，直接下一个
            }
        }
    </script>
    <!-- 判断数据处理是否完成，并执行绘制热力图的步骤 -->
    <script>
        /**
         * 在经纬度查询结束后被调用的函数。
         */
        function final() {
            // heatmap 配置
            var cfg = {
                "radius": 2, // 半径
                "maxOpacity": .8, // 最大透明度
                "scaleRadius": true,
                "useLocalExtrema": true,
                latField: 'lat', // 精度
                lngField: 'lng', // 维度
                valueField: 'value' // 数值
            };

            var heatmapLayer = new HeatmapOverlay(cfg); // 创建 heatmap 图层
            map.addLayer(heatmapLayer); // 将 heatmap 图层添加到地图上
            var data_pack = { // 数据打包（设置一个最大值）
                max: 200,
                data: data_list
            }

            heatmapLayer.setData(data_pack); // 绑定数据

            loadingNext();
        }

        /**
         * 检查经纬度查询是否结束，如果已经结束则执行 final() 并停止检查。
         */
        function check_Query_Finished() {
            var it = setInterval(function () {
                if (query_finished) {

                    try { // 不捕捉错误会导致 clearInterval 不执行而导致崩溃
                        final();
                    }
                    catch (err) {
                        console.log(err); // 输出错误
                    }

                    clearInterval(it); // 结束检查
                }
                else {
                }
            }, 2000);
        }

        check_Query_Finished(); // 调用检查函数
    </script>
</asp:Content>