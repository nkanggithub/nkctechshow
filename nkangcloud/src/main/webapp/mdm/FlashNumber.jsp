<%@ page language="java" pageEncoding="UTF-8"%>
<%
int speed =Integer.parseInt(request.getParameter("speed")); 
int numCount = Integer.parseInt(request.getParameter("numCount")); 
int lengthMax = Integer.parseInt(request.getParameter("lengthMax"));
int lengthMin = Integer.parseInt(request.getParameter("lengthMin"));
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
<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/custom.css" />
<script src="../Jsp/JS/leshu/custom.js"></script> 
<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">
<link rel="stylesheet" href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css"/>
<script	src="../MetroStyleFiles/sweetalert.min.js"></script>
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
	
<div id="data_model_div" style="height:110px" >
<i class="icon" style="position:absolute;top:20px;left:20px;z-index:100;">
<img class="exit" src="http://leshu.bj.bcebos.com/icon/EXIT1.png" style="width: 30px; height: 30px; "></i>	
<img style="position:absolute;top:8px;right:20px;z-index:100;height:60px;" class="HpLogo" src="http://leshu.bj.bcebos.com/standard/leshuLogo.png" alt="Logo">
<div style="width:100%;height: 80px;background: white;position:absolute;border-bottom: 4px solid #20b672;">
</div></div>

	<section id="startPanel">
		<div class="selectPanel">
			<div class="circle start bigger">闪算开始</div>
		</div>
	</section>
	<section id="processPanel">
		<div class="selectPanel">
			<div class="circle numPanel bigger"><span id="ShowNumberPanel"></span></div>
		</div>
	</section>
	<section id="endPanel">
		<div class="selectPanel">
		  <p>请输入答案</p>
		  <input  id="answer" type="text" class="niput" value="" style="border-bottom: 1px solid #22B26F;width: 60%;margin-bottom: 60px;">
			<div class="circle end bigger">显示答案</div>
		</div>
	</section>
	<section id="answerPanel" class="white intro" style="display: none">
		<div class="selectPanel">
		<div id="right">
		<i class="fa fa-smile-o fa-3x"></i>
		<span style="font-size: 18px;display: inline-block;height: 30px;position: relative;top: -5px;margin-left: 10px;">答案正确</span>
		</div>
		<div id="wrong">
		<i class="fa fa-frown-o fa-3x" style="color: #F94082;"></i>
		<span style="font-size: 18px;display: inline-block;height: 30px;position: relative;top: -5px;margin-left: 10px;">答案错误</span>
		</div>
		<div id="answerInput"></div>
		<div>
		<input style="border-top: 1px solid black;width: 60%;" id="total" type="text" class="niput " disabled="">
		</div>
		<div style="text-align: center; margin: 15px;">
		<input type="button" class="btn btn-primary start middleBtn" value="下一题">
		</div>
		</div>
	</section>
	<div id="chart-container">FusionCharts will render here</div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script>

	var speed=<%= speed%>;
	var speedArray=new Array(0,10,9,8,7,6,5,4,3,2,1);
	var numCount=<%= numCount%>;
	var length=0;
	var uid='<%=uid%>';
	var lengthMin=<%=lengthMin%>;
	var lengthMax=<%=lengthMax%>;
var textToShow="";
        var numberModel = null;
        var numberLength = 0;
        var showTime = 0;
        var intervalTime = 0;
        var view = null;
        var nnto = null;
        var snto = null;
	var lengthArray=new Array(0,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000);
	
        function start() {
		timeStart();
		$("#chart-container").hide();
		var textToShow="";
            view = $("#ShowNumberPanel");
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
        var currentShowCount = 0;
		var num=null;
        function ShowNumber() {

            if (currentShowCount >= numCount) {
                view.text("请答题");
				$("#processPanel").hide();
				$("#endPanel").show();
                return;
            }
            num=RandomNumBoth(lengthArray[lengthMin-1],lengthArray[lengthMax]);
			
			
			view.fadeIn(speedArray[speed]*300);
			
            view.text(num);	

			view.fadeOut(speedArray[speed]*300);
			textToShow=textToShow+num+",";
            snto = setTimeout("ShowNumber()", speedArray[speed]*600);
            currentShowCount++;
        }

        function hideNumber() {
		
            view.text("");	
            view.fadeIn(1000);
        }
        function RandomNumBoth(Min,Max){
            var Range = Max - Min;
            var Rand = Math.random();
            var num = Min + Math.round(Rand * Range); //四舍五入
            return num;
      }
        var total=0;
	function showAnswer(){
 $("#answerInput").html("");
	var tempArray=textToShow.split(",");
	for(var i=0;i<numCount;i++){
	$("#answerInput").append("<input type='text' style='margin:0;padding:0;height:40px;' class='niput' value="+tempArray[i]+" disabled />")
	}
		total=0;
	for(var i=0;i<tempArray.length-1;i++){
	total+=parseInt(tempArray[i]);}

	$("#total").val("正确答案：" + total);
	
	textToShow="";
	} 
		$(".end").on("click",function(){
		
			var answer=$("#answer").val();
			if(answer==""){
			swal("访问失败", "请输入你的答案哦~！", "error");;return;}
			else{
			timeStop();}
	  FusionCharts.ready(function () {
    var cSatScoreChart = new FusionCharts({
        type: 'angulargauge',
        renderAt: 'chart-container',
        width: '400',
        height: '250',
        dataFormat: 'json',
        dataSource: {
            "chart": {
                "caption": "耗时统计",
				"subcaption": "计算时间(秒)",
                "lowerLimit": "0",
                "upperLimit": "60",
                "lowerLimitDisplay": "真棒",
                "upperLimitDisplay": "加油",
                "showValue": "1",
                "valueBelowPivot": "1",
                "theme": "fint"
            },
            "colorRange": {
                "color": [
                    {
                        "minValue": "0",
                        "maxValue": "24",
                        "code": "#6baa01"
                    },
                    {
                        "minValue": "24",
                        "maxValue": "48",
                        "code": "#f8bd19"
                    },
                    {
                        "minValue": "48",
                        "maxValue": "60",
                        "code": "#e44a00"
                    }
                ]
            },
            "dials": {
                "dial": [{
                    "value": millisecond/1000+second-3
                }]
            }
        }
    }).render();    
});
  $("#chart-container").show();

	$("#endPanel").hide();
	showAnswer();
	if(answer==total){$("#right").show();
	$("#wrong").hide();}
	else{$("#wrong").show();
	$("#right").hide();}

	$("#answerPanel").show();

	});
	$(".start").on("click",function(){
	reset();
	$("#answerPanel").hide();
	$("#startPanel").hide();
	$("#processPanel").show();
	start();
	});
	
  $(".exit").on("click",function(){
	  window.location.href="Navigator.jsp?UID="+uid;
  });
</script>
</body>
</html>