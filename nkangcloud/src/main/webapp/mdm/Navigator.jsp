<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.OAuthUitl.SNSUserInfo,java.lang.*"%>
<%@ page import="java.util.*,org.json.JSONObject"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.nkang.kxmoment.util.*"%>
<%

String ticket=RestUtils.getTicket();

SNSUserInfo user = (SNSUserInfo)request.getAttribute("snsUserInfo"); 
String uid = request.getParameter("UID"); 
String originalUid = uid;
if(request.getParameter("UID")==null&&request.getParameter("UID")==""){
	originalUid=(String)request.getAttribute("state"); 
}
String name = "";
String headImgUrl ="";
String myuid="";
String openid="";
if(null != user) {
	openid=user.getOpenId();
	HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(user.getOpenId());
	if(res!=null){
		if(res.get("HeadUrl")!=null){
			myuid = user.getOpenId();
			headImgUrl=res.get("HeadUrl");
		}else{
			headImgUrl = user.getHeadImgUrl(); 
		}
		if(res.get("NickName")!=null){
			myuid = user.getOpenId();
			name=res.get("NickName");
		}else{
			name = user.getNickname();
			headImgUrl = user.getHeadImgUrl(); 
			myuid="oI3krwR_gGNsz38r1bdB1_SkcoNw";
		}
	}else{
		name = user.getNickname();
		headImgUrl = user.getHeadImgUrl(); 
		myuid="oI3krwR_gGNsz38r1bdB1_SkcoNw";
	}
	SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd"); 
	Date date=new Date();
	String currentDate = format.format(date);
	if(openid.equals(originalUid)){
		MongoDBBasic.updateVisited(user.getOpenId(),currentDate,"NavigatorForBasic",user.getHeadImgUrl(),name);
	}
	else
	{
		MongoDBBasic.updateVisited(user.getOpenId(),currentDate,"NavigatorForBasic",user.getHeadImgUrl(),name);
		HashMap<String, String> resOriginal=MongoDBBasic.getWeChatUserFromOpenID(originalUid);
		MongoDBBasic.updateShared(originalUid,currentDate,"NavigatorForBasic",user.getHeadImgUrl(),name,resOriginal.get("HeadUrl"),resOriginal.get("NickName"));
		}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-练习参数</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
	<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/jquery-ui-1.11.0.css">
<link rel="stylesheet" href="../Jsp/JS/speedTab/jquery-ui-slider-pips.min.css" />
<script src="../Jsp/JS/speedTab/jquery-plus-ui.min.js"></script> 
<script src="../Jsp/JS/speedTab/jquery-ui-slider-pips.js"></script> 
<script src="../Jsp/JS/speedTab/examples.js"></script>
<link rel="stylesheet" href="../Jsp/JS/speedTab/app.min.css" />
<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/custom.css" />
<script src="../Jsp/JS/leshu/custom.js"></script> 
	<script type="text/javascript" src="../Jsp/JS/jquery.sha1.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
var url = window.location.href;
if(url.indexOf('#')!=-1){
	url=url.substr(0,(url.indexOf('#')-1));
}
var string1='jsapi_ticket=<%=ticket%>'
	+'&noncestr=Wm3WZYTPz0wzccnW&timestamp=1414587457&url='+url;
var signature=$.sha1(string1);
wx.config({
        debug: false,
        appId: '<%=Constants.APP_ID%>'+'',
        timestamp: 1414587457,
        nonceStr: 'Wm3WZYTPz0wzccnW'+'',
        signature: signature+'',
        jsApiList: [
            // 所有要调用的 API 都要加到这个列表中
            'checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo'
          ]
    });
 wx.ready(function () {
	  wx.checkJsApi({
            jsApiList: [
                'getLocation',
                'onMenuShareTimeline',
                'onMenuShareAppMessage'
            ],
            success: function (res) {
               // alert(JSON.stringify(res));
            }
     }); 
	  var date = new Date();
	    var seperator1 = "-";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	            
   //  var shareTitle="乐数在线测试("+currentdate+")";
    var shareTitle="乐数看听闪算擂台开擂了";
     var shareDesc="乐数小擂台欢迎来挑战！看算闪算听算随时恭候";
     var shareImgUrl="http://leshucq.bj.bcebos.com/standard/leshuLogo.png";
	//----------“分享给朋友”
     wx.onMenuShareAppMessage({
         title: shareTitle, // 分享标题
         desc: shareDesc, // 分享描述
         link: url, // 分享链接
         imgUrl: shareImgUrl, // 分享图标
         type: '', // 分享类型,music、video或link，不填默认为link
         dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
         success: function () { 
             // 用户确认分享后执行的回调函数、
             //alert("用户成功分享了该网页");
         },
         cancel: function () { 
             // 用户取消分享后执行的回调函数
             //alert("用户取消了分享");
         },
         fail: function (res) {
             alert(JSON.stringify(res));
         }
     });
     //------------"分享到朋友圈"
     wx.onMenuShareTimeline({
         title: shareTitle, // 分享标题
         link:url, // 分享链接
         imgUrl: shareImgUrl, // 分享图标
         success: function () { 
             // 用户确认分享后执行的回调函数
             //alert("用户成功分享了该网页");
         },
         cancel: function () { 
             // 用户取消分享后执行的回调函数
             //alert("用户取消了分享");
         },
         fail: function (res) {
             alert(JSON.stringify(res));
         }
     });
     wx.error(function(res){
         // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
         alert("errorMSG:"+res);
     });
 });
</script>
<style type="text/css">
#show-bi-slider-result{
height:100px;}
#show-bi-slider{
margin-top:100px;}
.margin-left{
margin-left:100px;
}
.margin-right{
margin-right:10px;
}
#speedAjust,#menuPanel,#lengthCountPanel,#numCountPanel {
	display: none;
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
			<i id="slowspeed" class="fa fa-bicycle fa-2x" style="float:left;margin-top:-60px;margin-left:15px;"></i>
			<i id="fastspeed" class="fa fa-fighter-jet fa-2x" style="float:right;margin-top:-60px;margin-right:15px;"></i>
        </div>
		
		<i id="backLength" class="fa fa-arrow-circle-left fa-5x margin-right"></i>
		<i id="toMenu" class="fa fa-arrow-circle-right fa-5x  margin-left"></i>
		<p style="line-height: 40px;">选择速度</p>
      </section>
      	<section id="questionTypePanel">
		<div class="selectPanel">  
			<div id="tenQ" class="circle default">计题练习</div>
			<div id="tenM" class="circle">计时练习</div>
          </div>    
		</div>
		<i id="toNumCount" class="fa fa-arrow-circle-right fa-5x"></i>
		<p style="line-height: 40px;">选择修炼方式</p>
	</section>
	<section id="numCountPanel">
		<div class="selectPanel">  
          <div id="show-bi-slider-result">
            <div id="show-bi-slider"></div>
          </div>    
		</div>
		
		<i id="backQT" class="fa fa-arrow-circle-left fa-5x margin-right"></i>
		<i id="toLength" class="fa fa-arrow-circle-right fa-5x margin-left"></i>
		<p style="line-height: 40px;">选择笔数</p>
	</section>

	<section id="lengthCountPanel">
		<div class="selectPanel">    
		<div id="vertical-slider-result">
            <div id="vertical-slider"></div>
          </div>
          </div>
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
	var lengthMax=5;
	var lengthMin=2;
	var uid='<%=uid%>';
	var numCount=5;
	var qt='question';
	$("#tenM").on("click",function(){
	$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	$(this).siblings().css({"background-color":"white","color":"black"});
	qt='minute';
	});
	$("#tenQ").on("click",function(){
		$(this).css("background-color","#22B26F");
		$(this).css("color","white");
		$(this).siblings().css({"background-color":"white","color":"black"});
		qt='question';
		});
	$("#toNumCount").on("click",function(){
		$("#numCountPanel").show();
		$("#questionTypePanel").hide();
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
	
	$("#backQT").on("click",function(){
		$("#numCountPanel").hide();
		$("#questionTypePanel").show();
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
	window.location.href="FlashNumber.jsp?speed="+speed+"&numCount="+numCount+"&lengthMax="+lengthMax+"&lengthMin="+lengthMin+"&qt="+qt+"&UID="+uid;
	});
	$("#ks").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="ShowNumber.jsp?speed="+speed+"&numCount="+numCount+"&lengthMax="+lengthMax+"&lengthMin="+lengthMin+"&qt="+qt+"&UID="+uid;
	});
	$("#ts").on("click",function(){
		$(this).css("background-color","#22B26F");
	$(this).css("color","white");
	window.location.href="ListenNumber.jsp?speed="+speed+"&numCount="+numCount+"&lengthMax="+lengthMax+"&lengthMin="+lengthMin+"&qt="+qt+"&UID="+uid;
	});
</script>
</body>
</html>