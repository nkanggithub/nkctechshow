<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="hpe" />

<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/bootstrap/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/font-awesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="../nkang/css_athena/style.css" />
<link rel="stylesheet" type="text/css" href="../nkang/css_athena/profile.css" />
<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/icomoon/iconMoon.css" />
<link rel="stylesheet" type="text/css" href="../nkang/css_athena/style-responsive.css" />
<link rel="stylesheet" type="text/css" href="../nkang/css_athena/style-default.css" />
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css" />
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/sonhlab-base.css" />
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/openmes.css" />
<link rel="stylesheet" type="text/css" href="../nkang/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../nkang/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../nkang/demo.css">
<link rel="stylesheet" type="text/css" href="../nkang/animate.min.css">
<link rel="stylesheet" type="text/css" href="../nkang/admin/admin.css">
<link rel="stylesheet" type="text/css" href="../nkang/autocomplete/jquery-ui.css">

<script type="text/javascript" src="../nkang/easyui/jquery.min.js"></script>
<script type="text/javascript">
	var $113 = $;
</script>
<script type="text/javascript" src="../nkang/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles//CSS/animation-effects.css" />
<link rel="stylesheet" type="text/css" href="../Jsp/CSS/common.css">
<script src="../nkang/js_athena/jquery.circliful.min.js"></script>
<script src="../nkang/assets_athena/bootstrap/js/bootstrap.js"></script>
<script src="../MetroStyleFiles/sweetalert.min.js"></script>
<script type="text/javascript"
	src="../MetroStyleFiles//JS/openmes.min.js"></script>
<script src="../Jsp/JS/modernizr.js"></script>
<script src="../Jsp/JS/jSignature.min.noconflict.js"></script>
<script type="text/javascript" src="../nkang/autocomplete/jquery-ui.js"></script>
<script src="../Jsp/JS/fusioncharts.js" type="text/javascript"></script>
<link rel="stylesheet" href="../nkang/jquery.mobile.min.css" />
<script type="text/javascript" src="../nkang/jquery.mobile.min.js"></script>
<style>
 #return-top{position:fixed;bottom:40px;right:10px; text-align:center; display:none;z-index:998;} 
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
    background: #438CD0;
    border-bottom: 1px solid #ccc;
}
.edit.km{
	right: -120px;
    background: orange;
}
.edit img {
    width:25px;height:auto;position:absolute;top:25px;margin-left: 2px;
}
.edit.km p{
	line-height:35px;
	padding-top:20px;
}
.edit p
{
	width:50%;
	height:100%;
	line-height:145px;
	margin-right:auto;
	margin-left:auto;
}
.editBtn
{
	position: relative;
    left: -120px;
}
</style>
<script type="text/javascript">
$(function(){  
    $('#return-top').hide();  
    $(function(){  
        $(window).scroll(function(){  
            if($(window).scrollTop()>200){  
                $('#return-top').fadeIn(200);  
                }  
                else{$('#return-top').fadeOut(200);}  
              
            });  
            $('#return-top').click(function(){  
                $('body,html').animate({scrollTop:0},200);  
                	return false;  
                });
        });
    });
var clientThemeColor,HpLogoSrc,LogoData;
var RoleList,RoleObj=new Object();
$(window).load(function() {
	findRoleList();
	getLogoLists();
	$("li.Work_Mates_div_list_div2").live("swiperight",function(){
		$(this).css("overflow","hidden");
		$(this).removeClass("editBtn");
		$(this).remove(".edit");
	}); 
	$("li.Work_Mates_div_list_div2").live("swipeleft",function(){
		$(this).css("overflow","visible");
		$(this).addClass("editBtn");
		var openid=$(this).find("span.openid").text();
		var name=$(this).find("span.name").text();
		$(this).append("<div class='edit'><p onclick='showUpdateUserPanel(\""+openid+"\",\""+name+"\")'><img src='../mdm/images/edit.png' slt='' />编辑</p></div>");
		$(this).append("<div class='edit km'><p onclick='showKMPanel(\""+openid+"\",\""+name+"\")'>***<br/>管理</p></div>");
		$(this).siblings().removeClass("editBtn");
		$(this).siblings().remove(".edit");
	});
});

