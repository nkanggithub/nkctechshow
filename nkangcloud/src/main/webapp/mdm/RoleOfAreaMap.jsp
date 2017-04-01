<%@ page language="java" pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,org.json.JSONObject"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.nkang.kxmoment.util.RestUtils"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="com.nkang.kxmoment.baseobject.WeChatUser"%>
<%@ page import="com.nkang.kxmoment.baseobject.ClientMeta"%>
<%	
String AccessKey = RestUtils.callGetValidAccessKey();
String uid = request.getParameter("UID");
/* 
HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(uid);
*/
WeChatUser wcu;
if (session.getAttribute("location") == null) {
	wcu = RestUtils.getWeChatUserInfo(AccessKey, uid);
	session.setAttribute("wcu", wcu);
} else {
	wcu = (WeChatUser) session.getAttribute("wcu");
}
%>
<!Doctype html>
<html>
<head>
<title>我的订阅</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="stylesheet" href="../nkang/jquery.mobile.min.css" />
<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/bootstrap/css/bootstrap-responsive.min.css" />
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>
<script src="../nkang/assets_athena/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="../nkang/jquery.mobile.min.js"></script>
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css"/>
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles//CSS/animation-effects.css"/>
<script type="text/javascript" src="../MetroStyleFiles/sweetalert.min.js"></script>

<script type="text/javascript" src="../Jsp/JS/fusioncharts.js"></script>
<script type="text/javascript" src="../Jsp/JS/fusioncharts.powercharts.js"></script>
<script type="text/javascript" src="../Jsp/JS/fusioncharts.theme.fint.js"></script>
<style>
body{
	padding:0px;
	width:100%;
	overflow:hidden;
}
#echarts{height: 350px;width:750px;}
span.chartButton.now {
    background-color: #005CA1;
}
span.chartButton {
    cursor: pointer;
    padding: 8px 20px;
    background-color: #ccc;
    font-weight: bold;
    color: #fff;
}
#data_model_div
{
    position: fixed;
    top: 0;
    height: 130%;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 90;
    background-color: white;
    transition: opacity .15s linear;
}
 #return-top{position:fixed;bottom:40px;right:10px; text-align:center; display:none;z-index:9999;} 
.HpLogo {
    position: relative;
    top: 8px;
    left: 1%;
    width: 150px;
    height: 58px;
}
ul li.singleQuote{
	font-size:18px;
	border-bottom:1px solid #ccc;
	padding:20px;
	color:#333;
}
ul li.singleQuote .firstLayer.attention{
	color:#0761A5;
}
ul li.singleQuote .firstLayer .quoteTitle{
	float:left;
	cursor:pointer;
}
ul li.singleQuote .firstLayer .quoteTitle .tag{
	font-size:11px;
	background-color:orange;
	color:#fff;
	padding:1px 5px;
	font-weight:normol;
	font-family:微软雅黑;
	margin-left:8px;
}
ul li.singleQuote .firstLayer .quotePrice{
	float:right;
	color:#333;
}
ul li.singleQuote .firstLayer .quotePrice.high,ul li.singleQuote .firstLayer  .change.high{
	color:red;
}
ul li.singleQuote .firstLayer .quotePrice.normal,ul li.singleQuote .firstLayer  .change.normal{
	color:#333;
}
ul li.singleQuote .firstLayer.attention .quotePrice.high,ul li.singleQuote .firstLayer.attention  .change.high{
	color:red;
}
ul li.singleQuote .firstLayer .quotePrice.low,ul li.singleQuote .firstLayer  .change.low{
	color:green;
}
ul li.singleQuote .firstLayer .quotePrice.lose,ul li.singleQuote .firstLayer  .change.lose{
	color:#bbb;
}
ul li.singleQuote .firstLayer  .change{
	font-size:10px;
	float:right;
	margin-top:-35px;
	position:relative;
	clear:both;
}
.clear{
	clear:both;
}
.edit
{
	width: 60px;
    height: 100%;
    color: #fff;
    font-family:微软雅黑;
    text-align: center;
    position: absolute;
    top: 0px;
    right: -60px;
	font-size:14px;
    background: orange;
    border-bottom: 1px solid #ccc;
}
.edit img {
    width:25px;height:auto;position:absolute;top:8px;margin-left: 2px;
}
.edit p
{
	width:50%;
	height:100%;
	line-height:90px;
	margin-right:auto;
	margin-left:auto;
	font-weight:bold;
}
.edit.no{
background: #999;
}
.picClose
{
cursor:pointer;
}
.edit.no p
{
	line-height:25px;
	padding-top:5px;
}
.editBtn
{
	position: relative;
    left: -60px;
}
</style>

