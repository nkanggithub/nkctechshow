<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.WeixinPay.utils.PayUtil"%>
<%@ page import="com.nkang.kxmoment.util.Constants"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.Format"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%

//String resXml = PayUtil.getNotifyResult(request);
//String uid = PayUtil.getXmlPara(resXml,"openid");
//String transaction_id =  PayUtil.getXmlPara(resXml,"transaction_id");
//String total_fee =  PayUtil.getXmlPara(resXml,"total_fee");
//String notifyURL = Constants.notifyURL;
//String bank_type = PayUtil.getXmlPara(resXml,"bank_type");
//String out_trade_no = PayUtil.getXmlPara(resXml,"out_trade_no"); 


String notifyXML = PayUtil.getNotifyResult(request);
String myresXml = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
response.getWriter().print(myresXml.toString());  
response.getWriter().close();  

String notifyXML2 = "<xml><appid><![CDATA[wx022b55e5bdea4c51]]></appid><bank_type><![CDATA[CFT]]></bank_type><cash_fee><![CDATA[1]]></cash_fee><device_info><![CDATA[WEB]]></device_info><fee_type><![CDATA[CNY]]></fee_type><is_subscribe><![CDATA[Y]]></is_subscribe><mch_id><![CDATA[1469932302]]></mch_id><nonce_str><![CDATA[123]]></nonce_str><openid><![CDATA[oI3krwR_gGNsz38r1bdB1_SkcoNw]]></openid><out_trade_no><![CDATA[NKC1515997814882]]></out_trade_no><result_code><![CDATA[SUCCESS]]></result_code><return_code><![CDATA[SUCCESS]]></return_code><sign><![CDATA[7B53540F235ADC710CF8A7C6E5C0A0FD]]></sign><time_end><![CDATA[20180115143022]]></time_end><total_fee>1</total_fee><trade_type><![CDATA[JSAPI]]></trade_type><transaction_id><![CDATA[4200000056201801154446651635]]></transaction_id></xml>";
notifyXML = notifyXML2;
String uid = PayUtil.getXmlPara(notifyXML,"openid");
String transaction_id =  PayUtil.getXmlPara(notifyXML,"transaction_id");
String total_fee =  PayUtil.getXmlPara(notifyXML,"total_fee");
String notifyURL = Constants.notifyURL;
String bank_type = PayUtil.getXmlPara(notifyXML,"bank_type");
String out_trade_no = PayUtil.getXmlPara(notifyXML,"out_trade_no");
Date date = new Date(Long.valueOf(out_trade_no.substring(3)));
Format format = new SimpleDateFormat("yyyy MM dd HH:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>微信支付成功</title>
	<meta name="viewport" content="initial-scale=1.0, width=device-width, user-scalable=no">
	<link rel="stylesheet" type="text/css" href="../Jsp/CSS/lanren.css" />
</head>
<body>
<div class="header">
  <div class="all_w" style="position:relative; z-index:1;">
    <div class="ttwenz" style=" text-align:center; width:100%;">
      <h4>交易详情</h4>
      <h5>微信安全支付</h5>
    </div>
    <a href="http://<%= Constants.baehost%>/mdm/profile.jsp?UID=<%= uid%>" class="fh_but">返回</a> </div>
</div>

<div class="zfcg_box ">
<div class="all_w">
<img src="http://nkctech.gz.bcebos.com/cg_03.jpg"> 支付成功 </div>

</div>
<div class="cgzf_info">
<div class="wenx_xx">
  <div class="mz"><%= Constants.clientCNName %></div>
  <div class="wxzf_price">￥<%= total_fee%></div>
</div>

<div class="spxx_shop">
 <div class=" mlr_pm">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tbody><tr>
    <td>商品编码</td>
    <td align="right"><%= out_trade_no%></td>
  </tr>
   <tr>
    <td>交易时间</td>
    <td align="right"><%= format.format(date)%></td>
  </tr>
   <tr>
    <td>支付方式</td>
    <td align="right">招商银行</td>
  </tr>
   <tr>
    <td>交易单号</td>
    <td align="right"><%= transaction_id%></td>
  </tr>
</tbody></table>

 </div>

</div>
</div>


<div class="wzxfcgde_tb"><img src="http://nkctech.gz.bcebos.com/cg_07.jpg"></div>

</body></html>