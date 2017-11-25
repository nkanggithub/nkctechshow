<%@ page language="java" pageEncoding="UTF-8"%>
<%
String uid = request.getParameter("UID"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-练习参数</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
	<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">

<!-- slider -->
<link rel="stylesheet" href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
<!-- jquery, jqueryui --> 
<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script> 


<!-- slider --> 
<script src="../Jsp/JS/speedTab/jquery-ui-slider-pips.js"></script> 

<!-- app --> 
<script src="../Jsp/JS/speedTab/examples.js"></script> 
<!-- app -->
<link rel="stylesheet" href="../Jsp/JS/speedTab/app.min.css" />
	<style type="text/css">
body {
	background-color: #fff;
	text-align: center;
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
.margin-left{
margin-left:100px;
}
.margin-right{
margin-right:10px;
}
.numPanel {
	font-size: 45px !important;
	color: #F94082 !important;
	text-align: center;
}

#speedAjust,#menuPanel,#lengthCountPanel {
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
</head>
<body><div id="data_model_div" style="height:110px" >
<i class="icon" style="position:absolute;top:20px;left:20px;z-index:100;">
<img class="exit" src="http://leshu.bj.bcebos.com/icon/EXIT1.png" style="width: 30px; height: 30px; "></i>	
<img style="position:absolute;top:8px;right:20px;z-index:100;height:60px;" class="HpLogo" src="http://leshu.bj.bcebos.com/standard/leshuLogo.png" alt="Logo">
<div style="width:100%;height: 80px;background: white;position:absolute;border-bottom: 4px solid #20b672;">
</div></div>

      <section class="sub-block" id="speedAjust">

        <div class="tabs-content">
          <div class="content active" id="show-rest-slider-result">
            <div id="show-rest-slider"></div>
          </div>
			<i id="slowspeed" class="fa fa-bicycle fa-2x" style="float:left;margin-top:-60px;"></i>
			<i id="fastspeed" class="fa fa-fighter-jet fa-2x" style="float:right;margin-top:-60px;"></i>
        </div>
		
		<i id="backLength" class="fa fa-arrow-circle-left fa-5x margin-right"></i>
		<i id="toMenu" class="fa fa-arrow-circle-right fa-5x  margin-left"></i>
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
		<i id="backNumCount" class="fa fa-arrow-circle-left fa-5x  margin-right"></i>
		<i id="toSpeed" class="fa fa-arrow-circle-right fa-5x  margin-left"></i>
		<p style="line-height: 40px;">选择位数</p>
	</section>
	
	<section id="menuPanel">
		<div class="selectPanel">
			<div id="ks" class="circle">看算</div>
			<div id="ss" class="circle">闪算</div>
			<div id="ts" class="circle">听算</div>
		</div>
		<i id="backSpeed" class="fa fa-arrow-circle-left fa-5x"></i>
	</section>
	<script src="../Jsp/JS/jquery-1.8.0.js"></script>
	<script>
	var speed=2;
	var numCountArray=new Array(3,5,8,10);
	var lengthArray=new Array(10,100,1000,10000);
	
	var uid='<%=uid%>';
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

	  $(".exit").on("click",function(){
		  window.location.href="profile.jsp?UID="+uid;
	  });
	$("#toSpeed").on("click",function(){
	$("#lengthCountPanel").hide();
	$("#speedAjust").show();
	});
	$("#toMenu").on("click",function(){
	$("#speedAjust").hide();
	$("#menuPanel").show();
	});
	

	$("#backLength").on("click",function(){
	$("#speedAjust").hide();
	$("#lengthCountPanel").show();
	});
	$("#backNumCount").on("click",function(){
	$("#numCountPanel").show();
	$("#lengthCountPanel").hide();
	});
	$("#backSpeed").on("click",function(){
	$("#speedAjust").show();
	$("#menuPanel").hide();
	});
	$("#ss").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="FlashNumber.jsp?speed="+speed+"&numCount="+numCount+"&length="+length+"&UID="+uid;
	});
	$("#ks").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="ShowNumber.jsp?speed="+speed+"&numCount="+numCount+"&length="+length+"&UID="+uid;
	});
	$("#ts").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="ListenNumber.jsp?speed="+speed+"&numCount="+numCount+"&length="+length+"&UID="+uid;
	});
</script>
</body>
</html>