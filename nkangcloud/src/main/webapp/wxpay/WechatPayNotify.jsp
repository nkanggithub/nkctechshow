<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.WeixinPay.utils.PayUtil"%>
<%@ page import="com.nkang.kxmoment.util.Constants"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.Format"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%

String notifyXML = PayUtil.getNotifyResult(request, response);
out.print(notifyXML);

%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="initial-scale=1.0, width=device-width, user-scalable=no" />
	<title>微信支付成功</title>
	<link rel="stylesheet" type="text/css" href="../Jsp/CSS/lanren.css" />
</head>
<body>

<div class="header">
	  <div class="all_w" style="position:relative; z-index:1;">
		    <div class="ttwenz" style=" text-align:center; width:100%;">
		      <h4>交易详情</h4>
		      <h5>微信安全支付</h5>
		    </div>
		    <a href="http://<%= Constants.baehost%>/mdm/profile.jsp?UID=<%= Constants.devOpenID%>" class="fh_but">返回</a> 
	  </div>
</div>

<div class="zfcg_box ">
	<div class="all_w"><img src="http://nkctech.gz.bcebos.com/cg_03.jpg" /> 支付成功 </div>
</div>
<%-- <div class="cgzf_info">
	<div class="wenx_xx">
	  <div class="mz"><%= Constants.clientCNName %></div>
	  <div class="wxzf_price">￥<%= fee%></div>
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
				    <td align="right"><%= bank_type%></td>
				  </tr>
				   <tr>
				    <td>交易单号</td>
				    <td align="right"><%= transaction_id%></td>
				  </tr>
				</tbody>
			</table>
		 </div>
	</div>
</div> --%>


<div class="wzxfcgde_tb"><img src="http://nkctech.gz.bcebos.com/cg_07.jpg" /></div>

</body>

</html>