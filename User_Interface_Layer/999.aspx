<%@ Page Title="" Language="C#" MasterPageFile="~/UIL.Master" AutoEventWireup="true" CodeBehind="999.aspx.cs" Inherits="User_Interface_Layer._999" %>

<asp:Content ID="cssCusImportHead" ContentPlaceHolderID="cssCusImportHead" runat="server">
    <link type="text/css" rel="stylesheet" href="/css/rangeslider.css" />
    <!-- leaflet -->
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
    <script>alert('当前只加载2013年数据！请耐心等待。');</script>
    <script src="js/rangeslider.min.js"></script>
    <div id="layer">
        <img id="loadingImage" src="image/Loading.gif" /><br />
        <div style="padding-left: 0px;">
            <h1 id="loadingMessageH1">
                <label id="loadingMessage" for="loadingMessage" style="padding-top: 50px;">读取数据中 0%</label>
                <script>
                    var loading_data_percent = 1;
                    var interval_loading_data = setInterval(function () { if (loading_data_percent >= 100) loading_data_percent = 99; $('#loadingMessage')[0].innerText = '读取数据中 ' + loading_data_percent++ + "%"; })
                </script>
            </h1>
        </div>
    </div>
    <script>
        $('#layer').css('height', $('window').height); // 调节 layer 大小

        var loading_point_interval;
        function add_Loading_Point_Interval() {
            loading_point_interval = setInterval(function () {
                var text = $('#loadingMessage')[0].innerText;
                if (text.length == 8) text = text.substring(0, 5);
                else if (text.length >= 5) text += '.';
                $('#loadingMessage')[0].innerText = text;
            }, 1000);
        }
        var loading_interval = setInterval(function () {
            var loading_h1 = document.getElementById('loading');
            if (loading_h1 == null) {
                clearInterval(loading_interval);
            }
        }, 2000);

        var loadingStep = 0;

        function loadingNext() {
            loadingStep++;
            clearInterval(loading_point_interval);
            if (loadingStep == 1) {
                $('#loadingMessage')[0].innerText = '读取数据中 100%';
                clearInterval(interval_loading_data);
            }
            $('#loadingMessage').animate({ paddingTop: '', opacity: '0' }, 1000, function () {
                $('#loadingMessage').remove();
                var label = document.createElement('label');
                label.id = 'loadingMessage';
                label.for = 'loadingMessage';
                label.style.paddingTop = '100px';
                label.style.opacity = 0;
                if (loadingStep == 1) {
                    label.innerText = '数据处理中 0%';
                }
                else if (loadingStep == 2) {
                    label.innerText = '加载完成！';
                    $('#loadingImage')[0].src = 'image/LoadingComplete.gif';
                    var it = setInterval(function () { $('#layer').fadeOut(1000, function () { $('#layer').remove(); }); }, 2000);
                }
                document.getElementById('loadingMessageH1').appendChild(label);
                $('#loadingMessage').animate({ paddingTop: '50', opacity: '1' }, 1000, function () {
                    if (loadingStep == 1) continuee(0); // 开始查询
                });
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
                        <label for="year" style="left: 5px;" id="labelTime">2013年1月1日</label><br />
                        <br />
                        <input id="sliderYear" type="range" min="2000" max="2015" value="2013" oninput="changeValue()"/><br />
                        <br />
                        <input id="sliderMonth" type="range" min="1" max="12" value="1" oninput="changeValue()" /><br />
                        <br />
                        <input id="sliderDay" type="range" min="1" max="31" value="1" oninput="changeValue()" /><br />
                        <div style="text-align: center;">
                            <label id="labelNoData"></label>
                        </div>
                    </div>
                </div>

                <div class="panel panel-success">
                    <div class="panel-heading">动画播放</div>
                    <div class="panel-body">
                        <input type="button" class="btn btn-primary form-control" value="从当前开始播放"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="scriptCusFooter" ContentPlaceHolderID="scriptCusFooter" runat="server">
    <!-- 全局变量声明 -->
    <script>
        var hash = new Array(); // 保存 中文名 -> 经纬度 的哈希表
        var time_hash = new Array(); // 保存时间 -> 数组 的哈希表
        var data; // 数据表格
        var row_count; // 数据量
        var data_list = []; // 保存经纬度和AQI的数组
        var map; // leaflet 地图
        var svg; // d3 绘制地图的使用的 svg 对象
        var query_finished = false; // 百度API调用结束指示
        var baidu_map; // 百度地图对象
        var localSearch; // 百度地图经纬度查询对象
        var heatmapLayer; // heatmap 图层
        var row_now = 0; // 当前处理的行
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
        /**
         * 将转换好的经纬度和AQI添加到数据表中
         * @param lat 经度
         * @param lng 纬度
         */
        function addToDataList(lat, lng) {
            var POINT = {
                lat: lat,
                lng: lng,
                value: data[row_now].value
            }
            if (row_now != 1) {
                var date_last = data[row_now- 1].recordDate; // 上一条记录的时间
                var date_this = data[row_now].recordDate; // 这条记录的时间
                if (date_last != date_this) { // 时间不一样
                    time_hash[date_last] = data_list;
                    data_list = [];
                }
            }
            data_list.push(POINT); // 构造数据并加入到列表中
        }

        baidu_map = new BMap.Map("baidu_map");
        localSearch = new BMap.LocalSearch(baidu_map);
        /**
         * 根据省市名称查询经纬度（同时(指上一查询结果还未返回)查询返回多次，但是结果是最后一次查询的结果）
         * @param keyword 要查询的地点名称
         */
        function searchByStationName(keyword) {
            localSearch.enableAutoViewport();
            localSearch.setSearchCompleteCallback(function (searchResult) { // 构造回调函数
                var poi, lng, lat;
                try{
                    poi = searchResult.getPoi(0); // 返回的点
                    lng = poi.point.lng; // 纬度
                    lat = poi.point.lat; // 经度

                    hash[keyword] = poi.point; // 保存结果为 {lat: , lng: }

                    addToDataList(lat, lng);
                }
                catch (e) {
                    console.log('查询出现错误(' + keyword + ')：')
                    console.log(e);
                }
                
                setTimeout(function () { continuee(); }, 1); // 查询结束后查询下一个
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
            d3.csv("/AQI-2013.csv", function (datas) {
                data = datas; // 获取数据
                row_count = data.length; // 数据量
                loadingNext(); // 加载下一步
            });
        }
        loadingData();
        /**
         * 处理数据：将地名转化为经纬度，并和 AQI 数值一起加入到数据表中
         */
        function continuee() {
            row_now++;
            var cal = row_now / row_count * 100;
            var text = $('#loadingMessage')[0].innerText;
            text = "数据处理中 " + Math.ceil(cal) + "%";
            $('#loadingMessage')[0].innerText = text;

            if (row_now >= row_count - 1) { // 加载完了所有数据
                time_hash[data[row_now].recordDate] = data_list;
                query_finished = true;
                return;
            }
            var recordDate, areaName, value;
            recordDate = data[row_now].recordDate;
            areaName = data[row_now].areaName;
            value = data[row_now].value;
            if (hash[areaName] == null) { // 如果没有查询过，则查询
                searchByStationName(areaName);
            }
            else { // 如果查询过则直接读取经纬度
                addToDataList(hash[areaName].lat, hash[areaName].lng);
                // 避免大量数据递归造成栈溢出
                setTimeout(function () { continuee(); }, 1);
                //var interval_continuee = setInterval(function () { continuee(); clearInterval(interval_continuee); }, 1);
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
                lngField: 'lng', // 纬度
                valueField: 'value' // 数值
            };

            heatmapLayer = new HeatmapOverlay(cfg); // 创建 heatmap 图层
            map.addLayer(heatmapLayer); // 将 heatmap 图层添加到地图上

            //heatmapLayer.setData(data_pack); // 绑定数据
            changeValue();

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
    <!-- 时间选择，刷新数据绑定 -->
    <script>
        var labelTime = $('#labelTime');

        function changeValue() {
            var year = $('#sliderYear')[0].value;
            var month = $('#sliderMonth')[0].value;
            var day = $('#sliderDay')[0].value;

            if (year == 2000 || year == 2004 || year == 2008 || year == 2012) { // 闰年
                if (month == 2) {
                    $('#sliderDay')[0].max = 29;
                    if (day == 30 || day == 31) $('#sliderDay')[0].value = 29;
                }
                else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                    $('#sliderDay')[0].max = 31;
                }
                else if (month == 2 || month == 4 || month == 6 || month == 9 || month == 11) {
                    $('#sliderDay')[0].max = 30;
                    if (day == 31) $('#sliderDay')[0].value = 30;
                }
            }
            else {
                if (month == 2) {
                    $('#sliderDay')[0].max = 28;
                    if (day==29||day == 30 || day == 31) $('#sliderDay')[0].value = 29;
                }
                else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                    $('#sliderDay')[0].max = 31;
                }
                else if (month == 2 || month == 4 || month == 6 || month == 9 || month == 11) {
                    $('#sliderDay')[0].max = 30;
                    if (day == 31) $('#sliderDay')[0].value = 30;
                }
            }
            day = $('#sliderDay')[0].value;

            if (month < 10) month = 0 + month;
            if (day < 10) day = 0 + day;
            $('#labelTime').html(year + "年" + month + "月" + day + "日");

            var timeString = year + '-' + month + '-' + day;
            if (time_hash[timeString] == null) {
                $('#labelNoData')[0].innerHTML = '该时间点无任何数据！<br>将保留图中原数据。';
            }
            else {
                $('#labelNoData')[0].innerHTML = '';
                var data_pack = { // 数据打包（设置一个最大值）
                    max: 200,
                    data: time_hash[timeString]
                }
                heatmapLayer.setData(data_pack); // 绑定数据
            }
        }

        $('input[type="range"]').rangeslider({ polyfill: false });
    </script>
</asp:Content>
