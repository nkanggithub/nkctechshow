<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-看算练习</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
	<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<%@ include file="tiku.jsp" %>
</head>
<body>
	<center>
		<img
			src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EG8wW&amp;oid=00D90000000pkXM"
			height="51" width="100">
	</center>
	<div>题库管理</div>
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
	color: red !important;
	text-align: center;
}

#startPanel,#endPanel,#processPanel {
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

.bigger {
	width: 160px;
	height: 160px;
	line-height: 160px;
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
			<div class="circle start bigger">看数开始</div>
		</div>
	</section>
	<section id="processPanel">
		<div class="selectPanel">
			<div id="ShowNumberPanel" class="circle start numPanel bigger">看数</div>
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
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script>

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
            view.text(num);	
			textToShow=textToShow+num+",";
            nnto = setTimeout("hideNumber()", 1000);
            snto = setTimeout("ShowNumber()", 1000);
            currentShowCount++;
        }

        function hideNumber() {
            view.text("");
        }

       
	function showAnswer(){
 $("#answerInput").html("");
	var tempArray=textToShow.split(",");
	for(var i=0;i<numCountArray[numCount];i++){
	$("#answerInput").append("<input type='text' class='niput' value="+tempArray[i]+" disabled />")
	}
		var total=0;
	for(var i=0;i<tempArray.length-1;i++){
	total+=parseInt(tempArray[i]);}

	$("#total").val("正确答案：" + total);
	
	textToShow="";
	} 
	
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
	showAnswer();
	});
	$(".start").on("click",function(){
	$("#answerPanel").hide();
	$("#startPanel").hide();
	$("#processPanel").show();
	start();
	});
</script>



  <form name="loginForm" method="post" action="../AbacusQuiz/addAbacusQuizPool">
    <table>
     <tr>
        <td>title:<input type="text" name="title"></td>
      </tr>
       <tr>
        <td>category:<input type="text" name="category"></td>
      </tr>
       <tr>
        <td>checkpoint:<input type="text" name="checkpoint"></td>
      </tr>
       <tr>
        <td>question:<input type="text" name="question"></td>
      </tr>
      
       <tr>
        <td>batchId:<input type="text" name="batchId"></td>
      </tr>
       <tr>
        <td>questionSequence:<input type="text" name="qSequence"></td>
      </tr>
       <tr>
        <td>grade:<input type="text" name="grade"></td>
      </tr>
      <tr>
        <td><input type="submit" value="提交" style="background-color:pink">  <input type="reset" value="重置" style="background-color:red"></td>     
      </tr>
      <tr>
      </tr>
    </table>
  </form>

<p>

<form name="loginForm1" method="post" action="../AbacusQuiz/updateHistoryQuiz">
    <table>
     <tr>
        <td>openID:<input type="text" name="openID"></td>
      </tr>
       <tr>
        <td>category:<input type="text" name="category"></td>
      </tr>
       <tr>
        <td>qNumber:<input type="text" name="qNumber"></td>
      </tr>
      <tr>
        <td><input type="submit" value="提交" style="background-color:pink">  <input type="reset" value="重置" style="background-color:red"></td>     
      </tr>
      <tr>
      </tr>
    </table>
  </form>
</body>
</html>