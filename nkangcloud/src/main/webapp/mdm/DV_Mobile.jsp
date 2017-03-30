<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%-- <%
Map map = (HashMap<String,List>)request.getAttribute("map");
List<Integer> apj=(List<Integer>)map.get("APJ");
List<Integer> usa=(List<Integer>)map.get("USA");
List<Integer> mexico=(List<Integer>)map.get("MEXICO");
List<Integer> emea=(List<Integer>)map.get("EMEA");
%> --%>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>数据可视化</title>
    	<script type="text/javascript" src="../Jsp/JS/fusioncharts.js"></script>
    	<script type="text/javascript" src="../Jsp/JS/fusioncharts.powercharts.js"></script>
	<script type="text/javascript" src="../Jsp/JS/fusioncharts.theme.fint.js"></script>
			 <script src="../mdm/uploadfile_js/jquery-1.11.2.min.js"></script>
	<script src="../mdm/uploadfile_js/pageswitch.js"></script>
	<style type="text/css">
		h1,body,html{
			padding: 0;
			margin: 0;
		}
		body{
			font-family: Arial,"Microsoft YaHei","Hiragino Sans GB",sans-serif;
		}
		html,body{
			height: 100%;
			overflow: hidden;
		}
		/* 
		h1{
			font-size: 6em;
			font-weight: normal;
		}
		p{
			font-size: 2em;
			margin:0.5em 0 2em 0;
		} */
		#container,.section{
			height: 100%;
			position: relative;
		}
		#section0,
		#section1,
		#section2,
		#section3{
			background-color: #000;
			background-size: cover;
			background-position: 50% 50%;
		}
		#section0{
			background:white;
			color: #fff;
			font-size:16px;
			
		}
		#section1{
			color: #fff;
			background:white;
		}
		#section2{
			background:white;
			color: #fff;
		}
		#section3{
			background:white;
			background:#c9302c;
			text-shadow:1px 1px 1px #fff;
		}
		#section0 p{
			color: #F1FF00;
		}
		#section3 p{
			color: #00A3AF;
		}
		.left{
			float: left;
		}
		.intro{
			position: absolute;
			top: 50%;
			width: 100%;
			-webkit-transform: translateY(-50%);
			transform: translateY(-50%);
			text-align: center;
		}
		#pages{
			position:fixed;
			right: 10px;
			top: 50%;
			list-style: none;
		}
		#pages li{
			width: 8px;
			height: 8px;
			border-radius: 50%;
			background: black;
			margin: 0 0 10px 5px;
		}
		#pages li.active{
			width: 14px;
			height: 14px;
			border: 2px solid black;
			background: none;
			margin-left: 0;
		}
		#section0 .title{
			-webkit-transform: translateX(-100%);
			transform: translateX(-100%);
			-webkit-animation: sectitle0 1s ease-in-out 100ms forwards;
			animation: sectitle0 1s ease-in-out 100ms forwards;
		}
		#section0 p{
			-webkit-transform: translateX(100%);
			transform: translateX(100%);
			-webkit-animation: sec0 1s ease-in-out 100ms forwards;
			animation: sec0 1s ease-in-out 100ms forwards;
		}
		@-webkit-keyframes sectitle0{
			0%{
				-webkit-transform: translateX(-100%);
				transform: translateX(-100%);
			}
			100%{
				-webkit-transform: translateX(0);
				transform: translateX(0);
			}
		}
		@keyframes sectitle0{
			0%{
				-webkit-transform: translateX(-100%);
				transform: translateX(-100%);
			}
			100%{
				-webkit-transform: translateX(0);
				transform: translateX(0);
			}
		}
		@-webkit-keyframes sec0{
			0%{
				-webkit-transform: translateX(100%);
				transform: translateX(100%);
			}
			100%{
				-webkit-transform: translateX(0);
				transform: translateX(0);
			}
		}
		@keyframes sec0{
			0%{
				-webkit-transform: translateX(100%);
				transform: translateX(100%);
			}
			100%{
				-webkit-transform: translateX(0);
				transform: translateX(0);
			}
		}
	</style>
	<script type="text/javascript">
		$(function(){
			$("#container").switchPage({
				'loop' : true,
				'keyboard' : true,
				'direction' : 'horizontal'
			});
		});
	</script>
     <script>
    FusionCharts.ready(function () {
        var estProcChart = new FusionCharts({
            type: 'errorline',
            renderAt: 'chart-container1',
            width: '400',
            height: '300',
            dataFormat: 'json',
            dataSource: {
                "chart": {
                    "theme": "fint",
                    "xaxisname": "",
                    "yaxisname": "",
                    "numberSuffix":"",
                    "caption": "Run & Maintain Break Fix By Region",
                    "subcaption": "",
                    "showvalues": "0",
                    "plottooltext": "$seriesname, $value",
                    //Error bar configuration
                    "halferrorbar": "0",
                    "errorBarColor": "#990000",
                    "errorBarAlpha": "0",
                    "errorBarThickness": "4",
                    "errorBarWidth": "8"
                },
                "categories": [
                    {
                        "category": [
                            { "label": "Done" },
                            { "label": "Work In Progress" }, 
                            { "label": "In Planning" }
                        ]
                    }
                ],
                "dataset": [
                    {
                        "seriesname": "APJ",
                        "data": [
                                 {
                                     "value": "8",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "1",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "4",
                                     "errorvalue": ""
                                 },
                                 ]
                    },
                    {
                        "seriesname": "USA",
                        "data": [
                                 {
                                     "value": "3",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "2",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "1",
                                     "errorvalue": ""
                                 },
                                 ]
                    },
                    {
                        "seriesname": "Mexico",
                        "data": [
                                 {
                                     "value": "1",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "2",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "2",
                                     "errorvalue": ""
                                 },
                                 ]
                    },
                    {
                        "seriesname": "EMEA",
                        "data": [
                                 {
                                     "value": "1",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "1",
                                     "errorvalue": ""
                                 },
                                 {
                                     "value": "1",
                                     "errorvalue": ""
                                 },
                                 ]
                    }
                ]
            }
        }).render();
        var revenueChart = new FusionCharts({
	        type: 'doughnut2d',
	        renderAt: 'chart-container2',
	        width: '480',
	        height: '380',
	        dataFormat: 'json',
	        dataSource: {
	            "chart": {
	                "caption": "IM Metrics",
	                "subCaption": "",
	                "numberPrefix": "",
	                "startingAngle": "20",
	                "showPercentValues": "1",
	                "showPercentInTooltip": "0",
	                "enableSmartLabels": "0",
	                "enableMultiSlicing": "0",
	                "decimals": "1",
	                //Theme
	                "theme": "fint"
	            },
	            "data": [
	                {
	                    "label": "APJ",
	                    "value": "243"
	                },
	                {
	                    "label": "USA",
	                    "value": "10"
	                }, 
	                {
	                    "label": "MEXICO",
	                    "value": "108"
	                }, 
	                {
	                    "label": "EMEA",
	                    "value": "17"
	                },
	                {
	                    "label": "OTHER",
	                    "value": "5"
	                }
	            ]
	        }
	    }).render();
    });
    </script> 
</head>
<body style="margin:0px">
<div style="padding-left: 10px;height: 70px;border-bottom: 4px solid black;padding-top: 10px;">
<img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="" style="width:60%;"></div>
	<div id="container">
		<div class="section active" id="section0">
			
<div id="chart-container1" style="text-align:center;margin-top: 130px;"></div>
		</div>
		<div class="section" id="section1">
<div id="chart-container2" style="text-align:center;margin-top: 80px;"></div>
			</div>
			
		</div>

	</div>

</body></html>