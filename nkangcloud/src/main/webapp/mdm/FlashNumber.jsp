<%@ page language="java" pageEncoding="UTF-8"%>
<%
int speed =Integer.parseInt(request.getParameter("speed")); 
int numCount = Integer.parseInt(request.getParameter("numCount")); 
int length = Integer.parseInt(request.getParameter("length")); 

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
	<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">

<!-- slider -->
<link rel="stylesheet" href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
<!-- jquery, jqueryui --> 
<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script> 

<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css"/>

<script	src="../MetroStyleFiles/sweetalert.min.js"></script>
<!-- slider --> 
<script src="../Jsp/JS/speedTab/jquery-ui-slider-pips.js"></script> 

<!-- app --> 
<script src="../Jsp/JS/speedTab/examples.js"></script> 
<!-- app -->
<link rel="stylesheet" href="../Jsp/JS/speedTab/app.min.css" />
</head>
<body>
	<center>
		<img
			src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EG8wW&amp;oid=00D90000000pkXM"
			height="51" width="100">
	</center>
	<style type="text/css">
body {
	background-color: #fff;
	text-align: center;
	padding-top: 50px;
}

.sa {
	text-align: center;
}

.niput {
	width: 100%;
	height: 45px;
	margin: 5px;
	padding: 12px 12px;
	font-size: 19px;
	line-height: 1.42857143;
	color: black;
	text-align:center;
	background-color: #fff;
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
		ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
		.15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	border:none;
}

.numPanel {
	font-size: 45px !important;
	color: #F94082 !important;
	text-align: center;
}

#processPanel,#endPanel,#right,#wrong,#chart-container {
	display: none;
}

.middleBtn {
	width: 120px;
	height: 40px;
	font-size: 18px;
	background: #22B26F!important;
	    border-color: #22B26F;
}

.selectPanel {
	padding: 30px 30px;
	text-align: center;
	margin-top: 10px;
}

.selectPanel p
{
	font-size: 18px;
    color: #717171;
}
.circle {
	display: inline-block;
	font-size: 22px;
	margin: 8px;
	border: 1px solid #22B26F;
	border-radius: 100%;
	text-align: center;
	width: 130px;
	height: 130px;
	line-height: 130px;
}

.bigger {
	width: 160px;
	height: 160px;
	line-height: 160px;
}

i {
	color: #22B26F;
}


.default {
	background-color: #22B26F;
	color: white;
}
</style>
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
<span style="font-size: 18px;display: inline-block;height: 30px;position: relative;top: -5px;margin-left: 10px;">答案正确</span></div><div id="wrong">
		<i class="fa fa-frown-o fa-3x" style="
    color: #F94082;
"></i>
<span style="font-size: 18px;display: inline-block;height: 30px;position: relative;top: -5px;margin-left: 10px;">答案错误</span></div>
			<div id="answerInput"></div>
			<div>
			<input style="border-top: 1px solid black;width: 60%;" id="total" type="text" class="niput " disabled="">
			</div>
			<div style="text-align: center; margin: 15px;">
				<input type="button" class="btn btn-primary start middleBtn"
					value="再来一次">
					<!-- <input type="text" id="timetext" value="00时00分00秒" readonly><br>-->
					 

			</div>
		</div>
		
		
	</section>
				 <div id="chart-container">FusionCharts will render here</div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script>

	var speed=<%= speed%>;
	var numCount=<%= numCount%>;
	var length=<%= length%>;
var textToShow="";
        var numberModel = null;
        var numberLength = 0;
        var showTime = 0;
        var intervalTime = 0;
        var view = null;
        var nnto = null;
        var snto = null;
	var numCountArray=new Array(3,5,8,10);
	var lengthArray=new Array(10,100,1000,10000);
	
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

            if (currentShowCount >= numCountArray[numCount]) {
                view.text("结束");
				$("#processPanel").hide();
				$("#endPanel").show();
                return;
            }
			num=Math.round(Math.random()*lengthArray[length]);
			
			
			view.fadeIn(speed*300);
			
            view.text(num);	

			view.fadeOut(speed*300);
			textToShow=textToShow+num+",";
            snto = setTimeout("ShowNumber()", speed*600);
            currentShowCount++;
        }

        function hideNumber() {
		
            view.text("");	
            view.fadeIn(1000);
        }

        var total=0;
	function showAnswer(){
 $("#answerInput").html("");
	var tempArray=textToShow.split(",");
	for(var i=0;i<numCountArray[numCount];i++){
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
	
	   var hour,minute,second;//时 分 秒
    hour=minute=second=0;//初始化
    var millisecond=0;//毫秒
    var int;
    function reset()//重置
    {
      window.clearInterval(int);
      millisecond=hour=minute=second=0;
      $('#timetext').val('00时00分00秒000毫秒');
    }
  
    function timeStart()//开始
    {
      int=setInterval(timer,50);
    }
  
    function timer()//计时
    {
      millisecond=millisecond+50;
      if(millisecond>=1000)
      {
        millisecond=0;
        second=second+1;
      }
      if(second>=60)
      {
        second=0;
        minute=minute+1;
      }
  
      if(minute>=60)
      {
        minute=0;
        hour=hour+1;
      }
      $('#timetext').val(hour+'时'+minute+'分'+second+'秒'+millisecond+'毫秒');

    }
  
    function timeStop()//暂停
    {
      window.clearInterval(int);
    }
</script>
</body>
</html>