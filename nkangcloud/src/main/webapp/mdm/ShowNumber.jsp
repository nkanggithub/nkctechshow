<%@ page language="java" pageEncoding="UTF-8"%>
<%
	int speed = Integer.parseInt(request.getParameter("speed"));
	int numCount = Integer.parseInt(request.getParameter("numCount"));
	int lengthMax = Integer.parseInt(request.getParameter("lengthMax"));
	int lengthMin = Integer.parseInt(request.getParameter("lengthMin"));
	String qt= request.getParameter("qt");
	String display="none";
	if(qt.equals("minute")){
		display="block";
	}
	String uid = request.getParameter("UID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-看算练习</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<script src="../Jsp/JS/fusioncharts/fusioncharts.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.widgets.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.theme.fint.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.charts.js"></script>
<link rel="stylesheet" type="text/css"
	href="../Jsp/JS/leshu/bootstrap.min.css" />
<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">
<link rel="stylesheet"
	href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="../MetroStyleFiles/sweetalert.css" />
<script src="../MetroStyleFiles/sweetalert.min.js"></script>
<script src="../Jsp/JS/speedTab/jquery-ui-slider-pips.js"></script>
<script src="../Jsp/JS/speedTab/examples.js"></script>
<link rel="stylesheet" href="../Jsp/JS/speedTab/app.min.css" />
<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/custom.css" />
<script src="../Jsp/JS/leshu/custom.js"></script>
<style type="text/css">
#processPanel,#endPanel,#right,#wrong,#chart-container,#chart-container2 {
	display: none;
}

</style>
</head>
<body>
	<div id="data_model_div" style="height: 110px">
		<i class="icon"
			style="position: absolute; top: 20px; left: 20px; z-index: 100;">
			<img class="exit" src="http://leshu.bj.bcebos.com/icon/EXIT1.png"
			style="width: 30px; height: 30px;">
		</i> <img
			style="position: absolute; top: 8px; right: 20px; z-index: 100; height: 60px;"
			class="HpLogo"
			src="http://leshu.bj.bcebos.com/standard/leshuLogo.png" alt="Logo">
		<div
			style="width: 100%; height: 80px; background: white; position: absolute; border-bottom: 4px solid #20b672;">
		</div>
	</div>
