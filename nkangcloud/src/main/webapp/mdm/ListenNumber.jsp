<%@ page language="java" pageEncoding="UTF-8"%>
<%
	int speed = Integer.parseInt(request.getParameter("speed"));
	int numCount = Integer.parseInt(request.getParameter("numCount"));
	int lengthMax = Integer.parseInt(request.getParameter("lengthMax"));
	int lengthMin = Integer.parseInt(request.getParameter("lengthMin"));
	String qt= request.getParameter("qt");
	String uid = request.getParameter("UID");
%>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-听算练习</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<script src="../Jsp/JS/fusioncharts/fusioncharts.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.widgets.js"></script>
<script src="../Jsp/JS/fusioncharts/fusioncharts.theme.fint.js"></script>
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
#endPanel,#right,#wrong,#chart-container,#Result {
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
			<div class="circle start bigger">听数开始</div>
		</div>
	</section>
	<section id="endPanel">
		<div class="selectPanel">
			<p>请输入答案</p>
			<input id="answer" type="text" class="niput" value=""
				style="border-bottom: 1px solid #22B26F; width: 60%; margin-bottom: 60px;">
			<div class="circle end bigger">提交答案</div>
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
			<div id="answerInput" style="width:60%;margin-left:20%;"></div>
			<div style="border-top: 1px solid black;width: 60%;margin-left: 20%;">
			<input type="text" style="width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;" class="niput" value="=" disabled=""/>
			<input id="total" type="text" style="width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%" class="niput" value="" disabled="">
			</div>
			<div style="text-align: center; margin: 15px;">
				<input id="next" type="button" class="btn btn-primary start middleBtn"
					value="下一题">
				<!-- <input type="text" id="timetext" value="00时00分00秒" readonly><br>-->


			</div>
		</div>


	</section>

	<div id="Result"></div>
	<div id="chart-container">FusionCharts will render here</div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script src="../Jsp/JS/leshu/jQuery.speech.js"></script>
	<script>
		var speed=<%=speed%>;
		var length=2;
		var uid='<%=uid%>';
		var text = "开始,";
		var tempArray = new Array();
		var numCount =<%=numCount%>;
		var lengthMin =<%=lengthMin%>;
		var lengthMax =<%=lengthMax%>;
		var totalTime=0;
		var charArray = new Array('减', '加', '加');
		var tempCharArray = new Array();
		var qt='<%=qt%>';

		function count(chara, oldNumer, newNumber) {
			var result;
			if (chara == '加') {
				result = oldNumer + newNumber;
			} else {

				result = oldNumer - newNumber;
			}
			return result;
		}
		function switchChar(chara) {
			var result;
			if (chara == '加') {
				result = '+';
			} else {

				result = '-';
			}
			return result;
		}

		var total = 0;
		function showAnswer() {
			$("#answerInput").html("");
			var c;
			for (var i = 0; i < numCount; i++) {
				if (i == 0) {
					$("#answerInput")
							.append(
									"<input type='text' style='width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;' class='niput' value='+' disabled />"
											+ "<input type='text' style='width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%' class='niput' value="
											+ tempArray[i] + " disabled />");
				} else {
					c = switchChar(tempCharArray[i - 1]);
					$("#answerInput")
							.append(
									"<input type='text' style='width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;' class='niput' value="
											+ c
											+ " disabled />"
											+ "<input type='text' style='width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%' class='niput' value="
											+ tempArray[i] + " disabled />");
				}
			}
			total = 0;
			for (var i = 0; i < tempArray.length; i++) {
				if (i == 0) {
					total = parseInt(tempArray[i]);
				} else {
					total = count(tempCharArray[i - 1], total,
							parseInt(tempArray[i]));
				}

				$("#total").val("正确答案：" + total);

			}
		}
		var ge = 0;
		var shi = 0;
		var bai = 0;
		var qian = 0;
		var wan = 0;
		var shiwan = 0;
		var baiwan = 0;
		var qianwan = 0;
		var yi = 0;
		var shiyi = 0;
		var charQ = 0;
		var chars;
		var temp = "";
		function getNum() {
			temp = "";
			text = "请听题,";
			for (var i = 0; i < numCount; i++) {

				length = Math.round(Math.random() * (lengthMax - lengthMin)
						+ lengthMin);
				if (i != numCount - 1) {
					charQ = Math.round(Math.random() * (charArray.length - 1));
					chars = charArray[charQ];
					tempCharArray[i] = chars;
					chars = chars + ',';
				} else {
					chars = '';
				}

				if (i != 0 && tempCharArray[i - 1] == '减') {
					var minusNumber = getVoiceForNumber(i);
					while (tempArray[i - 1] - minusNumber <= 0
							|| currentTotal - minusNumber <= 0) {
						if (length != 1 && length != lengthMin) {
							length = length - 1;
						}
						minusNumber = getVoiceForNumber(i);
					}
					tempArray[i] = minusNumber;
					if (length != 1) {
						temp += replaceZero(tempString, length) + ',' + chars;
					} else {

						temp += yitemp + ',' + chars;
					}
				} else {
					getVoiceForNumber(i);
					if (length != 1) {
						temp += replaceZero(tempString, length) + ',' + chars;
					} else {

						temp += yitemp + ',' + chars;
					}
				}

				if (i != 0) {
					currentTotal = count(tempCharArray[i - 1], currentTotal,
							tempArray[i]);
				}

			}

			text = text + temp + "请答题";
			$("#Result").text(text);
			console.log(text);
			return text;
		}

		var yitemp = "";
		function getVoiceForNumber(i) {
			if (length == 1) {
				yitemp = Math.round(Math.random() * 8) + 1;
				tempArray[i] = yitemp;
			}
			if (length == 2) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 8) + 1;
				tempString = switchString(shi, '十') + switchString(ge, '');
				tempArray[i] = shi * 10 + ge;
			}
			if (length == 3) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 8) + 1;
				tempString = switchString(bai, '百') + switchString(shi, '十')
						+ switchString(ge, '');
				tempArray[i] = bai * 100 + shi * 10 + ge;
			}
			if (length == 4) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 8) + 1;
				tempString = switchString(qian, '千') + switchString(bai, '百')
						+ switchString(shi, '十') + switchString(ge, '');
				tempArray[i] = qian * 1000 + bai * 100 + shi * 10 + ge;
			}
			if (length == 5) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 9);
				wan = Math.round(Math.random() * 8) + 1;
				tempString = switchString(wan, '万') + switchString(qian, '千')
						+ switchString(bai, '百') + switchString(shi, '十')
						+ switchString(ge, '');
				tempArray[i] = wan * 10000 + qian * 1000 + bai * 100 + shi * 10
						+ ge;
			}
			if (length == 6) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 9);
				wan = Math.round(Math.random() * 9);
				shiwan = Math.round(Math.random() * 8) + 1;
				tempString = switchString(shiwan, '十万')
						+ switchString(wan, '万') + switchString(qian, '千')
						+ switchString(bai, '百') + switchString(shi, '十')
						+ switchString(ge, '');
				tempArray[i] = shiwan * 100000 + wan * 10000 + qian * 1000
						+ bai * 100 + shi * 10 + ge;
			}
			if (length == 7) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 9);
				wan = Math.round(Math.random() * 9);
				shiwan = Math.round(Math.random() * 9);
				baiwan = Math.round(Math.random() * 8) + 1;
				tempString = switchString(baiwan, '百万')
						+ switchString(shiwan, '十万') + switchString(wan, '万')
						+ switchString(qian, '千') + switchString(bai, '百')
						+ switchString(shi, '十') + switchString(ge, '');
				tempArray[i] = baiwan * 1000000 + shiwan * 100000 + wan * 10000
						+ qian * 1000 + bai * 100 + shi * 10 + ge;
			}
			if (length == 8) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 9);
				wan = Math.round(Math.random() * 9);
				shiwan = Math.round(Math.random() * 9);
				baiwan = Math.round(Math.random() * 9);
				qianwan = Math.round(Math.random() * 8) + 1;
				tempString = switchString(qianwan, '千万')
						+ switchString(baiwan, '百万')
						+ switchString(shiwan, '十万') + switchString(wan, '万')
						+ switchString(qian, '千') + switchString(bai, '百')
						+ switchString(shi, '十') + switchString(ge, '');
				tempArray[i] = qianwan * 10000000 + baiwan * 1000000 + shiwan
						* 100000 + wan * 10000 + qian * 1000 + bai * 100 + shi
						* 10 + ge;
			}
			if (length == 9) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 9);
				wan = Math.round(Math.random() * 9);
				shiwan = Math.round(Math.random() * 9);
				baiwan = Math.round(Math.random() * 9);
				qianwan = Math.round(Math.random() * 9);
				yi = Math.round(Math.random() * 8) + 1;
				tempString = switchString(yi, '亿')
						+ switchString(qianwan, '千万')
						+ switchString(baiwan, '百万')
						+ switchString(shiwan, '十万') + switchString(wan, '万')
						+ switchString(qian, '千') + switchString(bai, '百')
						+ switchString(shi, '十') + switchString(ge, '');
				tempArray[i] = yi * 100000000 + qianwan * 10000000 + baiwan
						* 1000000 + shiwan * 100000 + wan * 10000 + qian * 1000
						+ bai * 100 + shi * 10 + ge;
			}

			if (length == 10) {
				ge = Math.round(Math.random() * 9);
				shi = Math.round(Math.random() * 9);
				bai = Math.round(Math.random() * 9);
				qian = Math.round(Math.random() * 9);
				wan = Math.round(Math.random() * 9);
				shiwan = Math.round(Math.random() * 9);
				baiwan = Math.round(Math.random() * 9);
				qianwan = Math.round(Math.random() * 9);
				yi = Math.round(Math.random() * 9);
				shiyi = Math.round(Math.random() * 8) + 1;
				tempString = switchString(shiyi, '十亿')
						+ switchString(qianwan, '千万')
						+ switchString(baiwan, '百万')
						+ switchString(shiwan, '十万') + switchString(wan, '万')
						+ switchString(qian, '千') + switchString(bai, '百')
						+ switchString(shi, '十') + switchString(ge, '');
				tempArray[i] = shiyi * 1000000000 + yi * 100000000 + qianwan
						* 10000000 + baiwan * 1000000 + shiwan * 100000 + wan
						* 10000 + qian * 1000 + bai * 100 + shi * 10 + ge;
			}
			if (i == 0) {
				currentTotal = tempArray[0];
			}
			return tempArray[i];
		}
		function endVoice() {

			$("#answerPanel").hide();
			$("#startPanel").hide();
			$("#answerInput").html("");
			$("#endPanel").show();
		};

		$('#Result').speech({
			"speech" : true,
			"speed" : speed,
			"bg" : "./images/speech.png"
		});
		$(".end").on("click", function() {

			var answer = $("#answer").val();
			if (answer == "") {
				swal("未答题", "请输入你的答案哦~！", "error");
				;
				return;
			} 
			if(totalTime==10){
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
									"value" : millisecond / 1000 + second - 3
								} ]
							}
						}
					}).render();
				});
				$("#chart-container").show();
			}
			showAnswer();

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
		$(".exit").on("click", function() {
			window.location.href = "Navigator.jsp?UID=" + uid;
		});
	</script>
</body>
</html>