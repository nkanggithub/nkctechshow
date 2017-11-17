<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-听算练习</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<link rel="stylesheet" type="text/css"
	href="../Jsp/JS/leshu/bootstrap.min.css" />
<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
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

#Result {
	border: 3px solid #40AA53;
	margin: 0 auto;
	text-align: center;
	width: 100%;
	padding: 50px 0;
	background: #efe;
	display: none;
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
	color: #555;
	background-color: #fff;
	text-align:center;
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
		ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
		.15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	border:none;
}

.numPanel {
	font-size: 50px;
	color: red;
	height: 80px;
	text-align: center;
	font-family: shuxieti;
}

#startPanel,#endPanel {
	display: none;
}

.middleBtn {
	width: 120px;
	height: 40px;
	font-size: 18px;
	background: green !important;
}

.selectPanel {
	padding: 30px 30px;
	text-align: center;
	margin-top: 10px;
}

.circle {
	display: inline-block;
	font-size: 22px;
	margin: 8px;
	color: #717171;
	border: 1px solid green;
	border-radius: 100%;
	text-align: center;
	width: 130px;
	height: 130px;
	line-height: 130px;
}

i {
	color: green;
}

#lengthCountPanel {
	display: none;
}

.default {
	background-color: green;
	color: white;
}

.bigger {
	width: 160px;
	height: 160px;
	line-height: 160px;
}
</style>
	<section id="numCountPanel">
		<div class="selectPanel">
			<div class="circle default">三笔</div>
			<div class="circle">五笔</div>
			<div class="circle">八笔</div>
			<div class="circle">十笔</div>
		</div>
		<i id="toLength" class="fa fa-arrow-circle-right fa-5x"></i>
	</section>

	<section id="lengthCountPanel">
		<div class="selectPanel">
			<div class="circle default">一位</div>
			<div class="circle">两位</div>
			<div class="circle">三位</div>
			<div class="circle">四位</div>
		</div>
		<i id="toStart" class="fa fa-arrow-circle-right fa-5x"></i>
	</section>

	<section id="startPanel">
		<div class="selectPanel">
			<div class="circle start bigger">听数开始</div>
		</div>
	</section>
	<section id="endPanel">
		<div class="selectPanel">
			<div class="circle end bigger">显示答案</div>
		</div>
	</section>

	<section id="answerPanel" class="white intro" style="display: none">

		<div class="selectPanel">
			<div id="answerInput"></div>
			<div>

				<input placeholder="请输入以上数字总和" id="total"
					type="text" class="niput ">


			</div>
			<div style="text-align: center; margin: 15px;">
				<input type="button" class="btn btn-primary start middleBtn"
					value="再来一次">

			</div>
		</div>
	</section>
	<div id="Result"></div>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script src="../Jsp/JS/leshu/jQuery.speech.js"></script>
	<script>

	var text="开始,";
	var tempArray=new Array();
	var numCountArray=new Array(3,5,8,10);
	var lengthArray=new Array(10,100,1000,10000);
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
 showAnswer();
};
function showAnswer(){
	total=0;
	for(var i=0;i<numCountArray[numCount];i++){
	$("#answerInput").append("<input type='text' class='niput' value="+tempArray[i]+" disabled />")
	total+=parseInt(tempArray[i]);
	}
	$("#total").val("正确答案：" + total);
	
	}
	
	$('#Result').speech({
		"speech": true,
		"speed": 3,
		"bg": "./images/speech.png"
	});
	var numCount=0;
	var length=0;
	$("#numCountPanel").find(".circle").hover(function(){
	$(this).css("background-color","green");
	$(this).css("color","white");
	$(this).siblings().css({"background-color":"white","color":"black"});
	numCount=$(this).index();
	},function(){
		$(this).css("background-color","white");
	$(this).css("color","black");
	});
	
	$("#lengthCountPanel").find(".circle").hover(function(){
	$(this).css("background-color","green");
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
	$("#toStart").on("click",function(){
	$("#lengthCountPanel").hide();
	$("#startPanel").show();
	});
		$(".end").on("click",function(){
	$("#endPanel").hide();
	$("#answerPanel").show();
	});
</script>
</body>
</html>