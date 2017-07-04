<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.OAuthUitl.SNSUserInfo,java.lang.*"%>
<%@ page import="com.nkang.kxmoment.baseobject.ArticleMessage"%>
<%@ page import="com.nkang.kxmoment.util.RestUtils"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*,org.json.JSONObject"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%	
//获取由OAuthServlet中传入的参数
SNSUserInfo user = (SNSUserInfo)request.getAttribute("snsUserInfo"); 
String originalUid=(String)request.getAttribute("state");
String name = "";
String headImgUrl ="";
if(null != user) {
	//String uid = request.getParameter("UID");
	String uid = user.getOpenId();
	name = user.getNickname();
	headImgUrl = user.getHeadImgUrl();
	SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd"); 
	Date date=new Date();
	String currentDate = format.format(date);
	if(uid.equals(originalUid)){
		MongoDBBasic.updateVisited(user.getOpenId(),currentDate,"NotificationCenter",user.getHeadImgUrl(),name);
	}
	else
	{
		MongoDBBasic.updateVisited(user.getOpenId(),currentDate,"NotificationCenter",user.getHeadImgUrl(),name);
		HashMap<String, String> resOriginal=MongoDBBasic.getWeChatUserFromOpenID(originalUid);
		MongoDBBasic.updateShared(originalUid,currentDate,"NotificationCenter",resOriginal.get("HeadUrl"),resOriginal.get("NickName"));
		}
}

String num = request.getParameter("num");
List<ArticleMessage> nList=MongoDBBasic.getArticleMessageByNum(num);   
ArticleMessage n=new ArticleMessage();
/* n.setContent("此部分功能正在开发中，请等待。。");
n.setTitle("Notification!");
n.setTime("2017/2/10 16:42"); */
   if(!nList.isEmpty()){
	n=nList.get(0); 
}
%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
  <meta charset="utf-8">
  <title>Notification - <%=n.getTitle() %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="../nkang/css_athena/style.css"/>
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>
<script	src="../MetroStyleFiles/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css"/>
</head>
<body style="margin:0;">
<div style="width:100%;text-align:right;right:0px;position: absolute;margin-top:-10px;"><b>
<ul class="nav pull-right top-menu" style="list-style: none;">
					<li class="dropdown"><a href="#" class="dropdown-toggle ui-link" data-toggle="dropdown" style="padding:5px;
    text-decoration: none;
    text-shadow: 0 1px 0 #fff;display: block;color:#777;font-weight:700;">
					欢迎您：<span class="username colorBlue" id="username" style="color:#2489ce;"><%=name %></span>
					</a> <span><a style="float: right;" class="ui-link"> <img id="userImage" src="<%=headImgUrl %>" alt="userImage" class="userImage" style="
    border-radius: 25px;
    height: 35px;
    width: 35px;">
						</a></span></li>
				</ul>
				</b></div>
				
				<%if(n.getTitle().indexOf("Inventory Closed")>0){%>
				<img id="signUp" style="width: 70px;cursor:pointer;position: fixed;bottom: 50px;right: 0px;z-index: 1002;" src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EUmgT&oid=00D90000000pkXM">
				<%} %>
				
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing:0;display:table;">
             <tbody>
              <tr>
               <td width="270" valign="top" style="width:202.5pt;padding:0in 7.5pt 0in 15.0pt;padding-left:0px;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing:0">
                 <tbody>
                  <tr>
                   <td valign="top" style="width:60%"><p class="MsoNormal" style="/* line-height:14.0pt */"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><b><img id="_x0000_i1025" src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&oid=00D90000000pkXM" style="
    width: 140%;
