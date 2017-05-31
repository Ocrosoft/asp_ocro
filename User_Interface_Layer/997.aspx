<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="997.aspx.cs" Inherits="User_Interface_Layer._997" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="/js/jquery-2.1.4.min.js"></script>
    <script src="/js/d3.v3.min.js" charset="utf-8"></script>
    <style>
        .axis path,
        .axis line {
            fill: none;
            stroke: black;
            shape-rendering: crispEdges;
        }

        .axis text {
            font-family: sans-serif;
            font-size: 11px;
        }

        .MyRect {
            fill: steelblue;
        }

        .MyText {
            fill: white;
            text-anchor: middle;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <script>
                var hash = new Array();
                d3.csv("/01.csv", function (datas) {
                    function GetQueryString(name) {
                        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                        var r = window.location.search.substr(1).match(reg);
                        if (r !== null) return unescape(r[2]); return null;
                    }
                    datas.forEach(function (d, i) {
                        if (GetQueryString('type') == '1') {
                            //上线
                            var str = d.login.substring(0, 8);
                            if (hash[str] == null) {
                                var arr = [];
                                for (var j = 0; j < 24; j++)arr.push(0);
                                hash[str] = arr;
                            }
                            var hour = d.login.substring(8, 10);
                            var hourInt = parseInt(hour);
                            hash[str][hourInt]++;
                        }
                        else if (GetQueryString('type') == '2') {
                            // 下线
                            var str = d.logout.substring(0, 8);
                            if (hash[str] == null) {
                                var arr = [];
                                for (var j = 0; j < 24; j++)arr.push(0);
                                hash[str] = arr;
                            }
                            var hour = d.logout.substring(8, 10);
                            var hourInt = parseInt(hour);
                            hash[str][hourInt]++;
                        }
                        else if (GetQueryString('type') == '3') {
                            // 在线（出现跨天的记录时可能会出错）
                            var str = d.login.substring(0, 8);
                            if (hash[str] == null) {
                                var arr = [];
                                for (var j = 0; j < 24; j++)arr.push(0);
                                hash[str] = arr;
                            }
                            var hour_in = d.login.substring(8, 10);
                            var hour_out = d.logout.substring(8, 10);
                            var hour_in_int = parseInt(hour_in);
                            var hour_out_int = parseInt(hour_out);
                            for (var j = hour_in_int; j <= hour_out_int; j++) {
                                hash[str][j]++;
                            }
                        }
                    });
                    function draw(dataset) {
                        //画布大小
                        var width = 800;
                        var height = 600;

                        //在 body 里添加一个 SVG 画布	
                        var svg = d3.select("body")
                            .append("svg")
                            .attr("width", width)
                            .attr("height", height);

                        //画布周边的空白
                        var padding = { left: 30, right: 30, top: 20, bottom: 20 };

                        //定义一个数组
                        //var dataset = [10, 20, 30, 40, 33, 24, 12, 5];

                        //x轴的比例尺
                        var xScale = d3.scale.ordinal()
                            .domain(d3.range(dataset.length))
                            .rangeRoundBands([0, width - padding.left - padding.right]);

                        //y轴的比例尺
                        var yScale = d3.scale.linear()
                            .domain([0, d3.max(dataset)])
                            .range([height - padding.top - padding.bottom, 0]);

                        //定义x轴
                        var xAxis = d3.svg.axis()
                            .scale(xScale)
                            .orient("bottom");

                        //定义y轴
                        var yAxis = d3.svg.axis()
                            .scale(yScale)
                            .orient("left");

                        //矩形之间的空白
                        var rectPadding = 4;

                        //添加矩形元素
                        var rects = svg.selectAll(".MyRect")
                            .data(dataset)
                            .enter()
                            .append("rect")
                            .attr("class", "MyRect")
                            .attr("transform", "translate(" + padding.left + "," + padding.top + ")")
                            .attr("x", function (d, i) {
                                return xScale(i) + rectPadding / 2;
                            })
                            .attr("y", function (d) {
                                return yScale(d);
                            })
                            .attr("width", xScale.rangeBand() - rectPadding)
                            .attr("height", function (d) {
                                return height - padding.top - padding.bottom - yScale(d);
                            });

                        //添加文字元素
                        var texts = svg.selectAll(".MyText")
                            .data(dataset)
                            .enter()
                            .append("text")
                            .attr("class", "MyText")
                            .attr("transform", "translate(" + padding.left + "," + padding.top + ")")
                            .attr("x", function (d, i) {
                                return xScale(i) + rectPadding / 2;
                            })
                            .attr("y", function (d) {
                                return yScale(d);
                            })
                            .attr("dx", function () {
                                return (xScale.rangeBand() - rectPadding) / 2;
                            })
                            .attr("dy", function (d) {
                                return 20;
                            })
                            .text(function (d) {
                                return d;
                            });

                        //添加x轴
                        svg.append("g")
                            .attr("class", "axis")
                            .attr("transform", "translate(" + padding.left + "," + (height - padding.bottom) + ")")
                            .call(xAxis);

                        //添加y轴
                        svg.append("g")
                            .attr("class", "axis")
                            .attr("transform", "translate(" + padding.left + "," + padding.top + ")")
                            .call(yAxis);

                    }
                    draw(hash[GetQueryString("str")]);
                });
            </script>
        </div>
    </form>
</body>
</html>