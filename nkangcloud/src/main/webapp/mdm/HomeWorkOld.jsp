<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.*"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="java.util.*,org.json.JSONObject"%>
<%

	String teacherID = request.getParameter("UID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数启蒙-学生做题情况</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="stylesheet" type="text/css"
	href="../MetroStyleFiles/sweetalert.css" />
<script src="../MetroStyleFiles/sweetalert.min.js"></script>
<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<script src="../Jsp/JS/leshu/custom.js"></script>
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>
<style type="text/css">
#studentPanel{
    width: 80%;
    margin-left: 10%;
    height: 1000px;
    margin-top: 30px;
}
.student{	
	width: 80px;
    height: 120px;
    float: left;
    margin-left: 10px;
}
.headImg {
    width: 100%;
    float: left;
    height: 80px;
    border-radius: 50%;
    overflow: hidden;
}
.headImg img{
height:100%;
width:100%;}
.name {
    text-align: center;
    font-size: 15px;
    width: 100%;
    height: 20px;
    float: left;
    margin: 0;
    margin-top: 5px;
}
i{
color:#20B672;
}
.gk{
width:40%;
float:left!important;
margin-left:5%!important;
height:40px;
background:#20B672;
border-radius:5px;
line-height:40px!important;
color:white!important;}
</style>
<script>
var teacherID='<%=teacherID%>';
$(function(){
	getStudentsFromTeacher();
});
function getHistoryAbacus(uid,category){    	var text="";
var total=0;
var text="";
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
			    	text="<p style='width:40%;float:left;height:40px;line-height:40px;'><i class='fa fa-smile-o fa-3x' style='position: relative;bottom: 5px;'></i></p><input style='margin-top:0px;width:50%;height:35px;display:block;float:left;color: black;' type='text' value='"+right+"题' disabled='true'/>"
			        	+"<p style='width:40%;float:left;height:40px;line-height:40px;'><i onclick='wrongClick()' class='fa fa-frown-o fa-3x' style='position: relative;color: #F94082;bottom: 5px;'></i></p><input id='wrongQT' style='margin-top:0px;width:50%;height:35px;display:block;float:left;color: black;' type='text' value='"+wrong+"题' disabled='true'/>"
			        +"<p style='width:40%;float:left;height:40px;line-height:40px;'>总共完成：</p><input style='margin-top:0px;width:50%;height:35px;display:block;float:left;color: black;' type='text' value='"+count+"题' disabled='true'/>";

				}
				else
				{
					text="<p style='text-align:center;width:100%'>他还没开始做题呢~！</p>"
				}
			    swal({  
		            title:category+"【"+total+"题】",  
		            text:text,
		            html:"true",
		            showConfirmButton:false, 
		    		showCancelButton: true,   
		    		closeOnConfirm: false,    
		            cancelButtonText:"我知道了",
		            animation:"slide-from-top"  
		          }, 
		    		function(inputValue){
		    			if (inputValue === false){
		    				return false;
		    			}
		    			else{

		    				$(".sweet-overlay").hide();
		    				$(".sweet-alert").hide();
		    			}});
			}
		});
		}
	}
});

}
function popSweetAlert(uid){
	var text="<div style='width:100%;height: 250px;overflow:scroll;'><div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第一关\")'>第一关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第二关\")'>第二关</p></div>"
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第三关\")'>第三关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第四关\")'>第四关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第五关\")'>第五关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第六关\")'>第六关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第七关\")'>第七关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第八关\")'>第八关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第九关\")'>第九关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十关\")'>第十关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十一关\")'>第十一关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十二关\")'>第十二关</p></div>"
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十三关\")'>第十三关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十四关\")'>第十四关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十五关\")'>第十五关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十六关\")'>第十六关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十七关\")'>第十七关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十八关\")'>第十八关</p></div>"	
	+"<div style='width:100%;height:40px;line-height:40px;margin-top:10px'><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第十九关\")'>第十九关</p><p class='gk' onclick='getHistoryAbacus(\""+uid+"\",\"第二十关\")'>第二十关</p></div></div>";	
	swal({  
        title:"请选择关卡",  
        text:text,
        html:"true",
        showConfirmButton:false, 
		showCancelButton: false,   
		closeOnConfirm: false,  
        confirmButtonText:"确定",  
        cancelButtonText:"取消",
        animation:"slide-from-top"  
      }, 
		function(inputValue){
			if (inputValue === false){
				return false;
			}});
}
function getStudentsFromTeacher(){
$.ajax({
	 url:'../userProfile/getUserByTeacherOpenid',
	 type:"POST",
	 data : {
		 teacherID : teacherID
	 },
	 success:function(result){
		 if(result){
			 var html="";
			 for(var i=0;i<result.length;i++){
				 html+="<div class='student' onclick='popSweetAlert(\""+result[i].openid+"\")'><div class='headImg'><img src='"+result[i].headimgurl+"' alt=''></div><p class='name'>"+result[i].nickname+"</p></div>";
			 }
			 $("#studentPanel").html(html);
		 }
	 }
});
}
	 </script>
</head>
<body style="margin:0;">
	<div id="data_model_div" style="height: 80px">
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
	<div id="studentPanel"></div>
</body>
</html>