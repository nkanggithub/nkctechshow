<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.OAuthUitl.SNSUserInfo,java.lang.*"%>
<%@ page import="com.nkang.kxmoment.util.*"%>
<%@ page import="java.util.*,org.json.JSONObject"%>
<%@ page import="com.nkang.kxmoment.baseobject.ArticleMessage"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String ticket=RestUtils.getTicket();
//获取由OAuthServlet中传入的参数
SNSUserInfo user = (SNSUserInfo)request.getAttribute("snsUserInfo"); 
String originalUid=(String)request.getAttribute("state");
String name = "";
String phone = "";
String headImgUrl ="";
boolean isFollow=false;
String uid ="";
if(null != user) {
	//String uid = request.getParameter("UID");
	uid = user.getOpenId();
	name = user.getNickname();
	headImgUrl = user.getHeadImgUrl();
	HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(uid);
	if(res!=null){
		isFollow=true;
		if(res.get("HeadUrl")!=null){
			headImgUrl=res.get("HeadUrl");
		}
		if(res.get("NickName")!=null){
			name=res.get("NickName");
		}
		if(res.get("phone")!=null){
			phone=res.get("phone");
		}

		MongoDBBasic.updateUser(uid);
		
		SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date=new Date();
		String currentDate = format.format(date);
		if(uid.equals(originalUid)){
			MongoDBBasic.updateVisited(user.getOpenId(),currentDate,"MesPushHistory",user.getHeadImgUrl(),name);
		}
		else
		{
			MongoDBBasic.updateVisited(user.getOpenId(),currentDate,"MesPushHistory",user.getHeadImgUrl(),name);
			if(!"STATE".equals(originalUid)){
			HashMap<String, String> resOriginal=MongoDBBasic.getWeChatUserFromOpenID(originalUid);
			MongoDBBasic.updateShared(originalUid,currentDate,"MesPushHistory",resOriginal.get("HeadUrl"),resOriginal.get("NickName"));
			}
		}
		
	}
}
List<ArticleMessage> ams=MongoDBBasic.getArticleMessageByNum("");
String uid2=request.getParameter("UID");
int size=5;
int realSize=ams.size();
if(ams.size()<=5){size=ams.size();}
%>
<!DOCTYPE html>
<html lang="en" class="csstransforms csstransforms3d csstransitions">
<head>
<title>往期回顾</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
			 <script src="../mdm/uploadfile_js/jquery-1.11.2.min.js"></script>
			 <script src="../Jsp/JS/iscroll.js"></script>
			 <link rel="stylesheet" href="../Jsp/CSS/about.css">
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
	/*  wx.checkJsApi({
            jsApiList: [
                'getLocation',
                'onMenuShareTimeline',
                'onMenuShareAppMessage'
            ],
            success: function (res) {
                alert(JSON.stringify(res));
            }
     }); */
     var shareTitle="往期回顾";
     var shareDesc="查看历史图文消息";
     var shareImgUrl="http://<%=Constants.baehost %>/MetroStyleFiles/RecognitionImage.jpg";
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
            // alert(JSON.stringify(res));
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
            // alert("用户取消了分享");
         },
         fail: function (res) {
            // alert(JSON.stringify(res));
         }
     });
     wx.error(function(res){
         // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
         alert("errorMSG:"+res);
     });
 });
 </script>
<style>
*{
margin:0;}
.topPic
{
position:relative;
height:180px;
background:blue;
width:100%;
}
.topPic img
{
width:100%;
height:100%;
}
.topPic_title
{
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    height: 1.4em;
    font-size: 16px;
    padding: 20px 50px 12px 13px;
    background-image: -webkit-linear-gradient(top,rgba(0,0,0,0) 0,rgba(0,0,0,.7) 100%);
    background-image: linear-gradient(to bottom,rgba(0,0,0,0) 0,rgba(0,0,0,.7) 100%);
    color: #fff;
    text-shadow: 0 1px 0 rgba(0,0,0,.5);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
}
.navi{
height:45px;
width:100%;
background:#f2f2f2;
}
.navi p{
line-height:45px;
text-align:center;
width:50%;
float:left;
font-size:15px;
}
.singleMes{
height: 70px;
margin: 3%;
margin-top:16px;
margin-right:0px;
width: 94%;
border-bottom: 1px solid #f2f2f2;
}
.mesImg
{
    float: left;
    margin-right: 10px;
}
.mesImg img
{
    display: block;
    width: 80px;
    height: 60px;
}
.mesContent{
overflow:hidden;
}
.mesTitle{
font-size: 16px;
    color: #000;
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
}
.mesIntro{
margin-top:10px;
    font-size: 13px;
    color: #999;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    line-height: 1.3;
}
a{ text-decoration:none;
}
</style>
</head>
<body>
 <div style="position: absolute;top: 0px;right: 0px;"><p style="margin-right: 10px;margin-top: 5px;">欢迎您：<span class="username colorBlue" id="username" style="color:#2489ce;"><%=name %></span></p><img src="<%=headImgUrl %>" alt="" style="border-radius: 25px;height: 35px;width: 35px;position: absolute;right: 8px;top: 25px;"></div>
