<%@ page language="java" pageEncoding="UTF-8"%>
<%
	int speed = Integer.parseInt(request.getParameter("speed"));
	int numCount = Integer.parseInt(request.getParameter("numCount"));
	int lengthMax = Integer.parseInt(request.getParameter("lengthMax"));
	int lengthMin = Integer.parseInt(request.getParameter("lengthMin"));
	String qt= request.getParameter("qt");
	String uid = request.getParameter("UID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-闪算练习</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<script src="../Jsp/JS/fusioncharts/fusioncharts.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.widgets.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.theme.fint.js"></script>
<link rel="stylesheet" type="text/css"
	href="../Jsp/JS/leshu/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/custom.css" />
<script src="../Jsp/JS/leshu/custom.js"></script>
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
<style type="text/css">
#processPanel,#endPanel,#right,#wrong,#chart-container {
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

	<section id="startPanel">
		<div class="selectPanel">
			<div class="circle start bigger">闪算开始</div>
		</div>
	</section>
	<section id="processPanel" style=" position: relative;">
		<div id="ShowNumberPanel"
			style="position: absolute; width: 100%; top: 100px; height: 50px; line-height: 50px; font-size: 30px;color:red"></div>
		<div id="ShowCharPanel"
			style="position: absolute; width: 100%; top: 60px; height: 50px; line-height: 50px; font-size: 40px;color:red"></div>
		<div class="selectPanel">
			<div class="circle numPanel bigger" style="position: relative;">
			</div>
		</div>
	</section>
	<section id="endPanel">
		<div class="selectPanel">
			<p>请输入答案</p>
			<input id="answer" type="text" class="niput" value=""
				style="border-bottom: 1px solid #22B26F; width: 60%; margin-bottom: 60px;">

			<div class="circle end bigger">显示答案</div>
		</div>
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
			<div id="answerInput" style="width: 60%; margin-left: 20%;"></div>
			<div style="border-top: 1px solid black;width: 60%;margin-left: 20%;">
			<input type="text" style="width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;" class="niput" value="=" disabled=""/>
			<input id="total" type="text" style="width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%" class="niput" value="" disabled="">
			</div>
			<div style="text-align: center; margin: 15px;">
				<input type="button" class="btn btn-primary start middleBtn"
					value="下一题">
			</div>
		</div>
	</section>
	<div id="chart-container">FusionCharts will render here</div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script>

		var speed=<%=speed%>;
		var speedArray=new Array(0,10,9,8,7,6,5,4,3,2,1);
		var numCount=<%=numCount%>;
		var tempArray = new Array();
		var length=0;
		var uid='<%=uid%>';
		var qt='<%=qt%>';
		var lengthMin =<%=lengthMin%>;
		var lengthMax =<%=lengthMax%>;
		var textToShow = "";
		var charArray = new Array('-', '+', '+');
		var tempCharArray = new Array();
		var numberModel = null;
		var numberLength = 0;
		var showTime = 0;
		var intervalTime = 0;
		var view = null;
		var nnto = null;
		var snto = null;
		var lengthArray = new Array(0, 10, 100, 1000, 10000, 100000, 1000000,
				10000000, 100000000, 1000000000);
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
		var totalTime = 0;
		function start() {
			i=0;
			$("#answer").text("");
			if (totalTime == 10) {
				reset();
				totalTime = 0;
				$("#chart-container").hide();
			}
			if (totalTime == 0) {
				timeStart();
			}
			totalTime++;
			var textToShow = "";
			view = $("#ShowNumberPanel");
			view2 = $("#ShowCharPanel");
			$(".niput").val("");
			answer = new Array();
			currentShowCount = 0;
			if (nnto != null)
				clearTimeout(nnto);
			if (snto != null)
				clearTimeout(snto);

			view.text("准备");
			view.fadeOut(1000);
			snto = setTimeout("ShowNumber()", 1000);
		}
		var answer = null;
		var i = 0;
		var num = null;
		function ShowNumber() {
			if (i >= numCount) {
				view.text("请答题");
				$("#processPanel").hide();
				$("#endPanel").show();
				return;
			}
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
			view.fadeIn(speedArray[speed] * 300);
			view2.fadeIn(speedArray[speed] * 300);
			if (i == 0) {
				view.text(tempArray[0]);
			} else {

				view2.text(chars);
				view.text(tempArray[i]);
			}

			view.fadeOut(speedArray[speed] * 300);
			view2.fadeOut(speedArray[speed] * 300);
			snto = setTimeout("ShowNumber()", speedArray[speed] * 600);
			i++;
		}

		function hideNumber() {

			view.text("");
			view.fadeIn(1000);
			view2.fadeIn(1000);
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
				swal("访问失败", "请输入你的答案哦~！", "error");
				return;
			}
			if (totalTime == 10) {
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
								"caption" : "耗时统计",
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
									"value" : millisecond / 1000 + second - 3
								} ]
							}
						}
					}).render();
				});
				$("#chart-container").show();
			}
			$("#endPanel").hide();
			showAnswer();
			if (answer == total) {
				$("#right").show();
				$("#wrong").hide();
			} else {
				$("#wrong").show();
				$("#right").hide();
			}

			$("#answerPanel").show();

		});
		$(".start").on("click", function() {
			reset();
			$("#answerPanel").hide();
			$("#startPanel").hide();
			$("#processPanel").show();
			start();
		});

		$(".exit").on("click", function() {
			window.location.href = "Navigator.jsp?UID=" + uid;
		});
	</script>
</body>
</html>