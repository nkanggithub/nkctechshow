<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,org.json.JSONObject"%>
<%@ page import="com.nkang.kxmoment.baseobject.GeoLocation"%>
<%@ page import="com.nkang.kxmoment.util.*"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="com.nkang.kxmoment.baseobject.WeChatUser"%>
<%@ page import="com.nkang.kxmoment.baseobject.ClientMeta"%>
<%@ page import="com.nkang.kxmoment.util.Constants"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.nkang.kxmoment.util.WeixinPay.utils.PayUtil"%>
<%@ page import="com.nkang.kxmoment.util.WeixinPay.bean.Payment"%>

<%
Payment qrpay = new Payment();
String uid = Constants.devOpenID;
String code = uid;
String price = "1";
String notifyURL = Constants.notifyURL;
String name = "";
String headImgUrl ="";
String phone="";
HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(Constants.devOpenID);
if(res!=null){
	if(res.get("HeadUrl")!=null){
		headImgUrl=res.get("HeadUrl");
	}
	if(res.get("NickName")!=null){
		name=res.get("NickName");
	}

	if(res.get("phone")!=null){
		phone=res.get("phone");
	}
}
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title><%= Constants.clientCodeCN%>-微信扫码支付</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<script type="text/javascript" src="../nkang/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="../Jsp/JS/payment/qrcode.js"></script>

<style>
	*{padding:0;margin: 0;}
body{
  background: #FEFEFE;
  margin-bottom: 50px;
  height: auto;
}
a{
  text-decoration: none;
  color:black;
}
a:visited{
  color:black;
}
.infoPanel
{
  padding:0 2%;
  width: 96%;
}
.infoArea,.imgArea{
  width:100%;
  height:40px;
  border-bottom: 1px solid #EFEFEF;
}
.imgArea{
  background: white;
  height:90px;
  position: relative;
}
.imgContainer
{
  position: absolute;
  left:40%;
  top:10px;
  width:70px;
  height:70px;
  overflow: hidden;
  border-radius: 50%;
}
.imgContainer img
{
  width:100%;
  height: 100%;
}
.infoTitle
{
  width:29%;
  text-align: left;
  padding-left:1%;
  height: 100%;
  line-height: 45px;
  float: left;
  font-weight:bold;
}
.infoVal
{
  float: right;
  width:68%;
  text-align: right;
  padding-right:2%;
  height: 100%;
  line-height: 45px;
}
.pay{
    text-align: center;
    height:50px;
    line-height: 50px;
    background: #000000;
    color: white;
    position:absolute;
    bottom:30px;}
.infoPay{
padding-top:20px;
height:70px;
/* border-bottom:1px solid #EFEFEF; */
}
.payTitle{
    text-align: left;
    line-height: 40px;
    color: black;
    padding-left: 10px;
    border: none;
    font-weight:bolder;
}
.infoItem{
width:30%;
margin-left:2%;
height:50px;
float:left;
border:1px solid #000000;
color:#000000;
border-radius:5px;
line-height:25px;
font-size:0.8rem;
text-align:center;
}
#footer {
    background: #DCD9D9;
    bottom: 0px;
    color: #757575;
    font-size: 12px;
    padding: 10px 1%;
    position: absolute;
    text-align: center;
    width: 100%;
    z-index: 1002;
    left: 0;
}
.default{
	color:white;
	background:#000000;
}

#qrcodeid{
	position:absolute;
	left:25%;
}
	</style>
	</head>
<body>
	

    	
	
	
	<div id="data_model_div" style="height: 100px">
		<i class="icon" style="position: absolute;top: 25px;z-index: 100;right: 20px;">
			<div style="width: 30px;height: 30px;float: left;border-radius: 50%;overflow: hidden;">
				<img class="exit" src="<%=headImgUrl %>" style="width: 30px; height: 30px;" />
			</div>
			<span style="position: relative;top: 8px;left: 5px;font-style:normal"><%=name %></span>
		</i>
		<img style="position: absolute;top: 8px;left: 10px;z-index: 100;height: 60px;" class="HpLogo" src="http://nkctech.gz.bcebos.com/nkclogo.png" alt="Logo">
		<div style="width: 100%; height: 80px; background: white; position: absolute; border-bottom: 4px solid #000000;"></div>
	</div>
    <div class="infoPanel">
      <div class="infoArea">
        <p class="infoTitle">手机号码</p>
        <p class="infoVal"><%=phone %></p>
      </div>
    </div>
    <div class="infoPanel">
      <div class="infoPay">
	  <div class="infoItem"><span>2160</span>元<br>24次课</div>
	  <div class="infoItem"><span>3880</span>元<br>48次课</div>
	  <div class="infoItem"><span>6680</span>元<br>96次课</div>
     </div>
    </div>

<%-- <input id="qrtext" type="text" value="<%= qrpay.getCodeurl() %>" style="width:80%; display:none;"  /><br /> --%>
<div id="qrcode" style="width:100px; height:100px; margin-top:15px;"></div>

<script type="text/javascript"> 
	var qrcode = new QRCode(document.getElementById("qrcode"), {
		width : 200,
		height : 200
	});

	$(function(){
		$(".infoItem").on("click",function(){
			totalfee=$(this).children("span").text();
			$(this).addClass("default");
			$(this).siblings().removeClass("default");
			totalfee = totalfee+"00";
			totalfee = "1";
			$.ajax({
				 url:'../pay/payqrparm',
				 type:"GET",
				 data : {
					 totalfee:totalfee,
				 },
				 success:function(data){
					 if(data){
						 qrcode.makeCode(data.codeurl);
					 }
				}
			});
		});
	});
	


/* 	function makeCode () {		
		var elText = document.getElementById("qrtext");
		
		if (!elText.value) {
			alert("Input a text");
			elText.focus();
			return;
		}
		
		qrcode.makeCode(elText.value);
	} */
	
</script>
      <div class="infoArea pay"><a href="javascript:makeCode();" style="color:white;">立即支付</a></div>
    	<div id="footer">
		<span class="clientCopyRight"><nobr>©版权所有 | 重庆NKC科技有限公司</nobr></span>
	</div>
	</body>
</html>
