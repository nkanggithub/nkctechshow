<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-听算练习</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<script src="../Jsp/JS/fusioncharts/fusioncharts.js"></script>
	<script src="../Jsp/JS/fusioncharts/fusioncharts.widgets.js"></script>
	<script src="../Jsp/JS/fusioncharts/fusioncharts.theme.fint.js"></script>
	<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
	<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">
	<link rel="stylesheet" href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css"/>
	<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script> 
	<script	src="../MetroStyleFiles/sweetalert.min.js"></script>
	<script src="../Jsp/JS/speedTab/jquery-ui-slider-pips.js"></script> 
	<script src="../Jsp/JS/speedTab/examples.js"></script> 
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
#Result {
	border: 3px solid #40AA53;
	margin: 0 auto;
	text-align: center;
	width: 100%;
	padding: 50px 0;
	background: #efe;
	display: none;
}
.niput {
	width: 100%;
	height: 45px;
	margin: 5px;
	padding: 12px 12px;
	font-size: 19px;
	line-height: 1.42857143;
	color: #555;
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

#startPanel,#endPanel,#processPanel,#right,#wrong,#chart-container,#speedAjust {
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

#lengthCountPanel {
	display: none;
}

.default {
	background-color: #22B26F;
	color: white;
}
</style>
      <section class="sub-block" id="speedAjust">

        <div class="tabs-content">
          <div class="content active" id="show-rest-slider-result">
            <div id="show-rest-slider"></div>
          </div>
        </div>
		
		<i id="toStart" class="fa fa-arrow-circle-right fa-5x"></i>
		<p style="line-height: 40px;">选择速度</p>
      </section>
	<section id="numCountPanel">
		<div class="selectPanel">
			<div class="circle default">三笔</div>
			<div class="circle">五笔</div>
			<div class="circle">八笔</div>
			<div class="circle">十笔</div>
		</div>
		<i id="toLength" class="fa fa-arrow-circle-right fa-5x"></i>
		<p style="line-height: 40px;">选择笔数</p>
	</section>

	<section id="lengthCountPanel">
		<div class="selectPanel">
			<div class="circle default">一位</div>
			<div class="circle">两位</div>
			<div class="circle">三位</div>
			<div class="circle">四位</div>
		</div>
		<i id="toSpeed" class="fa fa-arrow-circle-right fa-5x"></i>
		<p style="line-height: 40px;">选择位数</p>
	</section>

	<section id="startPanel">
		<div class="selectPanel">
			<div class="circle start bigger">听数开始</div>
		</div>
	</section>
	<section id="endPanel">
		<div class="selectPanel">
		  <p>请输入答案</p>
		  <input  id="answer" placeholder="请输入答案" type="text" class="niput" value="" style="border-bottom: 1px solid #22B26F;width: 60%;margin-bottom: 60px;">
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
	
	<div id="Result"></div>
	<div id="chart-container">FusionCharts will render here</div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script src="../Jsp/JS/leshu/jQuery.speech.js"></script>
	<script>
	var speed=2;
	var text="开始,";
	var tempArray=new Array();
	var numCountArray=new Array(3,5,8,10);
	var lengthArray=new Array(10,100,1000,10000);
    var total=0;
	function showAnswer(){
 	$("#answerInput").html("");
	for(var i=0;i<numCountArray[numCount];i++){
	$("#answerInput").append("<input type='text' style='margin:0;padding:0;height:40px;' class='niput' value="+tempArray[i]+" disabled />")
	}
		total=0;
	for(var i=0;i<tempArray.length;i++){
	total+=parseInt(tempArray[i]);}

	$("#total").val("正确答案：" + total);
	
	} 
	function getNum(){
	
	text="乐数珠心算开始,";
	var temp=0;
	for(var i=0;i<numCountArray[numCount];i++){
	temp=Math.round(Math.random()*lengthArray[length]);
	tempArray[i]=temp;
	text=text+temp+",";
	}
	text=text+"结束";
	$("#Result").text(text);
	console.log(text);
	return text;	
	}
	
	function endVoice() {
		 $("#answerPanel").hide();
		 $("#startPanel").hide();
		 $("#answerInput").html("");
		 $("#endPanel").show();
	};
	
	$('#Result').speech({
		"speech": true,
		"speed": speed,
		"bg": "./images/speech.png"
	});
	
	var numCount=0;
	var length=0;
	$("#numCountPanel").find(".circle").hover(function(){
	$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	$(this).siblings().css({"background-color":"white","color":"black"});
	numCount=$(this).index();
	},function(){
		$(this).css("background-color","white");
	$(this).css("color","black");
	});
	
	$("#lengthCountPanel").find(".circle").hover(function(){
	$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	$(this).siblings().css({"background-color":"white","color":"black"});
	length=$(this).index();
	},function(){
		$(this).css("background-color","white");
	$(this).css("color","black");
	});
	
	$("#toLength").on("click",function(){
	$("#numCountPanel").hide();
	$("#lengthCountPanel").show();
	});
	
	$("#toSpeed").on("click",function(){
	$("#lengthCountPanel").hide();
	$("#speedAjust").show();
	});
	$("#toStart").on("click",function(){
	$("#speedAjust").hide();
	$("#startPanel").show();
	});
		$(".end").on("click",function(){
		
			var answer=$("#answer").val();
			if(answer==""){
			swal("访问失败", "请输入你的答案哦~！", "error");;return;}
			else{
			timeStop();}
 showAnswer();
	  FusionCharts.ready(function () {
    var cSatScoreChart = new FusionCharts({
        type: 'angulargauge',
        renderAt: 'chart-container',
        width: '400',
        height: '250',
        dataFormat: 'json',
        dataSource: {
            "chart": {
                "caption": "计时统计",
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