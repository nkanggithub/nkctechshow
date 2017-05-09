<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Dashboard Status</title>
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>
<style type="text/css">
.statusDiv {
    margin: 5px;
    border: 1px solid #000;
}
.statusDiv h1 {
    background-color: #767676;
    color: #fff;
    line-height: 70px;
    margin: 0px;
    padding-left: 8px;
}
.statusDiv h5 {
    float: right;
    margin: 0px;
    padding-right: 5px;
    line-height: 30px;
    font-weight: normal;
}
.statusDiv table {
    width: 98%;
    text-align: left;
    background-color: #ddd;
    margin: auto;
    margin-bottom: 5px;
}
.statusDiv table tr th, .statusDiv table tr:nth-child(odd) td {
    background-color: #E5F6F2;
    line-height: 25px;
}
.statusDiv table tr:nth-child(even) td {
    background-color: #fff;
    line-height: 25px;
}
</style>
<script type="text/javascript">
$(function(){ 
	$.ajax({
		 url:'../Dashboard/findAllStatusList',
		 type:"GET",
		 success:function(resData){
			 var a=1;
		 }
	});
});
</script>
</head>
<body style="margin:0px">
<div style="padding-left: 10px;height: 70px;border-bottom: 4px solid black;padding-top: 10px;">
<img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="" style="width:60%;"></div>


<div class="statusDiv">
	<h1>Database Status - PRO</h1>
	<h5>last updated: 05/09/2017 @ 15:42:26 </h5>
	<table cellpadding="0" cellspacing="1">
		<tbody><tr>
			<th>Database</th>
			<th>Environment</th>
			<th>Status</th>
		</tr>
		<tr>
			<td>Pro - MDM_MONITORING</td>
			<td>PRO</td>
			<td>Up</td>
		</tr>
		<tr>
			<td>Pro - MDM_EXTEND</td>
			<td>PRO</td>
			<td>Up</td>
		</tr>
		<tr>
			<td>PRO - MDM_EXTEND_HPI</td>
			<td>PRO</td>
			<td>Up</td>
		</tr>
	</tbody></table>
</div>


</body>
</html>