function findRoleList(){
	$.ajax({
		 url:'../roleOfAreaMap/findList',
		 type:"GET",
		 data : {
			 flag : 'Role'
		 },
		 success:function(resData){
			 RoleList=resData;
			 for(var i=0;i<RoleList.length;i++){
				 RoleObj[RoleList[i].id]=RoleList[i].name;
			 }
			 getMDLUserLists();
		}
	});
	
	FusionCharts.ready(function () {
	    var revenueChart = new FusionCharts({
	        type: 'doughnut2d',
	        renderAt: 'chart-container',
	        width: '350',
	        height: '300',
	        dataFormat: 'json',
	        dataSource: {
	            "chart": {
	                "caption": "",
	                "subCaption": "",
	                "numberSuffix": "人",
	                "paletteColors": "#8e0000,#8e7080,#0075c2,#1aaf5d,#f2c500,#f45b00",
	                "bgColor": "#ffffff",
	                "showBorder": "0",
	                "use3DLighting": "0",
	                "showShadow": "0",
	                "enableSmartLabels": "0",
	                "startingAngle": "310",
	                "showLabels": "0",
	                "showPercentValues": "1",
	                "showLegend": "1",
	                "legendShadow": "0",
	                "legendBorderAlpha": "0",
	                "defaultCenterLabel": "总人数: 44人",
	                "centerLabel": " $label",
	                "centerLabelBold": "1",
	                "showTooltip": "0",
	                "decimals": "0",
	                "captionFontSize": "14",
	                "subcaptionFontSize": "14",
	                "subcaptionFontBold": "0"
	            },
	            "data": [
	                {
	                    "label": "上游客户:4人",
	                    "value": 4
	                }, 
	                {
	                    "label": "下游工厂:5人",
	                    "value": 5
	                }, 
	                {
	                    "label": "贸易商:6人",
	                    "value": 6
	                }, 
	                {
	                    "label": "代理商:7人",
	                    "value": 7
	                }, 
	                {
	                    "label": "内部员工:8人",
	                    "value": 8
	                }, 
	                {
	                    "label": "未分类:9人",
	                    "value": 9
	                }
	            ],
	            "events": { 
	                "beforeLinkedItemOpen": function(eventObj, dataObj) { 
	                    console.log(eventObj);
	                    console.log(dataObj);
	                }
	            }
	        }
	    }).render();
}
function showUpdateUserPanel(openid,name){
	showCommonPanel();
	$(".Work_Mates_div_list_div2").removeClass("editBtn");
	$(".Work_Mates_div_list_div2").remove(".edit");
	$("body").append('<div id="UpdateUserPart" class="bouncePart" style="position:fixed;z-index:999;top:100px;width:80%;margin-left:10%;"><legend>编辑【'+name+'】的基本信息</legend><div id="UpdateUserPartDiv" style="margin-top:0px;margin-bottom: -20px;background-color:#fff;">'
			+'<center>正在加载中...</center>'		
	+'						</div>');
	$('#UpdateUserPart').addClass('form-horizontal bounceInDown animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass("bounceInDown animated");
	 });
	jQuery.ajax({
		type : "GET",
		url : "../CallGetWeChatUserFromMongoDB",
		data : {
			openid : openid
		},
		cache : false,
		success : function(data) {
			if (data.length > 0) {
				var IsRegistered=data[0].IsRegistered==null?'false':data[0].IsRegistered;
				var IsAuthenticated=data[0].IsAuthenticated==null?'false':data[0].IsAuthenticated;
				var IsActived=data[0].isActive==null?'false':data[0].isActive;
				var registerDate=data[0].registerDate==null?'':data[0].registerDate.replace(/\//g,"-");
				var realName=data[0].realName==null?'':data[0].realName;
				var phone=data[0].phone==null?'':data[0].phone;
				var email=data[0].email==null?'':data[0].email;
				var role=data[0].role==null?'':data[0].role;
				var selfIntro=data[0].selfIntro==null?'':data[0].selfIntro;
				var roleSelect='														<option value="">-请选择-</option>';
				for(var i=0;i<RoleList.length;i++){
					if(role==RoleList[i].id){
						roleSelect+='														<option selected="true" value="'+RoleList[i].id+'">'+RoleList[i].name+'</option>';
					}else{
						roleSelect+='														<option value="'+RoleList[i].id+'">'+RoleList[i].name+'</option>';
					}
				}
				$("#UpdateUserPartDiv").html('<form id="atest">'
			            +'												<input type="hidden" name="uid" id="atest_uid" value="'+openid+'"/>'
			            +'												<table id="tableForm" style="margin-top:-20px;">'
			            +'													<tr>'
			            +'														<td><nobr>真实姓名:</nobr></td>'
			            +'														<td><input type="text" name="realName" value="'+realName+'"/></td>'
			            +'													</tr>'
			            +'													<tr>'
			            +'														<td>手机号码:</td>'
			            +'														<td><input type="text" name="phone" value="'+phone+'"/></td>'
			            +'													</tr>'
			            +'													<tr>'
			            +'														<td>电子邮箱:</td>'
			            +'														<td><input type="text" name="email" value="'+email+'"/></td>'
			            +'													</tr>'
			            +'													<tr>'
			            +'														<td>用户职位:</td>'
			           /*  +'														<td><input type="text" name="role" value="'+role+'"/></td>' */
			            +'														<td><select  name="role">'
			            +roleSelect
			            +'													    </select></td>'
			            +'													</tr>'
			            +'												    <tr>'
			            +'													    <td>注册时间:</td>'
			            +'													    <td align="left" class="tdText" >'
			            +'													    	<input name="registerDate" type="date" id="registerDate" required style="text-align: -webkit-center; width: 130px;"  value="'+registerDate+'">'
			            +'													    </td>'
			            +'												    </tr>'
			            +'												    <tr>'
			            +'												        <td>确认注册:</td>'
			            +'												        <td  align="left" class="tdText">'
			            +'												        	<input type="radio" name="isRegistered" value="true"  '+(IsRegistered=="true"?'checked="checked"':'')+' />是&nbsp;&nbsp;&nbsp;<input type="radio" name="isRegistered" '+(IsRegistered!="true"?'checked="checked"':'')+' value="false"/>否'
			            +'												        </td>'
			            +'												    </tr> '
			            +'												    <tr>'
			            +'												        <td>聊天组:</td>'
			            +'												        <td  align="left" class="tdText">'
			            +'												        	<input type="radio" name="isActived" value="true"  '+(IsActived=="true"?'checked="checked"':'')+' />是&nbsp;&nbsp;&nbsp;<input type="radio" name="isActived" '+(IsActived!="true"?'checked="checked"':'')+' value="false"/>否'
			            +'												        </td>'
			            +'												    </tr> '
			            +'												    <tr>'
			            +'												        <td>isAuthenticated:</td>'
			            +'												        <td  align="left" class="tdText">'
			            +'												        	<input type="radio" name="isAuthenticated" value="true"  '+(IsAuthenticated=="true"?'checked="checked"':'')+' />是&nbsp;&nbsp;&nbsp;<input type="radio" name="isAuthenticated" '+(IsAuthenticated!="true"?'checked="checked"':'')+' value="false"/>否'
			            +'												        </td>'
			            +'												    </tr> '
			            +'												    <tr>'
			            +'												 </table>'
			            +'												 </form>'
			            +'												 <button class="btnAthena EbtnLess" style="background-color:#005CA1;margin-left: 90px;margin-top:15px;" id="updateUserInfoBtn">确定</button>');
				$("#updateUserInfoBtn").click(function(){
					var isRegistered = $("input[name='isRegistered']:checked").val();
					var registerDate = $("#registerDate").val();
					if(isRegistered==null || registerDate==null){
						swal("修改信息失败", "请输入正确的信息", "error");
					}
					$.ajax({
						url:"../updateUserInfo",
						data:$("#atest").serialize(),
						type:"POST",
						dataType:"json",
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						cache:false,
						async:false,
						success:function(result) {
							if(result){
								swal("更改成功!", "恭喜!", "success"); 
								hideBouncePanel();
								getMDLUserLists();
							} else {
								swal("更改失败!", "请填写正确的信息.", "error");
							}
						}
					});
				});
			}
		}
	});
}
function showLogoPanel(index){
	showCommonPanel();
	var thisLogo=LogoData[index];
	var Slide1="",Slide2="",Slide3="";
	if(thisLogo.slide!=null){
		Slide1=thisLogo.slide[0];
		Slide2=thisLogo.slide[1];
		Slide3=thisLogo.slide[2];
	}
	$("body").append('<div id="LogoEditPart" class="bouncePart" style="position:fixed;z-index:999;top:100px;width:80%;margin-left:10%;"><legend>LOGO编辑</legend><div style="margin-top:0px;margin-bottom: -20px;background-color:#fff;">'
			+'<form id="callUpdateClientMeta" >'
			+'<table style="margin-left:auto;margin-right:auto; id="logoEdit">'
			+'	<tr>'
			+'		<td>Logo的url：<input name="ClientCode" type="hidden" value="'+thisLogo.clientStockCode+'"/></td>'
			+'		<td><input name="ClientLogo" type="text" style="width:150px;"  value="'+thisLogo.clientLogo+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>公司名称：</td>'
			+'		<td><input name="ClientName" type="text" style="width:150px;"  value="'+thisLogo.clientName+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>部门名称：</td>'
			+'		<td><input name="ClientSubName" type="text" style="width:150px;" value="'+thisLogo.clientSubName+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>版权归属：</td>'
			+'		<td><input name="ClientCopyRight" type="text" style="width:150px;" value="'+thisLogo.clientCopyRight+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>主题颜色：</td>'
			+'		<td><input name="ClientThemeColor" type="text" style="width:150px;" value="'+thisLogo.clientThemeColor+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>幻灯片url1：</td>'
			+'		<td><input name="Slide1" type="text" style="width:150px;" value="'+Slide1+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>幻灯片url2：</td>'
			+'		<td><input name="Slide2" type="text" style="width:150px;" value="'+Slide2+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>幻灯片url3：</td>'
			+'		<td><input name="Slide3" type="text" style="width:150px;" value="'+Slide3+'"/></td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td colspan="2" style="text-align: center; padding: 0px;">	'
			+'			<button class="btnAthena EbtnLess" style="padding: 0px;background-color:'+clientThemeColor+';" id="submit_button" onclick="">保存</button>												'
			+'		</td>'
			+'	</tr>'
			+'</table>'
			+'</form>'
			+'							</div>');
	$('#submit_button').click(function(){
		jQuery.ajax({
			type : "GET",
			url : "../callUpdateClientMeta",
			data : $('#callUpdateClientMeta').serialize(),
			cache : false,
			success : function(data) {
				if(data=="true"){
					swal("Congratulations！", "LOGO信息修改成功!", "success"); 
					window.location.reload();
				}
				else{
					swal("LOGO信息修改失败!", "服务器出异常了", "error"); 	
				}
			}
		});
	});
	$('#LogoEditPart').addClass('form-horizontal bounceInDown animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass("bounceInDown animated");
	    });
}
function showCommonPanel()
{
	$("body").append("<div  id='data_model_div' style='z-index:999;position:fixed;'  class='dataModelPanel'><img onclick='hideBouncePanel()' src='../MetroStyleFiles/EXIT1.png' style='width: 30px; height: 30px;position:absolute;top:20px;left:20px;' />	<img style='position:absolute;top:8px;right:20px;' class='HpLogo' src='"+HpLogoSrc+"' alt='Logo' class='HpLogo'><div style='width:100%;height:4px;background:"+clientThemeColor+";position:absolute;top:70px;'></div></div>");
	$('#data_model_div').removeClass().addClass('panelShowAnmitation').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass();
	    }); }
