<%@ page language="java" pageEncoding="UTF-8"%>
<%
String uid = request.getParameter("UID"); %><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-练习参数</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="stylesheet" type="text/css"
	href="../Jsp/JS/leshu/bootstrap.min.css" />
<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">
<link rel="stylesheet"
	href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script>
<script src="../Jsp/JS/speedTab/jquery-ui-slider-pips.js"></script>
<script src="../Jsp/JS/speedTab/examples.js"></script>
<link rel="stylesheet" href="../Jsp/JS/speedTab/app.min.css" />
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css" />
<script src="../MetroStyleFiles/sweetalert.min.js"></script>
<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/custom.css" />
<link rel="stylesheet" type="text/css" href="../Jsp/JS/progressBar/number-pb.css">
<script type="text/javascript" src="../Jsp/JS/progressBar/jquery.velocity.min.js"></script>
<script type="text/javascript" src="../Jsp/JS/progressBar/number-pb.js"></script>
<script src="../Jsp/JS/leshu/custom.js"></script>
<link rel="stylesheet" type="text/css"
	href="../Jsp/JS/scrollMenu/funnyNewsTicker.css">
<script type="text/javascript"
	src="../Jsp/JS/scrollMenu/funnyNewsTicker.js"></script>
<style type="text/css">
#show-bi-slider-result {
	height: 100px;
}

#show-bi-slider {
	margin-top: 100px;
}

.margin-left {
	margin-left: 100px;
}

.margin-right {
	margin-right: 10px;
}

#speedAjust,#menuPanel,#lengthCountPanel,#numCountPanel,#questionTypePanel
	{
	display: none;
}