<script>
var likeRoleNum=0;
$(function(){
	   $(function(){  
	      	 $(window).scroll(function(){  
	           	  if($(window).scrollTop()>200){  
	                 $('#return-top').fadeIn(200);  
	               }  
	               else{
	            	 //  $('#return-top').fadeOut(200);
	            	 }  
	           });  
	           $('#return-top').click(function(){  
	               $('body,html').animate({scrollTop:0},200);  
	               return false;  
	            });  
	   });
	    /**
	   $(".quoteTitle").live("click",function(){
			$("#pic").css("display","block");
		});
		$(".picClose").live("click",function(){
			$("#pic").css("display","none");
		});
	  */ 
	   
	getAllDatas();
	$(".singleQuote").live("swiperight",function(){
		$(this).css("overflow","hidden");
		$(this).removeClass("editBtn");
		$(this).find(".edit").remove();
	}); 
	$(".singleQuote").live("swipeleft",function(){
		$(this).siblings().removeClass("editBtn");
		$(this).siblings().find(".edit").remove();
		
		$(this).css("overflow","visible");
		$(this).addClass("editBtn");
		var tagNum=$(this).find('span.tag').length;
		var item=$(this).find('span.id').text();
		if(tagNum==0){
			$(this).append('<div class="edit"><p onclick="UpdateTag(\''+item+'\',\'add\',this)"><img src="../mdm/images/focus.png" />关注</p></div>');
		}else{
			$(this).append('<div class="edit no"><p onclick="UpdateTag(\''+item+'\',\'del\',this)">取消<br/>关注</p></div>');
		}
	});
});
function ToCharPage(item){
	//location.href="priceCharts.jsp?itemNo="+item;
	showKMPanel(item);
}
function showKMPanel(item){
	showCommonPanel();
	$("body").append('<div id="UpdateUserKmPart" class="bouncePart" style="position:fixed;z-index:9999;top:100px;width:100%">'
	//+'<legend>编辑关注的牌号</legend><div id="UpdateUserPartDiv" style="margin-top:0px;margin-bottom: -20px;background-color:#fff;">'
			/* +'<div class="title">'+item+'的价格趋势分析</div>'
			+'	<div class="subtext">2016-12-30 - 2017-02-23</div>'
			+'	<div class="chart-box">'
			+'		<div id="echarts" _echarts_instance_="ec_1487834284265" style="width: 371px; -webkit-tap-highlight-color: transparent; -webkit-user-select: none; position: relative; background: transparent;"><div style="position: relative; overflow: hidden; width: 371px; height: 350px; cursor: default;"><canvas width="371" height="350" data-zr-dom-id="zr_0" style="position: absolute; left: 0px; top: 0px; width: 371px; height: 350px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas></div><div style="position: absolute; display: none; border: 0px solid rgb(51, 51, 51); white-space: nowrap; z-index: 9999999; transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1), top 0.4s cubic-bezier(0.23, 1, 0.32, 1); border-radius: 4px; color: rgb(255, 255, 255); font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 14px; font-family: &#39;Microsoft YaHei&#39;; line-height: 21px; padding: 5px; left: 211.95px; top: 122px; background-color: rgba(50, 50, 50, 0.701961);">02-13<br><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#7DB5E8"></span>价格 : 9,840</div></div>'
			+'	</div>'
			+'				</div>'); */
			+'<div class="title"><center>'+item+'的价格趋势分析</center></div>'
			+'	<div class="chart-box">'
			+'		<div id="chart-container" style="text-align: center;overflow-x: auto;"></div>'
			+'	</div>'
			+'<div style="text-align:center;margin-top:20px;"><span class="chartButton now">周</span><span class="chartButton">月</span></div>');
	$('#UpdateUserKmPart').addClass('form-horizontal bounceInDown animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass("bounceInDown animated");
	 });
	 FusionCharts.ready(function () { 
	        var testProcChart = new FusionCharts({
	            type: 'errorline',
	            renderAt: 'chart-container',
	            width: '380',
	            height: '350',
	            dataFormat: 'jsonurl',
	            dataSource: '../PlasticItem/priceList?page=1&type=W&count=999&itemNo='+item
	        }).render();
	    });
	$('span.chartButton').click(function(){
		var text=$(this).text();
		$(this).addClass("now");
		$(this).siblings().removeClass("now");
		var type="W";
		if(text=="月"){
			type="M";
		}
	    FusionCharts.ready(function () { 
	        var testProcChart = new FusionCharts({
	            type: 'errorline',
	            renderAt: 'chart-container',
	            width: '380',
	            height: '350',
	            dataFormat: 'jsonurl',
	            dataSource: '../PlasticItem/priceList?page=1&type='+type+'&count=999&itemNo='+item
	        }).render();
	    });
	});
}
function showCommonPanel()
{
	$("body").append("<div  id='data_model_div' style='z-index:9999;'  class='dataModelPanel'><img onclick='hideBouncePanel()' src='../MetroStyleFiles/EXIT1.png' style='width: 30px; height: 30px;position:absolute;top:20px;left:20px;' />	<img style='position:relative;height: 50px;float: right;top:8px;margin-right:20px;width:auto;' class='HpLogo' src='https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DkptH&amp;oid=00D90000000pkXM' alt='Logo' class='HpLogo'><div style='width:100%;height:4px;background:#005CA1;position:absolute;top:70px;'></div></div>");
	$('#data_model_div').removeClass().addClass('panelShowAnmitation').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass();
	    }); }