<input type="text" id="timestext" class="niput" value="" style="position: absolute;width: 30%;left: 0px;text-align: left;top: 80px;z-index: -2;">
<input type="text" id="timetext" class="niput" value="0时0分0秒" style="display:<%=display%>;width: 40%;padding: 0px;position: absolute;top: 80px;right: 10px;text-align: right;background: none;">
	<section id="startPanel">
		<div class="selectPanel">
			<div class="circle start bigger">看数开始</div>
		</div>
	</section>
	<section id="processPanel">
		<div id="questionInput"  style="width:60%;margin-left:20%;margin-top: 0px;padding-top: 20px;padding-bottom:0" class="selectPanel"></div>
		<input id='answer' placeholder='请输入答案' style='border-top: 1px solid black;width: 70%;' type='text' class='niput'>
		<div class="circle end bigger">提交答案</div>
	</section>
	<section id="answerPanel" class="white intro" style="display: none">
		<div class="selectPanel" style="margin-top: 0px;padding-top: 0;">
			<div id="right">
				<i class="fa fa-smile-o fa-3x"></i> <span
					style="font-size: 18px; display: inline-block; height: 30px; position: relative; top: -5px; margin-left: 10px;">真棒</span>
			</div>
			<div id="wrong">
				<i class="fa fa-frown-o fa-3x" style="color: #F94082;"></i> <span
					style="font-size: 18px; display: inline-block; height: 30px; position: relative; top: -5px; margin-left: 10px;">加油</span>
			</div>
			<div id="answerInput" style="width:60%;margin-left:20%;"></div>
			<div style="border-top: 1px solid black;width: 60%;margin-left: 20%;">
			<input type="text" style="width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;" class="niput" value="=" disabled=""/>
			<input id="total" type="text" style="width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%" class="niput" value="" disabled="">
			</div>
			<div style="text-align: center; margin: 15px;">
				<input id="next" type="button" class="btn btn-primary start middleBtn"
					value="下一题">
			</div>
		</div>


	</section>
	<div id="chart-container">FusionCharts will render here</div>
	<div id="chart-container2">FusionCharts will render here</div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script>
	var speed=<%=speed%>;
	var numCount=<%=numCount%>;
	var lengthMin=<%=lengthMin%>;
	var lengthMax=<%=lengthMax%>;
	var uid='<%=uid%>';
	var qt='<%=qt%>';
	var rightQ=0;
	var wrongQ=0;
	var totalTime=0;
		var charArray = new Array('-', '+', '+');
		var tempCharArray = new Array();
		var tempArray = new Array();
		var lengthArray = new Array(0, 10, 100, 1000, 10000, 100000, 1000000,
				10000000, 100000000, 1000000000);
		$(".start").on("click", function() {
			var tempTime=minute*60+ (millisecond / 1000) + second;
			if($(this).val()=="查看战绩"){

				FusionCharts.ready(function() {
					var cSatScoreChart = new FusionCharts({
						type : 'angulargauge',
						renderAt : 'chart-container',
						width : '400',
						height : '250',
						dataFormat : 'json',
						dataSource : {
							"chart" : {
								"caption" : "计时统计",
								"subcaption" : "计算时间(秒)",
								"lowerLimit" : "0",
								"upperLimit" : "60",
								"lowerLimitDisplay" : "真棒",
								"upperLimitDisplay" : "加油",
								"showValue" : "1",
								"valueBelowPivot" : "1",
								"theme" : "fint"
							},
							"colorRange" : {
								"color" : [ {
									"minValue" : "0",
									"maxValue" : "24",
									"code" : "#6baa01"
								}, {
									"minValue" : "24",
									"maxValue" : "48",
									"code" : "#f8bd19"
								}, {
									"minValue" : "48",
									"maxValue" : "60",
									"code" : "#e44a00"
								} ]
							},
							"dials" : {
								"dial" : [ {
									"value" :tempTime
								} ]
							}
						}
					}).render();
					var revenueChart = new FusionCharts({
				        type: 'msbar2d',
				        renderAt: 'chart-container2',
				        width: '400',
				        height: '250',
				        dataFormat: 'json',
				        dataSource: {
				            "chart": {
				                "caption": "看算正误统计",
				                "yAxisname": "",
				                "numberPrefix": "",
				                "paletteColors": "#1aaf5d,#FF0005",
				                "bgColor": "#ffffff",
				                "showBorder": "0",
				                "showHoverEffect":"1",
				                "showCanvasBorder": "0",
				                "usePlotGradientColor": "0",
				                "plotBorderAlpha": "10",
				                "legendBorderAlpha": "0",
				                "legendShadow": "0",
				                "placevaluesInside": "1",
				                "valueFontColor": "#ffffff",
				                "showXAxisLine": "1",
				                "xAxisLineColor": "#999999",
				                "divlineColor": "#999999",               
				                "divLineIsDashed": "1",
				                "showAlternateVGridColor": "0",
				                "subcaptionFontBold": "0",
				                "subcaptionFontSize": "14"
				            },            
				            "categories": [
				                {
				                    "category": [
				                        {
				                            "label": "看算"
				                        }
				                    ]
				                }
				            ],            
				            "dataset": [
				                {
				                    "seriesname": "正确",
				                    "data": [
				                        {
				                            "value": rightQ
				                        }
				                    ]
				                }, 
				                {
				                    "seriesname": "错误",
				                    "data": [
				                        {
				                            "value": wrongQ
				                        }
				                    ]
				                }
				            ],
				            "trendlines": [
				                {
				                    "line": [
				                        {
				                            "startvalue": "2",
				                            "color": "#0075c2",
				                            "valueOnRight": "1",
				                            "displayvalue": " "
				                        },
				                        {
				                            "startvalue": "8",
				                            "color": "#1aaf5d",
				                            "valueOnRight": "1",
				                            "displayvalue": " "
				                        }
				                    ]
				                }
				            ]
				        }
				    }).render();    
				});

				$("#chart-container2").show();
				$("#chart-container").show();
				$(this).val("下一题");
				return;
			}
			$("#answer").val("");
			if(qt=="question"){
			if(totalTime==10){
				reset();
				totalTime=0;
				 $("#chart-container").hide();
				 $("#chart-container2").hide();
				 wrongQ=0;
				 rightQ=0;
			}
			if(totalTime==0){
				timeStart();
			}
			
			}
			else if(qt=="minute"){
				if(millisecond==0&&second==0&&minute==0){
				$("#chart-container").hide();
				$("#chart-container2").hide();
				 wrongQ=0;
				 rightQ=0;
				timeStart();}
				if(second>=30){
					swal("答题结束", "三分钟到了噢~！", "warning");
					timeStop();
					FusionCharts.ready(function() {
						var cSatScoreChart = new FusionCharts({
							type : 'angulargauge',
							renderAt : 'chart-container',
							width : '400',
							height : '250',
							dataFormat : 'json',
							dataSource : {
								"chart" : {
									"caption" : "计时统计",
									"subcaption" : "计算时间(秒)",
									"lowerLimit" : "0",
									"upperLimit" : "60",
									"lowerLimitDisplay" : "真棒",
									"upperLimitDisplay" : "加油",
									"showValue" : "1",
									"valueBelowPivot" : "1",
									"theme" : "fint"
								},
								"colorRange" : {
									"color" : [ {
										"minValue" : "0",
										"maxValue" : "24",
										"code" : "#6baa01"
									}, {
										"minValue" : "24",
										"maxValue" : "48",
										"code" : "#f8bd19"
									}, {
										"minValue" : "48",
										"maxValue" : "60",
										"code" : "#e44a00"
									} ]
								},
								"dials" : {
									"dial" : [ {
										"value" :tempTime
									} ]
								}
							}
						}).render();
						var revenueChart = new FusionCharts({
					        type: 'msbar2d',
					        renderAt: 'chart-container2',
					        width: '400',
					        height: '250',
					        dataFormat: 'json',
					        dataSource: {
					            "chart": {
					                "caption": "看算正误统计",
					                "yAxisname": "",
					                "numberPrefix": "",
					                "paletteColors": "#1aaf5d,#FF0005",
					                "bgColor": "#ffffff",
					                "showBorder": "0",
					                "showHoverEffect":"1",
					                "showCanvasBorder": "0",
					                "usePlotGradientColor": "0",
					                "plotBorderAlpha": "10",
					                "legendBorderAlpha": "0",
					                "legendShadow": "0",
					                "placevaluesInside": "1",
					                "valueFontColor": "#ffffff",
					                "showXAxisLine": "1",
					                "xAxisLineColor": "#999999",
					                "divlineColor": "#999999",               
					                "divLineIsDashed": "1",
					                "showAlternateVGridColor": "0",
					                "subcaptionFontBold": "0",
					                "subcaptionFontSize": "14"
					            },            
					            "categories": [
					                {
					                    "category": [
					                        {
					                            "label": "看算"
					                        }
					                    ]
					                }
					            ],            
					            "dataset": [
					                {
					                    "seriesname": "正确",
					                    "data": [
					                        {
					                            "value": rightQ
					                        }
					                    ]
					                }, 
					                {
					                    "seriesname": "错误",
					                    "data": [
					                        {
					                            "value": wrongQ
					                        }
					                    ]
					                }
					            ],
					            "trendlines": [
					                {
					                    "line": [
					                        {
					                            "startvalue": "2",
					                            "color": "#0075c2",
					                            "valueOnRight": "1",
					                            "displayvalue": " "
					                        },
					                        {
					                            "startvalue": "8",
					                            "color": "#1aaf5d",
					                            "valueOnRight": "1",
					                            "displayvalue": " "
					                        }
					                    ]
					                }
					            ]
					        }
					    }).render();    
					});
					$("#chart-container").show();
					$("#chart-container2").show();
					reset();
					totalTime=0;
				return;
				}
			}
			getNum();
			totalTime++;
			if(qt=="question"){
				$("#timestext").val(totalTime+"/10");
			}else if(qt=="minute"){
				$("#timestext").val("第"+totalTime+"题");
			}
			$("#answerPanel").hide();
			$("#startPanel").hide();
			$("#processPanel").show();
		});

		var charQ = 0;
		var chars;
		var tempTotal = 0;
		function count(chara, oldNumer, newNumber) {
			var result;
			if (chara == '+') {
				result = oldNumer + newNumber;
			} else {

				result = oldNumer - newNumber;
			}
			return result;
		}
		function getNum() {
			$("#questionInput").html("");
			var temp = 0;
			for (var i = 0; i < numCount; i++) {
				temp = Math.round(Math.random()
						* (lengthArray[lengthMax] - lengthArray[lengthMin - 1])
						+ lengthArray[lengthMin - 1]);
				if (i != 0) {
					charQ = Math.round(Math.random() * (charArray.length - 1));
					chars = charArray[charQ];
					tempCharArray[i] = chars;
					if (chars == '-') {
						while (tempTotal - temp < 0) {
							temp = Math
									.round(Math.random()
											* (lengthArray[lengthMax] - lengthArray[lengthMin - 1])
											+ lengthArray[lengthMin - 1]);
						}
						tempArray[i] = temp;
					} else {
						tempArray[i] = temp;
					}

					tempTotal = count(tempCharArray[i], tempTotal, tempArray[i]);
				} else {
					tempCharArray[0] = "+";
					tempArray[0] = temp;
					tempTotal = temp;
				}
				$("#questionInput")
						.append(
								"<input type='text' style='width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;' class='niput' value="
										+ tempCharArray[i]
										+ " disabled />"
										+ "<input type='text' style='width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%' class='niput' value="
										+ temp + " disabled />");

			}
		}

		var total = 0;
		function showAnswer() {
			$("#answerInput").html("");
			for (var i = 0; i < numCount; i++) {
				$("#answerInput")
						.append(
								"<input type='text' style='width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;' class='niput' value="
										+ tempCharArray[i]
										+ " disabled />"
										+ "<input type='text' style='width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%' class='niput' value="
										+ tempArray[i] + " disabled />");
			}

			$("#total").val(tempTotal);

		}
		$(".end").on("click", function() {

			var answer = $("#answer").val();
			if (answer == "") {
				swal("未答题", "请输入你的答案哦~！", "error");
				return;
			} 
			if(qt=="question"&&totalTime==10){
				$("#next").val("查看战绩");
				timeStop();

			}

			showAnswer();
			if (answer == tempTotal) {
				$("#right").show();
				$("#wrong").hide();
				rightQ++;
			} else {
				$("#wrong").show();
				$("#right").hide();
				wrongQ++;
			}

			$("#processPanel").hide();
			$("#answerPanel").show();

		});
		$(".exit").on("click", function() {
			window.location.href = "Navigator.jsp?UID=" + uid;
		});
	</script>
</body>
</html>