<div style="padding-left: 10px;height: 60px;padding-top: 10px;">
<img src="../mdm/images/logo.png" alt="" style="width:60%;">
</div>
<div class="topPic"><img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490602667276&di=5ff160cb3a889645ffaf2ba17b4f2071&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F65%2F94%2F64B58PICiVp_1024.jpg" />
<div class="topPic_title">科技生活，从大数据开始</div></div>
<div class="navi"><p>图文消息</p><p>XXXX</p></div>
	<div id="wrapper" style="top:290px;">
		<div class="scroller">
<div id="mesPushPanel">
<% for(int i=0;i<size;i++){ %>
<%-- <a href="http://shenan.duapp.com/mdm/NotificationCenter.jsp?num=<%=ams.get(i).getNum()%>">
 --%><a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=<%=Constants.APP_ID%>&redirect_uri=http%3A%2F%2F<%=Constants.baehost%>%2Fmdm%2FNotificationCenter.jsp?num=<%=ams.get(i).getNum()%>&response_type=code&scope=snsapi_userinfo&state=<%=uid2 %>#wechat_redirect">
<div class="singleMes">
<div class="mesImg">
<%if(ams.get(i).getPicture()!=null&&ams.get(i).getPicture()!=""){ %>
<img src="<%=ams.get(i).getPicture() %>" />
<% }else{%>
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490602667276&di=5ff160cb3a889645ffaf2ba17b4f2071&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F65%2F94%2F64B58PICiVp_1024.jpg" />
<%} %></div>
<div class="mesContent">
<h2 class="mesTitle"><%=ams.get(i).getTitle() %></h2>
<p class="mesIntro"><%=ams.get(i).getContent() %></p>
</div>
</div></a>
<%} %>
</div>
<div class="more"><i class="pull_icon"></i><span>上拉加载...</span></div>
		</div>
	</div>
	<script type="text/javascript">

	var realSize=<%=realSize %>;
	var size=<%=size %>;
			var myscroll = new iScroll("wrapper",{
				onScrollMove:function(){
					if (this.y<(this.maxScrollY)) {
						$('.pull_icon').addClass('flip');
						$('.pull_icon').removeClass('loading');
						$('.more span').text('释放加载...');
					}else{
						$('.pull_icon').removeClass('flip loading');
						$('.more span').text('上拉加载...');
					}
				},
				onScrollEnd:function(){
					
					if ($('.pull_icon').hasClass('flip')) {
						if(size<realSize){
						$('.pull_icon').addClass('loading');
						$('.more span').text('加载中...');
						pullUpAction();}
						else
							{
							$('.more span').text('我是有底线的...');
							}
					}
					
				},
				onRefresh:function(){
					$('.more').removeClass('flip');
					$('.more span').text('上拉加载...');
				}
				
			});
			
			function pullUpAction(){
				var img="";
				setTimeout(function(){
			 		$.ajax({
		    			url : "../QueryArticleMessage",
						type:'post',
						data:{
							startNumber:size,
							pageSize:5
						},
						success:function(data){
							for (var i = 0; i < data.length; i++) {
								if(data[i].picture!=null&&data[i].picture!=""){
									img="<img src='"+data[i].picture+"'/>";
								}
								else{
									img="<img src='https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490602667276&di=5ff160cb3a889645ffaf2ba17b4f2071&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F65%2F94%2F64B58PICiVp_1024.jpg' />";
								}
//								$('#mesPushPanel').append("<a href='http://shenan.duapp.com/mdm/NotificationCenter.jsp?num="+data[i].num+"'><div class='singleMes'><div class='mesImg'>"+img+"</div><div class='mesContent'><h2 class='mesTitle'>"+data[i].title+"</h2><p class='mesIntro'>"+data[i].content+"</p></div></div></a>");
								$('#mesPushPanel').append("<a href='https://open.weixin.qq.com/connect/oauth2/authorize?appid=<%=Constants.APP_ID%>&redirect_uri=http%3A%2F%2F<%=Constants.baehost%>%2Fmdm%2FNotificationCenter.jsp?num="+data[i].num+"&response_type=code&scope=snsapi_userinfo&state=<%=uid%>#wechat_redirect'><div class='singleMes'><div class='mesImg'>"+img+"</div><div class='mesContent'><h2 class='mesTitle'>"+data[i].title+"</h2><p class='mesIntro'>"+data[i].content+"</p></div></div></a>");
							}
							size=size+data.length;
							myscroll.refresh();
						},
						error:function(){
							console.log('error');
						},
					}); 
				
					myscroll.refresh();
				}, 1000)
			}
			if ($('.scroller').height()<$('#wrapper').height()) {
				$('.more').hide();
				myscroll.destroy();
			}

		</script>
</body>
</html>
