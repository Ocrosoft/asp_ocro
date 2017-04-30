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
            fill-opacity: 0.2; /* 填充透明度 */
            stroke: #fff; /* 线色 */
            stroke-width: 1.5px; /* 线宽 */
        }

        .path:hover { /* 鼠标悬停时 */
            /*fill: brown;*/
            fill-opacity: .7;
        }

        circle {
            opacity: 0.5;
        }

            circle:hover {
                cursor: pointer;
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

        #value_areaName #value_value {
            text-align: center;
        }

        text {
            fill: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="stdContent" ContentPlaceHolderID="stdContentMoudle" runat="server">
    <script src="js/rangeslider.min.js"></script>
    <div id="layer">
        <img id="loadingImage" src="image/Loading.gif" /><br />
        <div style="padding-left: 0px;">
            <h1 id="loadingMessageH1">
                <label id="loadingMessage" for="loadingMessage" style="padding-top: 50px;">读取数据中 0%</label>
                <script>
                    var loading_data_percent = 1;
                    var interval_loading_data = setInterval(function () {
                        if (loading_data_percent >= 100) loading_data_percent = 99; // 大于99%一直显示99%
                        $('#loadingMessage')[0].innerText = '读取数据中 ' + loading_data_percent++ + "%";
                    }, 10);
                </script>
            </h1>
        </div>
    </div>
    <!-- 添加加载层 -->
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
                        if (loadingStep == 1) { //1: 读取数据
                            clearInterval(interval_loading_data); // 停止增加
                            $('#loadingMessage')[0].innerText = '读取数据中 100%';
                        }
                        $('#loadingMessage').animate({ paddingTop: '', opacity: '0' }, 1000, function () {
                            $('#loadingMessage').remove();
                            var label = document.createElement('label');
                            label.id = 'loadingMessage';
                            label.for = 'loadingMessage';
                            label.style.paddingTop = '100px';
                            label.style.opacity = 0;
                            if (loadingStep == 1) { // 1: 读取数据
                                label.innerText = '查询数据中 0%';
                            }
                            else if (loadingStep == 2) { // 2: 查询经纬度
                                label.innerText = '数据处理中 0%';
                            }
                            else if (loadingStep == 3) { // 3: 处理数据
                                label.innerText = '加载完成！';
                                $('#loadingImage')[0].src = 'image/LoadingComplete.gif';
                                var it = setInterval(function () { $('#layer').fadeOut(1000, function () { $('#layer').remove(); }); }, 2000);
                            }
                            document.getElementById('loadingMessageH1').appendChild(label);
                            $('#loadingMessage').animate({ paddingTop: '50', opacity: '1' }, 1000, function () {
                                if (loadingStep == 1) { // 1: 读取数据
                                    areaLoading(); // 加载地区
                                }
                                else if (loadingStep == 2) {
                                    dataHandle(); // 处理数据
                                }
                                else if (loadingStep == 3) {
                                    final();
                                }
                            });
                        });
                    }
    </script>
    <!-- 侧边栏 -->
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
                        <input id="sliderYear" type="range" min="2000" max="2015" value="2013" oninput="changeValue()" /><br />
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
                        <input id="animeSpeed" type="text" class="form-control" placeholder="动画速度(前进一天的ms数)" value="1000" /><br />
                        <input id="animeButton" type="button" class="btn btn-primary form-control" onclick="playAnime();" value="从当前开始播放" />
                    </div>
                </div>

                <div class="panel panel-success">
                    <div class="panel-heading">当前数值</div>
                    <div class="panel-body">
                        <input type="text" id="value_areaName" class="form-control" /><br />
                        <input type="text" readonly="true" id="value_value" class="form-control" /><br />
                        <input id="queryButton" type="button" class="btn btn-primary form-control" onclick="queryButton();" value="查询" />
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
        var hash_areaName = new Array(); // 保存 中文名 -> 该地所有数值 的哈希表
        var time_hash = new Array(); // 保存时间 -> 数组 的哈希表
        var data; // 数据表格(原始csv)
        var area_data; // 地区数据(csv)
        var row_count; // 数据量
        var data_list = []; // 保存经纬度和AQI的数组
        var map; // leaflet 地图
        var svg; // d3 绘制地图的使用的 svg 对象
        var baidu_map; // 百度地图对象
        var localSearch; // 百度地图经纬度查询对象
        var heatmapLayer; // heatmap 图层
        var row_now = -1; // 当前处理的行
        var interval_anime; // 动画
        var circles = null; // 地点（圆对象集）
        var topLeft = [];
    </script>
    <!-- 加载leafalet，baidu，绘制地图边框，查询经纬度 -->
    <script>
        $('#map').css('height', $('.container').css('height')); // 改变 leaflet 地图大小

        map = new L.Map("map", { center: [34, 105], zoom: 4 })
            .addLayer(new L.TileLayer("https://api.mapbox.com/styles/v1/ocrosoft/cj1euool700ha2ro4ylwb373e/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoib2Nyb3NvZnQiLCJhIjoiY2oxZXVpdmxhMDA5MjJ3dXNidHYzbzc3ayJ9.jRFWntgGrOk28RaSBmfJNg", {
                attribution: '<a href="https://www.mapbox.com/">Mapbox</a> | <a href="https://www.ocrosoft.com">Ocrosoft</a>'
            })); // 生成地图

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
                    bottomRight = bounds[1];
                topLeft = bounds[0];

                svg.attr("width", bottomRight[0] - topLeft[0]) // 右(下角)-左(上角)=宽度
                    .attr("height", bottomRight[1] - topLeft[1]) // (右)下(角)-(左)上(角)=高度
                    .style("left", topLeft[0] + "px") // 左边距=左(上角)
                    .style("top", topLeft[1] + "px"); // 上边距=(左)上(角)

                g.attr("transform", "translate(" + -topLeft[0] + "," + -topLeft[1] + ")"); // 偏移

                feature.attr("fill", function (d, i) { return color(i); }).attr("d", path); // 使用路径生成器

                if (circles != null) {
                    circles.attr("cx", function (d) { return map.latLngToLayerPoint(d).x; })
                        .attr("cy", function (d) { return map.latLngToLayerPoint(d).y; })
                        .attr("r", function () { return 2 * map.getZoom(); })
                        .attr("transform", "translate(" + -topLeft[0] + "," + -topLeft[1] + ")"); // 偏移
                }
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
         */
        function searchByStationName(keyword) {
            localSearch.enableAutoViewport();
            localSearch.setSearchCompleteCallback(function (searchResult) { // 构造回调函数
                var poi, lng, lat;
                try {
                    poi = searchResult.getPoi(0); // 返回的点
                    hash[keyword] = poi.point; // 保存结果为 {lat: , lng: }
                    console.log("x1" + keyword + "x2" + poi.point.lat+"x3"+poi.point.lng);
                }
                catch (e) {
                    console.log('查询出现错误(' + keyword + ')：')
                    console.log(e);
                }

                setTimeout(function () { queryArea(); }, 1); // 查询结束后查询下一个
            });

            localSearch.search(keyword); // 进行查询，等待返回
        }
    </script>
    <!-- 数据处理 -->
    <script>
        /**
        * 加载地区信息，并查询其经纬度
        */
        function areaLoading() {
            d3.csv("/AreaName.csv", function (datas) { // 读取所有地名
                area_data = datas;
                //console.log(area_data);
                row_count = area_data.length;
                queryArea(); // 开始查询
            });
        };
        /**
        * 查询地区的经纬度
        */
        function queryArea() {
            row_now++;
            var cal = row_now / row_count * 100;
            $('#loadingMessage')[0].innerText = "查询数据中 " + Math.ceil(cal) + "%";
            if (row_now >= row_count) {
                loadingNext();
                return;
            }
            else {
                searchByStationName(area_data[row_now].areaName);
            }
        }
        /**
        * 加载AQI数据
        */
        (function loadingData() {
            d3.csv("/AQI-2013.csv", function (datas) {
                data = datas; // 获取数据
                loadingNext(); // 加载下一步
            });
        })();
        /**
         * 处理成热力图使用的数据表
         */
        function dataHandle() {
            function recordArea(d) {
                // 分地区记录
                var p = {
                    recordDate: d.recordDate,
                    value: d.value
                };
                if (hash_areaName[d.areaName] == null) { // 第一次出现
                    hash_areaName[d.areaName] = [];
                    hash_areaName[d.areaName].push(p);
                }
                else {
                    hash_areaName[d.areaName].push(p);
                }
            }
            data.forEach(function (d, i) {
                var cal = i / data.length * 100;
                $('#loadingMessage')[0].innerText = "数据处理中 " + Math.ceil(cal) + "%";

                recordArea(d);

                // 分时间记录
                var latlng = hash[d.areaName];
                var POINT = {
                    areaName: d.areaName,
                    lat: latlng.lat,
                    lng: latlng.lng,
                    value: d.value
                }
                if (i != 0) {
                    var date_last = data[i - 1].recordDate; // 上一条记录的时间
                    var date_this = d.recordDate; // 这条记录的时间
                    if (date_last != date_this) { // 时间不一样
                        time_hash[date_last] = data_list;
                        data_list = [];
                    }
                }
                data_list.push(POINT); // 构造数据并加入到列表中
            });
            // 最后一条数据
            $('#loadingMessage')[0].innerText = "数据处理中 100%";
            recordArea(data[data.length - 1]);
            var d = data[data.length - 1];
            var latlng = hash[d.areaName];
            var POINT = {
                areaName: d.areaName,
                lat: latlng.lat,
                lng: latlng.lng,
                value: d.value
            }
            var date_last = data[data.length - 2].recordDate; // 上一条记录的时间
            var date_this = d.recordDate; // 这条记录的时间
            if (date_last != date_this) { // 时间不一样
                time_hash[date_last] = data_list;
                data_list = [];
            }
            data_list.push(POINT); // 构造数据并加入到列表中
            time_hash[date_this] = data_list; // 加入最后一条记录
            loadingNext();
        }
    </script>
    <!-- 判断数据处理是否完成，并执行绘制热力图的步骤 -->
    <script>
        /**
         * 在经纬度查询结束后被调用的函数。
         */
        function final() {
            changeValue(); // 加载热力图
            loadingNext(); // 下一步
        }
    </script>
    <!-- 时间选择，刷新数据绑定 -->
    <script>
        var labelTime = $('#labelTime');

        /**
         * 滑块数值改变，修改显示时间并刷新热力图
         */
        function changeValue() {
            var year = $('#sliderYear')[0].value;
            var month = $('#sliderMonth')[0].value;
            var day = $('#sliderDay')[0].value;
            // 调整天数
            if (month == 2) {
                if (year == 2000 || year == 2004 || year == 2008 || year == 2012) { // 闰年
                    $('#sliderDay')[0].max = 29;
                    if (day == 30 || day == 31) $('#sliderDay')[0].value = 29;
                }
                else { // 平年
                    $('#sliderDay')[0].max = 28;
                    if (day == 29 || day == 30 || day == 31) $('#sliderDay')[0].value = 29;
                }
            }
            else {
                if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                    $('#sliderDay')[0].max = 31;
                }
                else if (month == 2 || month == 4 || month == 6 || month == 9 || month == 11) {
                    $('#sliderDay')[0].max = 30;
                    if (day == 31) $('#sliderDay')[0].value = 30;
                }
            }
            day = $('#sliderDay')[0].value;
            // 更新显示时间
            if (month < 10) month = 0 + month;
            if (day < 10) day = 0 + day;
            $('#labelTime').html(year + "年" + month + "月" + day + "日");
            // 查询是否有数据
            var timeString = year + '-' + month + '-' + day;
            if (time_hash[timeString] == null) {
                $('#labelNoData')[0].innerHTML = '该时间点无任何数据！<br>将保留图中原数据。';
                $('#value_value')[0].value = 'NaN';
            }
            else { // 有数据则刷新热力图
                $('#labelNoData')[0].innerHTML = '';
                var data_pack = { // 数据打包（设置一个最大值）
                    max: d3.max(time_hash[timeString]),
                    data: time_hash[timeString]
                }
                // 遍历数据更新右侧查询框中的值
                time_hash[timeString].forEach(function (d) {
                    if (d.areaName == $('#value_areaName')[0].value) {
                        $('#value_value')[0].value = d.value;
                    }
                });
                heatmapLayer.setData(data_pack); // 绑定数据（更新热力图）

                svg.selectAll("circle").remove(); // 删除所有圆（即点击显示折线图的区域）
                circles = svg.selectAll("circle")
                    .data(time_hash[timeString])
                    .enter().append("circle");
                svg.selectAll("circle").on('click', function (d) {
                    showLineChart(d.areaName);
                });
                svg.selectAll("circle").on("mouseenter", function (d) {
                    $('#value_areaName')[0].value = d.areaName;
                    $('#value_value')[0].value = d.value;
                });
                if (circles != null) {
                    circles.attr("cx", function (d) { return map.latLngToLayerPoint(d).x; })
                        .attr("cy", function (d) { return map.latLngToLayerPoint(d).y; })
                        .attr("r", function () { return 2 * map.getZoom(); })
                        .attr("transform", "translate(" + -topLeft[0] + "," + -topLeft[1] + ")"); // 偏移
                }
            }
        }
        $('input[type="range"]').rangeslider({ polyfill: false });
        /**
         * 查询按钮
         */
        function queryButton() {
            var year = $('#sliderYear')[0].value;
            var month = $('#sliderMonth')[0].value;
            var day = $('#sliderDay')[0].value;
            if (month < 10) month = 0 + month;
            if (day < 10) day = 0 + day;
            var timeString = year + '-' + month + '-' + day;
            if (time_hash[timeString] == null) {
                $('#value_value')[0].value = 'NaN';
            } else {
                time_hash[timeString].forEach(function (d) {
                    if (d.areaName == $('#value_areaName')[0].value) {
                        $('#value_value')[0].value = d.value;
                    }
                });
            }
        }
    </script>
    <!-- 动画播放 -->
    <script>
        /**
         * 播放动画按钮
         */
        function playAnime() {
            if ($('#animeButton')[0].value.indexOf('停止') != -1) {
                clearInterval(interval_anime);
                $('#animeButton')[0].value = "从当前开始播放";
                return;
            }
            var animeSpeed = $('#animeSpeed')[0].value;
            if (animeSpeed == null || animeSpeed <= 0) {
                alert('请输入合法速度！');
                return;
            }
            $('#animeButton')[0].value = "停止播放";
            interval_anime = setInterval(function () {
                var year = $('#sliderYear')[0].value;
                var year_max = $('#sliderYear')[0].max;
                var month = $('#sliderMonth')[0].value;
                var month_max = $('#sliderMonth')[0].max;
                var day = $('#sliderDay')[0].value;
                var day_max = $('#sliderDay')[0].max;

                if (day == day_max) {
                    if (month == month_max) {
                        if (year == year_max) {
                            alert('动画播放完毕！');
                            clearInterval(interval_anime);
                        }
                        else year++ , month = 1, day = 1;
                    }
                    else month++ , day = 1;
                }
                else day++;

                $('#sliderYear').val(year).change();
                $('#sliderMonth').val(month).change();
                $('#sliderDay').val(day).change();

            }, animeSpeed);
        }
    </script>
    <!-- 显示折线图 -->
    <script>  
        /**
         * 显示折线图
         * @param areaName 地区名
         */
        function showLineChart(areaName) {
            var data = hash_areaName[areaName];

            // 定义circle的半径
            var r0 = 5,
                r1 = 8;

            // 定义动画持续时间
            var duration = 500;

            var margin = { top: 20, right: 20, bottom: 30, left: 50 },
                width = 1000 - margin.left - margin.right,
                height = 500 - margin.top - margin.bottom;

            var parseDate = d3.time.format('%Y-%m-%d').parse;

            var x = d3.time.scale()
                .range([0, width]);

            var y = d3.scale.linear()
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .orient('bottom')
                .tickFormat(d3.time.format('%d'))
                .ticks(30);

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient('left')
                .ticks(10);

            var xGridAxis = d3.svg.axis()
                .scale(x)
                .orient('bottom');

            var yGridAxis = d3.svg.axis()
                .scale(y)
                .orient('left');

            var line = d3.svg.line()
                .x(function (d) { return x(d.recordDate); })
                .y(function (d) { return y(d.value); })
                .interpolate('monotone');

            var flagLine = d3.svg.line()
                .x(function (d) { return x(d.x); })
                .y(function (d) { return y(d.y); });

            var container = d3.select('.container')
                .append('svg')
                // .transition()
                .attr('width', width + margin.left + margin.right)
                .attr('height', height + margin.top + margin.bottom);

            var svg;

            show();
            function show() {

                svg = container.append('g')
                    .attr('class', 'content')
                    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

                function draw() {
                    data.forEach(function (d) {
                        d.dayText = d.recordDate;
                        d.recordDate = parseDate(d.recordDate);
                        d.value = +d.value;
                    });

                    x.domain(d3.extent(data, function (d) { return d.recordDate; }));
                    y.domain([0, d3.max(data, function (d) { return d.value; })]);

                    svg.append('text')
                        .attr('class', 'title')
                        //.text('2013年12月PV')
                        .attr('fill', '#fff')
                        .attr('x', width / 2)
                        .attr('y', 0);

                    svg.append('g')
                        .attr('class', 'x axis')
                        .attr('transform', 'translate(0,' + height + ')')
                        .call(xAxis)
                        .append('text')
                        //.text('日期')
                        .attr('transform', 'translate(' + (width - 20) + ', 0)');

                    svg.append('g')
                        .attr('class', 'y axis')
                        .call(yAxis)
                        .append('text')
                        //.text('AQI');

                    var path = svg.append('path')
                        .attr('class', 'line')
                        .attr('d', line(data));

                    var g = svg.selectAll('circle')
                        .data(data)
                        .enter()
                        .append('g')
                        .append('circle')
                        .attr('class', 'linecircle')
                        .attr('cx', line.x())
                        .attr('cy', line.y())
                        .attr('r', r0)
                        .on('mouseover', function () {
                            d3.select(this).transition().duration(duration).attr('r', r1);
                        })
                        .on('mouseout', function () {
                            d3.select(this).transition().duration(duration).attr('r', r0);
                        });

                    var tips = svg.append('g').attr('class', 'tips');

                    tips.append('rect')
                        .attr('class', 'tips-border')
                        .attr('width', 200)
                        .attr('height', 50)
                        .attr('rx', 10)
                        .attr('ry', 10);
                    d3.select('.tips').style('display', 'none');

                    var wording1 = tips.append('text')
                        .attr('class', 'tips-text')
                        .attr('color', '#fff')
                        .attr('x', 10)
                        .attr('y', 20)
                        .text('');

                    var wording2 = tips.append('text')
                        .attr('class', 'tips-text')
                        .attr('x', 10)
                        .attr('y', 40)
                        .text('');

                    container
                        .on('mousemove', function () {
                            var m = d3.mouse(this),
                                cx = m[0] - margin.left;

                            showWording(cx);

                            d3.select('.tips').style('display', 'block');
                        })
                        .on('mouseout', function () {
                            d3.select('.tips').style('display', 'none');
                        });


                    function redrawLine(cx, cy) {
                        if (cx < 0) d3.select('.flag').style('display', 'none');
                        else
                            d3.select('.flag')
                                .attr('x1', cx)
                                .attr('x2', cx)
                                .style('display', 'block');
                        showWording(cx);
                    }

                    function showTips(cx, cy) {
                        cy -= 50;
                        if (cy < 0) cy += 100;
                        d3.select('.tips')
                            .attr('transform', 'translate(' + cx + ',' + cy + ')')
                            .style('display', 'block');
                    }

                    function showWording(cx) {
                        var x0 = x.invert(cx);
                        var i = (d3.bisector(function (d) {
                            return d.recordDate;
                        }).left)(data, x0, 1);

                        var d0 = data[i - 1],
                            d1 = data[i] || {},
                            d = x0 - d0.recordDate > d1.recordDate - x0 ? d1 : d0;

                        function formatWording(d) {
                            return '日期：' + d3.time.format('%Y-%m-%d')(d.recordDate);
                        }
                        wording1.text(formatWording(d));
                        wording2.text('PV：' + d.value);


                        var x1 = x(d.recordDate),
                            y1 = y(d.value);


                        // 处理超出边界的情况
                        var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                        var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                        x1 -= dx;
                        y1 -= dy;

                        d3.select('.tips')
                            .attr('transform', 'translate(' + x1 + ',' + y1 + ')');
                    }
                }

                draw();
            }
        }
    </script>
</asp:Content>
