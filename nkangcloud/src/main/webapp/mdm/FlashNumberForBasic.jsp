<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.*"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="java.util.*,org.json.JSONObject"%>
<%
	int speed = Integer.parseInt(request.getParameter("speed"));
String category = request.getParameter("category");
	String uid = request.getParameter("UID");
	String level="";
	if(uid!=null||uid!=""){
	HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(uid);
	level=res.get("level");}
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

	<section id="startPanel">
		<div class="selectPanel">
			<div class="circle start bigger">闪算开始</div>
		</div>
	</section>
	<section id="processPanel" style=" position: relative;">
	<div id="numberChar">
		<div id="ShowNumberPanel"
			style="position: absolute; width: 100%; top: 100px; height: 50px; line-height: 50px; font-size: 30px;color:red"></div>
		<div id="ShowCharPanel"
			style="position: absolute; width: 100%; top: 60px; height: 50px; line-height: 50px; font-size: 40px;color:red"></div>
			</div>
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

			<div class="circle end bigger">提交答案</div>
		</div>
	</section>
	<section id="answerPanel" class="white intro" style="display: none">
		<div class="selectPanel" style="margin-top: 0px;padding-top: 20px;">
			<div id="right">
				<i class="fa fa-smile-o fa-3x"></i> <span
					style="font-size: 18px; display: inline-block; height: 30px; position: relative; top: -5px; margin-left: 10px;">真棒</span>
			</div>
			<div id="wrong">
				<i class="fa fa-frown-o fa-3x" style="color: #F94082;"></i> <span
					style="font-size: 18px; display: inline-block; height: 30px; position: relative; top: -5px; margin-left: 10px;">加油</span>
			</div>
			<div id="answerInput" style="width: 40%; margin-left: 30%;"></div>
			<div style="border-top: 1px solid black;width: 60%;margin-left: 20%;">
			<input type="text" style="width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;" class="niput" value="" disabled=""/>
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
		var speedArray=new Array(0,10,9,8,7,6,5,4,3,2,1);
		var uid='<%=uid%>';
		var level='<%=level%>';
		var category='<%=category%>';
		var rightQ=0;
		var wrongQ=0;
		var questions=null;
		var questionNumber=0;
		var questionObj = null;
		var answers="";
		var tempSequence = 0;
		var view = null;
		var snto = null;
		var rightQ=0;
		var wrongQ=0;
		var totalQuestion=0;

		getQuestions();
		getHistoryQuestion();
		function getQuestions(){
			$.ajax({
				type : "GET",
				url : "../AbacusQuiz/getAbacusQuizPoolBycategory",
				data : {
					category : category
				},
				cache : false,
				success : function(data) {
					if(data){
						questions=data;
						totalQuestion=data.length;
					}
				}
			});
		}
		function getHistoryQuestion(){
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
						answers=data.answers;
						var b=parseInt(data.batchId);
						var s=parseInt(data.questionSequence);
						var ts=(b-1)*10+s;
						questionNumber=ts;
					}
				}
			});
		}

		var batchId=0;
		var sequence=0;
		var index=0;
		function start() {
			if(questionNumber!=0&&questionNumber%10==0){
				swal({  
			        title:"真棒，休息一下吧？",  
			        text:"<input type='hidden'>",
			        html:"true",
			        showConfirmButton:"true", 
					showCancelButton: true,   
					closeOnConfirm: false,  
			        confirmButtonText:"我要休息",  
			        cancelButtonText:"我要继续",
			        animation:"slide-from-top"  
			      }, 
					function(inputValue){
						if (inputValue === false){

							return false;
						}
						else{
							window.location.href = "NavigatorForBasic.jsp?UID=" + uid;
						}
			      });
			
			}
			questionNumber++;
			$("#answer").val("");

			$("#timestext").val(questionNumber+"/"+totalQuestion);
			view = $("#numberChar");
			$("#ShowNumberPanel").text("准备");
			view.fadeOut(1000);
			m=0;
			questionNumber=findNextQuestion(questionNumber);
			snto = setTimeout("ShowNumber()", 1000);
		}
		var m=0;
		function ShowNumber() {
			
			var question = questionObj.question;
			if (m >= question.length) {
				$("#ShowNumberPanel").text("请答题");
				$("#processPanel").hide();
				$("#endPanel").show();
				return;
			}
			view.fadeIn(speedArray[speed] * 150);

			var operator = questionObj.operator;
			var operatorArray = operator.split(",");

				$("#ShowNumberPanel").text(question[m]);
				if(operatorArray[m]=="+"){
					$("#ShowCharPanel").text("");
				}
				else{
				$("#ShowCharPanel").text(operatorArray[m]);
				
			}
				m++;
			view.fadeOut(speedArray[speed] * 150);
			snto = setTimeout("ShowNumber()", speedArray[speed] * 300);
		}
		function findNextQuestion(questionNumber){

			for (var q = 0; q < questions.length; q++) {
				batchId = parseInt(questions[q].batchId);
				sequence = parseInt(questions[q].questionSequence);
				tempSequence = (batchId - 1) * 10 + sequence;
				if (tempSequence == questionNumber) {
					questionObj = questions[q];
					index = q;
					break;
				}
			}
			if(questionObj==null){
				batchId=Math.floor(questionNumber/10)+1;
				sequence=questionNumber%10;
				answers=answers+"MISS,";
				$.ajax({
					type : "GET",
					url : "../AbacusQuiz/updateHistoryQuiz",
					data : {
						openID : uid,
						category : category,
						batchId : batchId,
						questionSequence : sequence,
						answers : answers
					},
					cache : false,
					success : function(data) {
						if (data) {
						}
					}
				});
				questionNumber++;
				findNextQuestion(questionNumber);
			}
			return questionNumber;
			
		}
		var total = 0;
		var currentAnswer;
		function showAnswer(questionNumber) {
			$("#answerInput").html("");
			var questionObj = questions[questionNumber];
			var question = questionObj.question;
			var operator = questionObj.operator;
			var operatorArray = operator.split(",");
			for (var i = 0; i < question.length; i++) {
				if (operatorArray[i] == "+") {

					$("#answerInput")
							.append(
									"<input type='text' style='width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;' class='niput' value='' disabled />"
											+ "<input type='text' style='width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%' class='niput' value="
											+ question[i] + " disabled />");
				} else {

					$("#answerInput")
							.append(
									"<input type='text' style='width:20%;margin:0;padding:0;height:40px;text-align:right;padding-right:10px;' class='niput' value="
											+ operatorArray[i]
											+ " disabled />"
											+ "<input type='text' style='width:70%;margin:0;padding:0;height:40px;text-align:right;padding-right:10%' class='niput' value="
											+ question[i] + " disabled />");
				}
			}
			currentAnswer = questionObj.answer;
			$("#total").val(currentAnswer);

		}
		$(".end").on("click", function() {

			var answer = $("#answer").val();
			if (answer == "") {
				swal("未答题", "请输入你的答案哦~！", "error");
				return;
			}

			showAnswer(index);
			if (answer == currentAnswer) {
				$("#right").show();
				$("#wrong").hide();
				answers += batchId + "/" + sequence + "/" + "1,";
				rightQ++;
			} else {
				$("#wrong").show();
				$("#right").hide();
				wrongQ++;
				answers += batchId + "/" + sequence + "/" + "0,";
			}
			$.ajax({
				type : "GET",
				url : "../AbacusQuiz/updateHistoryQuiz",
				data : {
					openID : uid,
					category : category,
					batchId : batchId,
					questionSequence : sequence,
					answers : answers
				},
				cache : false,
				success : function(data) {
					if (data) {
					}
				}
			});
			$("#endPanel").hide();
			$("#answerPanel").show();

		});
		$(".start").on("click", function() {

			$("#questionInput").html("");
			if(questionNumber>totalQuestion){	

				swal({  
		        title:"没有更多的题了，需要重置吗？",  
		        text:"<input type='hidden'>",
		        html:"true",
		        showConfirmButton:"true", 
				showCancelButton: true,   
				closeOnConfirm: false,  
		        confirmButtonText:"是",  
		        cancelButtonText:"否",
		        animation:"slide-from-top"  
		      }, 
				function(inputValue){
					if (inputValue === false){
					$("#processPanel").hide();
					 return false;}
					else{$.ajax({
						type : "GET",
						url : "../AbacusQuiz/updateHistoryQuiz",
						data : {
							openID:uid,
							category : category,
							batchId:1,
							questionSequence:0,
							answers:""
						},
						cache : false,
						success : function(data) {
							if(data){
								window.location.href="FlashNumberForBasic.jsp?category="+category+"&speed="+speed+"&UID="+uid;
							}
						}
					});
					}});

				return;
			}
			
			$("#answerPanel").hide();
			$("#startPanel").hide();
			$("#processPanel").show();
			start();
		});

		$(".exit").on("click", function() {
			if(level=='basic'){
				window.location.href = "NavigatorForBasic.jsp?UID=" + uid;}
			else{
				window.location.href = "Navigator.jsp?UID=" + uid;}
		});
	</script>
</body>
</html>