li {
	height: 100px !important;
}
.hiddenLevel,.hiddenLevelNumber
{
display:none;
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
	<section id="levelMenuPanel">
		<div class="selectPanel" style="padding: 0; height: 400px;">
			<div class="funnyNewsTicker fnt-radius fnt-shadow fnt-easing"
				style="padding: 0 !important; padding-top: 60px; height: 100%;"
				id="funnyNewsTicker1">
				<ul>
					<li>
						<div class="fnt-content" data-link="###">【第一关】 一位数直加直减</div>
						<span class="hiddenLevel">第一关</span>
						<span class="hiddenLevelNumber">1</span>
						<div class="number-pb" id="process1">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第二关】+1=+5-4
							-1=+4-5</div>
						<span class="hiddenLevel">第二关</span>
						<span class="hiddenLevelNumber">2</span>
						<div class="number-pb" id="process2">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第三关】+2=+5-3
							-2=+3-5</div>
						<span class="hiddenLevel">第三关</span>
						<span class="hiddenLevelNumber">3</span>
						<div class="number-pb" id="process3">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第四关】+3=+5-2
							-3=+2-5</div>
						<span class="hiddenLevel">第四关</span>
						<span class="hiddenLevelNumber">4</span>
						<div class="number-pb" id="process4">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第五关】+4=+5-1
							-4=+1-5</div>
						<span class="hiddenLevel">第五关</span>
						<span class="hiddenLevelNumber">5</span>
						<div class="number-pb" id="process5">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第六关】两位数直加直减</div>
						<span class="hiddenLevel">第六关</span>
						<span class="hiddenLevelNumber">6</span>
						<div class="number-pb" id="process6">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第七关】 +1=-9+10
							-1=-10+9</div>
						<span class="hiddenLevel">第七关</span>
						<span class="hiddenLevelNumber">7</span>
						<div class="number-pb" id="process7">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第八关】 +2=-8+10
							-2=-10+8</div>
						<span class="hiddenLevel">第八关</span>
						<span class="hiddenLevelNumber">8</span>
						<div class="number-pb" id="process8">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
			
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第九关】 +3=-7+10
							-3=-10+7</div>
						<span class="hiddenLevel">第九关</span>
						<span class="hiddenLevelNumber">9</span>
						<div class="number-pb" id="process9">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十关】 +4=-6+10
							-4=-10+6</div>
						<span class="hiddenLevel">第十关</span>
						<span class="hiddenLevelNumber">10</span>
						<div class="number-pb" id="process10">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十一关】 +5=-5+10
							-5=-10+5</div>
						<span class="hiddenLevel">第十一关</span>
						<span class="hiddenLevelNumber">11</span>
						<div class="number-pb" id="process11">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十二关】+6=-4+10
							-6=-10+4</div>
						<span class="hiddenLevel">第十二关</span>
						<span class="hiddenLevelNumber">12</span>
						<div class="number-pb" id="process12">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十三关】 +7=-3+10
							-7=-10+3</div>
						<span class="hiddenLevel">第十三关</span>
						<span class="hiddenLevelNumber">13</span>
						<div class="number-pb" id="process13">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十四关】 +8=-2+10
							-8=-10+2</div>
						<span class="hiddenLevel">第十四关</span>
						<span class="hiddenLevelNumber">14</span>
						<div class="number-pb" id="process14">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十五关】 +9=-1+10
							-9=-10+1</div>
						<span class="hiddenLevel">第十五关</span>
						<span class="hiddenLevelNumber">15</span>
						<div class="number-pb" id="process15">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十六关】 综合练习1</div>
						<span class="hiddenLevel">第十六关</span>
						<span class="hiddenLevelNumber">16</span>
						<div class="number-pb" id="process16">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十七关】 综合练习2</div>
						<span class="hiddenLevel">第十七关</span>
						<span class="hiddenLevelNumber">17</span>
						<div class="number-pb" id="process17">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十八关】 综合练习3</div>
						<span class="hiddenLevel">第十八关</span>
						<span class="hiddenLevelNumber">18</span>
						<div class="number-pb" id="process18">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第十九关】 一位数8笔综合练习1</div>
						<span class="hiddenLevel">第十九关</span>
						<span class="hiddenLevelNumber">19</span>
						<div class="number-pb" id="process19">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第二十关】 一位数8笔综合练习2</div>
						<span class="hiddenLevel">第二十关</span>
						<span class="hiddenLevelNumber">20</span>
						<div class="number-pb" id="process20">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第二十一关】 一位数8笔综合练习3</div>
						<span class="hiddenLevel">第二十一关</span>
						<span class="hiddenLevelNumber">21</span>
						<div class="number-pb" id="process21">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第二十二关】一位数10笔综合练习1</div>
						<span class="hiddenLevel">第二十二关</span>
						<span class="hiddenLevelNumber">22</span>
						<div class="number-pb" id="process22">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第二十三关】 一位数10笔综合练习2</div>
						<span class="hiddenLevel">第二十三关</span>
						<span class="hiddenLevelNumber">23</span>
						<div class="number-pb" id="process23">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
					<li>
						<div class="fnt-content" data-link="###">【第二十四关】一位数10笔综合练习3</div>
						<span class="hiddenLevel">第二十四关</span>
						<span class="hiddenLevelNumber">24</span>
						<div class="number-pb" id="process24">
							<div class="number-pb-shown"></div>
							<div class="number-pb-num" style="left: 85%;">0%</div>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<i id="toSpeed" class="fa fa-arrow-circle-right fa-5x"></i>
		<p style="line-height: 40px;">选择关数</p>
	</section>
	<section class="sub-block" id="speedAjust">

		<div class="tabs-content">
			<div class="cont" src/main/webapp/MetroStyleFiles"ent
				active" id="show-rest-slider-result">
				<div id="show-rest-slider"></div>
			</div>
			<i id="slowspeed" class="fa fa-bicycle fa-2x"
				style="float: left; margin-top: -60px; margin-left: 15px;"></i> <i
				id="fastspeed" class="fa fa-fighter-jet fa-2x"
				style="float: right; margin-top: -60px; margin-right: 15px;"></i>
		</div>

		<i id="backLM" class="fa fa-arrow-circle-left fa-5x margin-right"></i>
		<i id="toMenu" class="fa fa-arrow-circle-right fa-5x  margin-left"></i>
		<p style="line-height: 40px;">选择速度</p>
	</section>
	<section id="menuPanel">
		<div class="selectPanel">
			<div id="ks" class="circle">看算</div>
			<div id="ss" class="circle">闪算</div>
			<div id="ts" class="circle">听算</div>
		</div>
		<i id="backSpeed" class="fa fa-arrow-circle-left fa-5x"></i>
	</section>

	<script>
	var speed=5;
	var category="第一关";
	var uid='<%=uid%>';
	var qt='question';
	var percent;
	var levelNumber = 1;
	$(document).ready(function(){
		getLevelPercent(category,levelNumber);
	$("#funnyNewsTicker1").funnyNewsTicker({width:"80%",timer:100000,titlecolor:"#FFF",itembgcolor:"#1faf6d",infobgcolor:"#1a935c",buttonstyle:"white",bordercolor:"#1a935c"});		

	$(".fnt-bottom-arrow").on("click",function(){
    	category=$(".fnt-active").find(".hiddenLevel").text();
    	levelNumber=$(".fnt-active").find(".hiddenLevelNumber").text();
		getLevelPercent(category,levelNumber);
	});
	$(".fnt-top-arrow").on("click",function(){
    	category=$(".fnt-active").find(".hiddenLevel").text();
    	levelNumber=$(".fnt-active").find(".hiddenLevelNumber").text();
		getLevelPercent(category,levelNumber);
	});
    $(".fnt-content").on("click",function(){
    	category=$(this).parent().find(".hiddenLevel").text();
    	var text="";
    	var total=0;
    	$.ajax({
			type : "GET",
			url : "../AbacusQuiz/getAbacusQuizPoolBycategory",
			data : {
				category : category
			},
			cache : false,
			success : function(data) {
				if(data){
					total=data.length;

			    	$.ajax({
					type : "GET",
					url : "../AbacusQuiz/findHistoryQuizByOpenidAndCategory",
					data : {
						category : category,
						openid : uid
					},
					cache : false,
					success : function(data) {
						if(data&&data.questionSequence!=0&&data.questionSequence!=null){
							var answerArray=data.answers.split(",");
							var tempChar;
							var right=0;
							var wrong=0;
							var count=0;
							for(var i=0;i<answerArray.length;i++){
								if(answerArray[i]!='MISS'&&answerArray[i]!=""){
									count++;
									tempChar=answerArray[i].split("/");
									if(tempChar[2]!=0){
										right++;
									}
									else{
										wrong++;
									}
								}
							}
					    	text="<p style='width:40%;float:left;height:40px;line-height:40px;'>正确：</p><input style='margin-top:0px;width:50%;height:35px;display:block;float:left;color: black;' type='text' value='"+right+"题' disabled='true'/>"
					        	+"<p style='width:40%;float:left;height:40px;line-height:40px;'>错误：</p><input style='margin-top:0px;width:50%;height:35px;display:block;float:left;color: black;' type='text' value='"+wrong+"题' disabled='true'/>"
					        +"<p style='width:40%;float:left;height:40px;line-height:40px;'>总共完成：</p><input style='margin-top:0px;width:50%;height:35px;display:block;float:left;color: black;' type='text' value='"+count+"题/共"+total+"题' disabled='true'/>";

						}
						else
						{
							text="<p style='text-align:center;width:100%'>您还没开始做题呢~！</p>"
						}
					    swal({  
				            title:category+"战绩统计",  
				            text:text,
				            html:"true",
				            showConfirmButton:false, 
				    		showCancelButton: true,   
				    		closeOnConfirm: false,  
				            confirmButtonText:"是",  
				            cancelButtonText:"关闭",
				            animation:"slide-from-top"  
				          }, 
				    		function(inputValue){
				    			if (inputValue === false){}
				    			else{
				    			}});
					}
				});
				}
			}
		});


    });
	});	
	$("#backLM").on("click",function(){
	$("#levelMenuPanel").show();
	$("#speedAjust").hide();
	});
	  $(".exit").on("click",function(){
		  window.location.href="profile.jsp?UID="+uid;
	  });
	$("#toSpeed").on("click",function(){
	$("#levelMenuPanel").hide();
	$("#speedAjust").show();
	});
	$("#toMenu").on("click",function(){
	$("#speedAjust").hide();
	$("#menuPanel").show();
	});
	$("#backSpeed").on("click",function(){
	$("#speedAjust").show();
	$("#menuPanel").hide();
	});
	$("#ss").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="FlashNumberForBasic.jsp?category="+category+"&speed="+speed+"&UID="+uid;
	});
	$("#ks").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="ShowNumberForBasic.jsp?category="+category+"&UID="+uid;
	});
	$("#ts").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="ListenNumberForBasic.jsp?category="+category+"&speed="+speed+"&UID="+uid;
	});

    function getLevelPercent(category,levelNumber){
    	var defaultTotal=0;
    	var complete=0;
    	$.ajax({
			type : "GET",
			url : "../AbacusQuiz/getAbacusQuizPoolBycategory",
			data : {
				category : category
			},
			cache : false,
			success : function(data) {
				if(data){
					defaultTotal=data.length;
			    	$.ajax({
					type : "GET",
					url : "../AbacusQuiz/findHistoryQuizByOpenidAndCategory",
					data : {
						category : category,
						openid : uid
					},
					cache : false,
					success : function(data) {

						if(data&&data.questionSequence!=0&&data.questionSequence!=null){
						var answerArray=data.answers.split(",");
						for(var i=0;i<answerArray.length;i++){
							if(answerArray[i]!='MISS'&&answerArray[i]!=""){
								complete++;
							}
						}
				    	percent=parseInt((complete/defaultTotal)*100);
				        var controlBar = $('#process'+levelNumber).NumberProgressBar({
				            duration: 5000,
				            percentage: percent
				          });   
					}
					}
			    	});
					
				}
			}
		});
    }
</script>
</body>
</html>