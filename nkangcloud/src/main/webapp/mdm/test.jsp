<%@ page language="java"    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.nkang.kxmoment.util.*"%>
<%
	String ticket=RestUtils.getTicket();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta http-equiv="Access-Control-Allow-Methods" content="POST, GET, OPTIONS, DELETE">
<meta http-equiv="Access-Control-Max-Age" content="3600">
<meta http-equiv="Access-Control-Allow-Headers" content="x-requested-with">
<title>test share</title>
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>
<script type="text/javascript" src="../Jsp/JS/jquery.sha1.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
var string1="noncestr=abc"
	+"&"
	+"jsapi_ticket=<%=ticket%>"
	+"&"
	+"timestamp=1414587457"
	+"&"
	+"url=http://shenan.duapp.com/mdm/test.jsp";
	
var signature=$.sha1(string1);

wx.config({
        debug: false,
        appId: '<%=Constants.APP_ID%>',
        timestamp: 1414587457,
        nonceStr: 'abc',
        signature: signature,
        jsApiList: [
            // 所有要调用的 API 都要加到这个列表中
            'checkJsApi',
            'openLocation',
            'getLocation',
            'onMenuShareTimeline',
            'onMenuShareAppMessage'
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
                alert(JSON.stringify(res));
            }
     });
	 
	 var url = window.location.href;
     var shareTitle="明日医疗资讯";
     var shareImgUrl="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EUmgT&oid=00D90000000pkXM";
	//----------“分享给朋友”
     wx.onMenuShareAppMessage({
         title: "明日医疗资讯", // 分享标题
         desc: shareTitle, // 分享描述
         link: url, // 分享链接
         imgUrl: shareImgUrl, // 分享图标
         type: '', // 分享类型,music、video或link，不填默认为link
         dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
         success: function () { 
             // 用户确认分享后执行的回调函数、
             alert("用户成功分享了该网页");
         },
         cancel: function () { 
             // 用户取消分享后执行的回调函数
             alert("用户取消了分享");
         },
         fail: function (res) {
             alert(JSON.stringify(res));
         }
     });
     //------------"分享到朋友圈"
     wx.onMenuShareTimeline({
         title: '明日医疗资讯', // 分享标题
         link:url, // 分享链接
         imgUrl: shareImgUrl, // 分享图标
         success: function () { 
             // 用户确认分享后执行的回调函数
             alert("用户成功分享了该网页");
         },
         cancel: function () { 
             // 用户取消分享后执行的回调函数
             alert("用户取消了分享");
         },
         fail: function (res) {
             alert(JSON.stringify(res));
         }
     });
 });
 
 /* // 分享到朋友圈
 WeixinJSBridge.on('menu:share:timeline', function (argv) {
     WeixinJSBridge.invoke('shareTimeline', {
         "img_url": "http://bcs.duapp.com/api100/image/logo/newyear.jpg",
         "img_width": "160",
         "img_height": "160",
         "link": "http://api100.duapp.com/card/",
         "desc":  "Best wishes for a wonderful new year.",
         "title": "新年贺卡"
     }, function (res) {
         _report('timeline', res.err_msg);
     });
 });
}, false) */
</script>
</head>
<body>
测试分享功能
</body>
</html>