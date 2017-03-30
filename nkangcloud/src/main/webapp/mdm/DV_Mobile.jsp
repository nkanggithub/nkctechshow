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
	<script src="../mdm/uploadfile_js/pageSwitch.js"></script>
	

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
	        width: '400',
	        height: '300',
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
		<div class="page page1" id="section0">
			
<div id="chart-container1" style="text-align:center;margin-top: 130px;"></div>
		</div>
		<div class="page page2" id="section1">
<div id="chart-container2" style="text-align:center;margin-top: 120px;"></div>
			</div>
			
		</div>
	<script type="text/javascript">
	 var a=new pageSwitch('container',{
     duration:1500,
     start:0,
     direction:0,
     loop:false,
     ease:'ease',
     transition:'slide',
		freeze:false,
		mouse:true,
     mousewheel:true,
     arrowkey:true
 });
	
	
	</script>
</body></html>