function hideBouncePanel()
{
	$("body").find(".bouncePart").remove();
	$("body").find("#data_model_div").remove();
}
function UpdateTag(item,flag,obj){
	var tempObj=$(obj).parent().parent(".singleQuote");
	$(".singleQuote").removeClass("editBtn");
	$(".singleQuote").find(".edit").remove();
	if(likeRoleNum>=2&&item.indexOf("Role")==0&&flag=='add'){
		 swal("操作失败", "最多只能关注两个职位", "error");
	}else{
		$.ajax({
			 url:'../roleOfAreaMap/saveUserKM',
			 type:"POST",
			 data : {
				 openid : $("#openid").val(),
				 kmItem : item,
				 flag : flag
			 },
			 success:function(result){
				 if(result==true){
					 if(flag=='add'){
						 swal("关注成功 ","恭喜你成功关注该项", "success");
						 tempObj.find(".firstLayer").addClass("attention");
						 tempObj.find(".firstLayer").find(".quoteTitle").append('<span class="tag">已关注</span>');
						 if(item.indexOf("Role")==0){
							 likeRoleNum++;
						 }
					 }else  if(flag=='del'){
						 swal("取消成功","你取消了对该项的关注", "success");
						 tempObj.find(".firstLayer").removeClass("attention");
						 tempObj.find(".firstLayer").find(".quoteTitle").find(".tag").remove();
						 if(item.indexOf("Role")==0){
							 likeRoleNum--;
						 }
					 }
				 }else{
					 swal("操作失败", "请刷新页面后重试", "error");
				 }
			 }
		});	
	}
}
function getAllDatas(){
	$.ajax({
		 url:'../roleOfAreaMap/queryUserKM',
		 type:"GET",
		 data : {
			 openid : $("#openid").val()
		 },
		 success:function(KMLikeArr){ 
		 	$.ajax({
			 url:'../roleOfAreaMap/findList',
			 type:"GET",
			 success:function(resData){
			 if(resData.length)
			{
			    var NoLikeArr=new Array();
				var LikeArr=new Array();
				likeRoleNum=0;
				if(KMLikeArr.length>0){
						 for(var i=0;i<resData.length;i++){
						 		var itemTemp=$.trim(resData[i].id);
						 		var index=$.inArray(itemTemp,KMLikeArr);
						 		if(index>-1){
						 			resData[i]["like"]=true;
						 			LikeArr.push(resData[i]);
						 			KMLikeArr.splice(index,1);
						 			if(resData[i].flag=='Role')
					 				{
					 					likeRoleNum++;
					 				}
						 		}else{
						 			NoLikeArr.push(resData[i]);
						 		}
						}
		 		}else{
		 			NoLikeArr=resData;
		 		}
				var data=$.merge(LikeArr, NoLikeArr); 
				 var roleHtml="";
				 var areaHtml="";
				 var totalNum=0;
				 for(var i=0;i<data.length;i++){
					 if(data[i].id!=""){
						 var priceColor="lose";
						 var tag='';
						 var attention='';
						 var priceStyle='';
						 var unit='<span class="unit"></span>';
						 if(data[i]["like"]==true){
							 tag='<span class="tag">已关注</span>';
							 attention='attention';
						 }
						 var tempHtml='<li class="singleQuote">'
							 +'	<div class="firstLayer '+attention+'">'
							 +'		<div class="quoteTitle"><span class="id" style="display:none;">'+data[i].id+'</span><span class="item">'+data[i].name+'</span>'+tag+'</div>'
							 +'		<div class="quotePrice '+priceColor+'" '+priceStyle+'><span class="price"></span>'+unit+'</div>'
							 /*  +'		<span class="change high">+10</span>' */
							 +'		<div class="clear"></div>'
							 +'	</div>'
							 +'</li>'; 
							 
						if(data[i].flag=='Role'){
							roleHtml+=tempHtml;
						}else{
							areaHtml+=tempHtml;
							totalNum++;
						}
					 }
				 }
				 $("#roleList").html(roleHtml);
				 $("#areaList").html(areaHtml);
				 
				 $("input.ui-input-text.ui-body-c").attr("placeholder","输入关键字【"+totalNum+"个供您查询】");
				 }
			 }
		 });
		 		
		}
	}); 
}
</script>
</head>
<body>
<div id="pic" style="width:90%;border-radius:10px;background:rgba(0,0,0,0.7);height:80%;position:fixed;left:5%;top:10%;display:none;z-index:9999" >
<img style="position:absolute;left:5%;top:5%;width:90%;height:90%;" src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DmjQs&oid=00D90000000pkXM" alt=""/>
 <img class="picClose" style="position:absolute;top:10px;right:10px;width:15px;height:auto;" src="../MetroStyleFiles/Close2.png" alt=""/> 