">
</b>
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
               <td width="270" valign="bottom" style="width:202.5pt;padding:0in 15.0pt 0in 7.5pt;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing:0;">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in"><h1 align="right" style="margin:0in;margin-bottom:.0001pt;text-align:right;margin-bottom:0!important;color:inherit;margin-bottom: 24px!important;word-wrap:normal;"><span style="font-size: 12px;font-family:&quot;Arial&quot;,sans-serif;color:black;">
                      <o:p></o:p></span></h1></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;/* border-collapse:collapse; *//* display:table; *//* border-spacing: 0; */">
             <tbody>
              <tr>
               <td width="588" valign="top" style="width:441.0pt;/* padding:0in 0in 0in 0in */">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;/* border-collapse:collapse; */padding-bottom:0!important;">
                 <tbody>
                  <tr>
                   <td valign="top"><p class="MsoNormal" style="margin-top:0px;"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><img id="_x0000_i1026" src="https://myrecognition.int.hpe.com/hpenterprise/images/designtheme/hp2/1/m2e-hero.jpg" style="
    width: 100%;
">
                      <o:p></o:p></span></p></td>
                   <td width="0" valign="top" style="width:.3pt;padding:0in 0in 0in 0in"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
    
            <p style="margin: 20px;line-height:14.0pt;"><strong><span style="font-size:12.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><%=n.getTitle() %></span></strong><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">
              <o:p></o:p></span></p>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;display:table;border-spacing: 0;">
             <tbody>
              <tr>
               <td width="588" valign="top" style="width: 100%;/* padding:0in 0in 15.0pt 0in; */-moz-hyphens: auto;/* border-collapse:collapse!important; *//* word-wrap: break-word; */">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;/* border-collapse:collapse; *//* border-spacing: 0; */">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in;width: 100%;">
                    <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                     <tbody>
                      <tr>
                       <td width="100%" valign="top" style="width:100.0%;border:none;border-top:solid #A6A6A6 1.0pt;padding:0in 0in 0in 0in"></td>
                      </tr>
                     </tbody>
                    </table></td>
                   <td width="0" style="width:10%;/* padding:0in 0in 0in 0in */"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
<p style="margin: 10px;margin-left:30px;line-height:14.0pt;"><span style="font-size: 14px;font-family:&quot;Arial&quot;,sans-serif;color:black;"><%=n.getContent().replaceAll("\n", "<br/>") %><o:p></o:p></span></p>
<img style="position:relative;top:20px;" src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9lok&oid=00D90000000pkXM" alt="" width="100%" /> 

	<div id="footer">
		<span class="clientCopyRight"><nobr></nobr></span>
	</div>
	<script>
	
	$(function(){
		$("#signUp").click(function(){
			var formText="<p style='width:30%;float:left;height:40px;line-height:40px;'>姓名：</p><input id='newItem' style='margin-top:0px;width:50%;height:35px;display:block;float:left;' type='text' value=''/>"
		    +"<p style='width:30%;float:left;height:40px;line-height:40px;'>电话：</p><input id='newPrice' style='margin-top:0px;width:50%;height:35px;display:block;float:left;' type='text' value='' />"
		    +"<p style='width:30%;float:left;height:40px;line-height:40px;'></p><input id='newInventory' style='margin-top:0px;width:50%;height:35px;display:block;float:left;background-color:#8CD4F5;color:#fff;' type='button' value='获取验证码'/>"
		    +"<p style='width:30%;float:left;height:40px;line-height:40px;'>验证码：</p><input id='newSoldOutOfPay' style='margin-top:0px;width:50%;height:35px;display:block;float:left;' type='text'/>";
			swal({  
		        title:"我要报名",  
		        text:formText,
		        html:"true",
		        showConfirmButton:"true", 
				showCancelButton: true,   
				closeOnConfirm: false,  
		        confirmButtonText:"提交",  
		        cancelButtonText:"取消",
		        animation:"slide-from-top"  
		      }, 
				function(inputValue){
		    	  if (inputValue === false){ return false; }
		    	  swal("恭喜!", "报名成功！", "success");
		    	
		      }
		     );
		});
	});
	
	
          jQuery.ajax({
     		type : "GET",
     		url : "../QueryClientMeta",
     		data : {},
     		cache : false,
     		success : function(data) {
     			var jsons = eval(data);
     			$(document).attr("title",jsons.clientStockCode+" - "+$(document).attr("title"));//修改title值  
     			$('span.clientCopyRight').text('©'+jsons.clientCopyRight);
     		}
     	}); 
         </script>
</body>


</html>