function hideBouncePanel()
{
	$("body").find(".bouncePart").remove();
	$("body").find("#data_model_div").remove();
	}
function getLogoLists() {
	jQuery.ajax({
				type : "GET",
				url : "../QueryClientMetaList",
				data : {},
				cache : false,
				success : function(data) {
					var jsons = data;
					var ul = "",regNumber=0;
					ul='<div class="Work_Mates_div_list_div2">'
						+'							<span class="total_num">总数：'+jsons.length+'</span>'
						+'							<div class="clear"></div>'
						+'						</div>';
					LogoData=jsons;
					for (var i = 0; i < jsons.length; i++) {
					var temp=jsons[i];
					var buttonText;
					if(temp.clientActive=='Y'){
						buttonText='							<div style="float: right; margin-top: -80px; background-color: #777; color: #fff; font-weight:bold; font-size: 13px; padding: 3px;width:50px;text-align:center;border-radius:6px;">'
							+'								应用中'
							+'							</div>';
						clientThemeColor=temp.clientThemeColor;
						HpLogoSrc=temp.clientLogo;
					/* 	$('#logo_now').html('<img'
								+'				src="'+temp.clientLogo+'"'
								+'				alt="Logo" class="HpLogo"'
								+'				style="display: inline !important; height: 30px; float: none; padding: 0px; vertical-align: bottom;"><span'
								+'				class="clientSubName"'
								+'				style="font-size: 12px; padding-left: 7px; color: #333;">'+temp.clientSubName+'</span>'
								+'				<h1 style="color: #333; font-size: 18px;" class="clientName">'+temp.clientName+'</h1>');
						$('#logo_now_color').css('border-color',temp.clientThemeColor); */
					}else{
						buttonText='<div style="float: right; margin-top: -80px; background-color: #0197D6; color: #fff; font-weight:bold; font-size: 13px; padding: 3px;width:50px;text-align:center;border-radius:6px;" onclick="updateLogo(\''+temp.clientStockCode+'\')">'
							+'								应用'
							+'							</div>';
					}
						var li='<div class="Work_Mates_div_list_div2" style="padding-bottom:0px !important;">'
		+'							<img'
		+'								src="'+temp.clientLogo+'"'
		+'								alt="Logo" class="HpLogo"'
		+'								style="display: inline !important; height: 30px;padding-left:0px !important;margin-left:0px !important;vertical-align: bottom;"><span'
		+'								class="clientSubName"'
		+'								style="font-size: 12px; padding-left: 7px; color: #333;">'+temp.clientSubName+'</span>'
		+'							<h1 style="color: #333; font-size: 18px;padding-left:0px;" class="clientName">'+temp.clientName+'</h1>'
	//	+'<hr style="border:2px solid '+temp.clientThemeColor+';width:75%;padding:0px;margin-top:0px;">'
		+'							<p style="font-size:10px;margin-bottom:3px;margin-top:-3px;">©'+temp.clientCopyRight+'</p>'
		+buttonText
		+'							<div style="float: right; margin-top: -50px; background-color: #0197D6; color: #fff; font-weight:bold; font-size: 13px; padding: 3px;width:50px;text-align:center;border-radius:6px;" onclick="showLogoPanel('+i+')">'
		+'								编辑'
		+'							</div>'
		+'							<div class="clear"></div>'
		+'						</div>';
		ul+=li;
					}
					$("#Logo_div").html(ul);
				}
			});
}
function updateLogo(id){
	jQuery.ajax({
		type : "GET",
		url : "../ActivaeClientMeta",
		data : {clientCode:id},
		cache : false,
		success : function(data) {
			if(data=="true"){
				swal("Congratulations！", "网站LOGO替换成功!", "success"); 
				window.location.reload();
			}
			else{
				swal("网站LOGO替换失败!", "服务器出异常了", "error"); 	
			}
		}
	});
}
function getMDLUserLists() {
jQuery
	.ajax({
		type : "GET",
		url : "../userProfile/getMDLUserLists",
		data : {},
		cache : false,
		success : function(data) {
			data = '{"results":' + data + '}';
			var jsons = eval('(' + data + ')');
			var ul = "",regNumber=0;
			for (var i = 0; i < jsons.results.length; i++) {
				var temp = jsons.results[i];
				var selfIntro=temp.selfIntro;
				var role;
				try{
				 	role=RoleObj[temp.role];
				}catch(e){
					
				}
				var workDay=temp.workDay;
				var tag=temp.tag;
				var tagHtml="";
				var congratulate="";
				
				if(temp.openid==$('#uid').val()){
					LastToLikeDate=temp.like.lastLikeDate;
					lastLikeTo=temp.like.lastLikeTo;
				}

				
				
				if(selfIntro==null||selfIntro=='null'){
					selfIntro="nothing";
				}else{
					if(selfIntro.length>10){
						selfIntro=(selfIntro.substr(0,12)+'...');
					}
				}
				if(role==null||role=='null'){
					role="";
				}
				if(tag!=null&&tag!='null'){
					for(var j=0;j<tag.length&&j<4;j++){
						for (var key in tag[j]) { 
							tagHtml+='													<div class="tag">'
							+key
							+'													</div>';
						}
					}
				}
				if(workDay==null||workDay=='null'||workDay==0){
					workDay="";
				}else{
					regNumber++;
					workDay='<div style="float:right;margin-top:-45px;background-color:#eee;color:#333;font-size:13px;padding:3px;">'+workDay+' Days</div>';
				}
				if(temp.congratulateNum==null||temp.congratulateNum=='null'||temp.congratulateNum==undefined||temp.congratulateNum==0){
					
				}else{
					congratulate='<div style="float:right;"><img src="../MetroStyleFiles/reward.png" style="height:25px;"/>'
						+ '<span style="font-size:12px;color:#07090B;font-weight:normal;">'+temp.congratulateNum+'</span><div>';
				}
				var li='	<li class="Work_Mates_div_list_div2">'
					+'                                           	 	<div class="Work_Mates_img_div2">'
					+'                                        			 <img src="'
					+ temp.headimgurl
					+ '" alt="userImage" class="matesUserImage" alt="no_username"/> '
					+'                                         		</div>'
					+'                                         		<div class="Work_Mates_text_div">'
					+'                                        			 <h2><span class="name">'
					+ temp.nickname
					+ '</span><span class="role">'
					+role+'</span><span style="display:none;" class="openid">'
					+temp.openid+'</span>'
					+congratulate
					+'</h2>'
					+ '<div>'
					+tagHtml
					+'<br/>'
					+'													<span class="selfIntro">'+selfIntro+'</span>'
					+'												</div>'
					+'                                        		</div>'
					+workDay
					+'                                                <div class="clear"></div>'
					+'                                          </li>';
				ul += li;
			}
			$("#Work_Mates_div_list_div2").html('<span class="total_num"><img src="../MetroStyleFiles/role.png" style="height:20px;"/>总人数：'+ jsons.results.length
					+'&nbsp;&nbsp;&nbsp;已注册人数：'+regNumber
					+'</span><div class="clear"></div>');
			$("#Work_Mates_div").html(ul);
		}
	});
}