</div>
<div id="return-top" style="display: block;"><img class="scroll-top"  src="../Jsp/PIC/upgrade.png"  alt="" width="50px"></div>
<div style="padding:10px;padding-top:5px;border-bottom:2px solid #000;position:relative;padding-bottom:5px;margin-bottom:5px;"> 
					<img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&oid=00D90000000pkXM" alt="Logo" class="HpLogo" style="display:inline !important;height:35px !important;width:auto !important;float:none;padding:0px;vertical-align:bottom;padding-bottom:10px;">
					<span class="clientSubName" style="font-size:12px;padding-left:7px;color:#333;">MDM China</span>
					<h2 style="color:#333;font-size:18px;padding:0px;padding-left:5px;font-weight:bold;margin-top:5px;font-family:HP Simplified, Arial, Sans-Serif !important;" class="clientName">DXC Technology Coperation</h2>
					<p style="position: absolute;right: 10px;top: 0px;font-size: 15px;">欢迎您,<%=wcu.getNickname() %></p><img style="border-radius:25px;height:35px;width:35px;position:absolute;top:36px;right:10px;" src="<%=wcu.getHeadimgurl() %>" alt=""/>
				<input id="openid" type="hidden" value="<%=uid%>"/>
</div>		
	<div class="TABclass">
		<div id="logo_now_color" style="border-top: 4px solid #fff; padding-top: 5px;">
			<ul class="nav nav-tabs" id="myTabs"
				style="border-color: rgb(0, 179, 136);" style="padding-left: 5px;">
				<li  class="active"><a href="#roleElements" data-toggle="tab"
					style="border-right-color: rgb(0, 179, 136); border-top-color: rgb(0, 179, 136); border-left-color: rgb(0, 179, 136);">岗位职称</a></li>
				<li><a href="#areaElements" data-toggle="tab"
					style="border-right-color: rgb(0, 179, 136); border-top-color: rgb(0, 179, 136); border-left-color: rgb(0, 179, 136);">技术领域</a></li>
			</ul>
			<div class="tab-content" id="dvTabContent"
				style="border: 0px; padding-top: 0px;margin-top:0px;">
				<div class="tab-pane" id="areaElements">
				<!-- start logoElements-->
					<div  style="position: absolute; top: 125px;overflow:hidden" data-role="page" style="padding-top:15px" data-theme="c">
						<ul id="areaList" data-role="listview" data-autodividers="false" data-filter="true" data-filter-placeholder="输入关键字" data-inset="true" style="margin-top:15px">
						</ul>
					</div>
					<!-- end logoElements-->
				</div>
				<div class="tab-pane active" id="roleElements">
					<!-- start logoElements
					<div  style="position: absolute; top: 120px;overflow:hidden" data-role="page" style="padding-top:15px" data-theme="c">
						<ul id="roleList" data-role="listview" data-autodividers="false" data-filter="true" data-filter-placeholder="输入关键字" data-inset="true" style="margin-top:15px">
						</ul>
					</div>-->
					<div style="width:100%;overflow:hidden">
					<ul id="roleList"  style="margin: 0px;padding: 0px; margin-top: -20px;">
						</ul>
					<!-- end logoElements-->
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>