</script>
<title>admin</title>
</head>
<body style="padding: 0px !important; margin: 0px;">
	<div class="navbar-inner" style="background-color: #fff !important;">
		<div class="container-fluid">
			<!-- <a style="float: left; padding-top: 10px;" id="logo_now"><img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="Logo" class="HpLogo" style="display: inline !important; height: 30px; float: none; padding: 0px; vertical-align: bottom;"><span class="clientSubName" style="font-size: 12px; padding-left: 7px; color: #333;">MDM China</span>				<h1 style="color: #333; font-size: 18px;" class="clientName">DXC Technology Coperation</h1></a>
			 -->
			 <a style="float: left; padding-top: 10px;" id="logo_now"><img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="Logo" class="HpLogo" style="display: inline !important; height:50px; float: none; padding: 0px; vertical-align: bottom;">				</a>
			 <div class="clear"></div>
			<ul class="nav pull-right top-menu" style="margin-top: -70px;display:none;">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"
					style="font-size: 15px; margin: 0px; padding: 5px 0px;">
						Welcome <span class="username colorBlue" id="username">
							青青～笑 </span>
				</a> <span><a style="float: right;"> <img id="userImage"
							src="http://wx.qlogo.cn/mmopen/3ial0wgAS7u1sBkjFnq8CKfTlENtrYZvREwEhPMmu5FvHbDrYITooGLlmXszwNTVppJTc1ZCeyibZAqpviasUOmYqg4cfLr7lX8/0"
							alt="userImage" class="userImage" onclick="register()">
					</a></span></li>
			</ul>
		</div>
	</div>
	<div class="TABclass">
		<div id="logo_now_color" style="border-top: 4px solid #000; padding: 5px;">
			<ul class="nav nav-tabs" id="myTabs"
				style="border-color: #000;">
				<li  class="active"><a href="#WorkMates" data-toggle="tab"
					style="border-right-color: #000; border-top-color: #000; border-left-color: #000;">人员管理</a></li>
				<li><a href="#logoElements" data-toggle="tab"
					style="border-right-color: #000; border-top-color: #000; border-left-color: #000;">LOGO管理</a></li>
			</ul>
			<div class="tab-content" id="dvTabContent"
				style="border: 0px; padding-top: 0px;margin-top:0px;">
				<div class="tab-pane" id="logoElements">
					<!-- start logoElements-->
					<div class="Work_Mates_div2" id="Logo_div">
					</div>
					<!-- end logoElements-->
				</div>
				<div class="tab-pane  active" id="WorkMates">
				<img id="refreshUser"  src="../MetroStyleFiles/refresh2.png" style="height:25px;float:right;margin-top:8px;margin-left:15px;"/>
					<img id="syncUser"  src="../MetroStyleFiles/sync.png" style="height:30px;float:right;margin-top:7px;"/>
					<div id="chart-container" style="margin-left:auto;margin-right:auto;text-align:center;"></div>
					
					
				<div id="Work_Mates_div_list_div2" class="Work_Mates_div_list_div2"></div>
					<div  style="position: absolute; top: 160px;overflow:hidden" data-role="page" style="padding-top:45px" data-theme="c">
						<ul id="Work_Mates_div" class="Work_Mates_div2"  data-role="listview" data-autodividers="false" data-filter="true" data-filter-placeholder="输入关键字" data-inset="true" style="margin-top:15px">
						</ul>
					</div>
					<div id="return-top" style="display: block;"><img class="scroll-top"  src="../Jsp/PIC/upgrade.png"  alt="" width="50px"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>