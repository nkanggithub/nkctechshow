<%@ page language="java"   pageEncoding="utf-8"%>
<%@ page import="com.nkang.kxmoment.util.OAuthUitl.SNSUserInfo,java.lang.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,com.nkang.kxmoment.util.RestUtils"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="com.nkang.kxmoment.baseobject.WeChatUser"%>
<%@ page import="com.nkang.kxmoment.baseobject.ClientMeta"%>
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
			HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(uid);
			if(res!=null){
				if(res.get("HeadUrl")!=null){
					headImgUrl=res.get("HeadUrl");
				}
				if(res.get("NickName")!=null){
					name=res.get("NickName");
				}
			}
			SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date=new Date();
			String currentDate = format.format(date);
			
			
				if(uid.equals(originalUid)){
					MongoDBBasic.updateVisited(uid,currentDate,"DashboardStatus",user.getHeadImgUrl(),name);
				}
				else
				{
					MongoDBBasic.updateVisited(uid,currentDate,"DashboardStatus",user.getHeadImgUrl(),name);
					/* if(!"STATE".equals(originalUid)){
						HashMap<String, String> resOriginal=MongoDBBasic.getWeChatUserFromOpenID(originalUid);
						MongoDBBasic.updateShared(originalUid,currentDate,"DashboardStatus",resOriginal.get("HeadUrl"),resOriginal.get("NickName"));
					} */
				}
			/* 
			try{
			}catch(Exception e){
			
			} */
		
} 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
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
    line-height: 40px;
    margin: 0px;
    padding-left: 8px;
    font-size:15px;
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
}
.statusDiv table tr:nth-child(even) td {
    background-color: #fff;
}
.statusDiv table tr td {
	font-size:12px;
	 line-height: 15px;
	 padding:5px 0px;
}
.statusDiv table tr th {
	font-size:12px;
	 line-height: 15px;
	 padding:5px 0px;
}
</style>
<script type="text/javascript">
$(function(){ 
	$.ajax({
		 url:'../Dashboard/findAllStatusList',
		 type:"GET",
		 success:function(resData){
			for(var i=0;i<resData.length;i++){
				var temp=resData[i];
				var myArrayList=temp.status.myArrayList;
				var updateAt=temp.updateAt;
				if(temp.type=="DB")
				{
					var div='<div class="statusDiv">';
					div+='<h1>Database Status - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table='<table cellpadding="0" cellspacing="1">';
					table+='<tr>'
						+'			<th>Database</th>'
						+'			<th>Environment</th>'
						+'			<th>Status</th>'
						+'		</tr>';
					for(var j=0;j<myArrayList.length;j++)
					{
						var style='';
						if(myArrayList[j].map.status.toLowerCase()=='Down'.toLowerCase()){
							style=' style="background-color:red;color:#fff;" ';
						}
						table+='<tr>'
							+'			<td'+style+'>'+myArrayList[j].map.database_name+'</td>'
							+'			<td'+style+'>'+myArrayList[j].map.environment+'</td>'
							+'			<td'+style+'>'+myArrayList[j].map.status+'</td>'
							+'		</tr>';
					}
					table+='</table>';
					div+=table;
					div+='</div>';
					$('#DB').html(div);
				}else if(temp.type=="MSG")
				{
					var div='<div class="statusDiv">';
					div+='<h1>Outbound JMS Messages - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table='<table cellpadding="0" cellspacing="1">';
					table+='<tr>'
						+'			<th>Pending</th>'
						+'			<th>Completed</th>'
						+'			<th>Ignored</th>'
						+'		</tr>';
					var Pending=0,Completed=0,Ignored=0;
					for(var j=0;j<myArrayList.length;j++)
					{
						if(!(myArrayList[j].map.ignored  instanceof Object)){
							Ignored+=parseInt(myArrayList[j].map.ignored);
						}
						if(!(myArrayList[j].map.pending  instanceof Object)){
							Pending+=parseInt(myArrayList[j].map.pending);
						}
						if(!(myArrayList[j].map.completed  instanceof Object)){
							Completed+=parseInt(myArrayList[j].map.completed);
						}
					}
					table+='<tr>'
						+'			<td>'+Pending+'</td>'
						+'			<td>'+Completed+'</td>'
						+'			<td>'+Ignored+'</td>'
						+'		</tr>';
					table+='</table>';
					div+=table;
					div+='</div>';
					$('#MSG').html(div);
				}else if(temp.type=="JOB")
				{
					var div='<div class="statusDiv">';
					div+='<h1>Job Status - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table='<table cellpadding="0" cellspacing="1">';
					table+='<tr>'
						+'			<th>Loading Table</th>'
						+'			<th>Description</th>'
						+'			<th>Start Time</th>'
						+'			<th>Elapsed Time</th>'
						+'			<th>Status</th>'
						+'		</tr>';
					for(var j=0;j<myArrayList.length;j++)
					{
						 table+='<tr>'
							+'			<td>'+myArrayList[j].map.loadingTable+'</td>'
							+'			<td>'+myArrayList[j].map.description+'</td>'
							+'			<td>'+myArrayList[j].map.startTime+'</td>'
							+'			<td>'+myArrayList[j].map.elapsedTime+'</td>'
							+'			<td>'+myArrayList[j].map.status+'</td>'
							+'		</tr>'; 
					}
					if(myArrayList.length==0){
						table+='<tr>'
							+'			<td colspan="5">no jobs running</td>'
							+'		</tr>';
					}
					table+='</table>';
					div+=table;
					div+='</div>';
					$('#JOB').html(div);
				}else if(temp.type=="JBOSS")
				{
					var div='<div class="statusDiv">';
					div+='<h1>Server Status - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table='<table cellpadding="0" cellspacing="1">';
					table+='<tr>'
						+'			<th>Server</th>'
						+'			<th>Type</th>'
						+'			<th>Use</th>'
						+'			<th>Status</th>'
						+'		</tr>';
					for(var j=0;j<myArrayList.length;j++)
					{
						var status=myArrayList[j].map.status;
						
						var fdStart = myArrayList[j].map.description.indexOf("CNT PROCESS PRO");
						 
						if(myArrayList[j].map.description=='Cleanse'){
							if(myArrayList[j].map.status=='405'){
								myArrayList[j].map.status='Up';
							}else{
								myArrayList[j].map.status='Down';
							}
						}else if(fdStart==0){
							if(myArrayList[j].map.status=='405'){
								myArrayList[j].map.status='Up';
							}else{
								myArrayList[j].map.status='Down';
							}
						}
						else{
							if(myArrayList[j].map.status=='200'){
								myArrayList[j].map.status='Up';
							}else{
								myArrayList[j].map.status='Down';
							}
						}
						var style='';
						if(myArrayList[j].map.status=='Down'){
							style=' style="background-color:red;color:#fff;" ';
						}
						 table+='<tr>'
							+'			<td'+style+'>'+formatUrl(myArrayList[j].map.url)+'</td>'
							+'			<td'+style+'>'+myArrayList[j].map.type+'</td>'
							+'			<td'+style+'>'+myArrayList[j].map.description+'</td>'
							+'			<td'+style+'>'+myArrayList[j].map.status+'['+status+']</td>'
							+'		</tr>'; 
					}
					table+='</table>';
					div+=table;
					div+='</div>';
					$('#JBOSS').html(div);
				}else if(temp.type=="STRulesHPE")
				{
					var div='<div class="statusDiv">';
					div+='<h1>HPE Sales Territory Rules Engine - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table=formatEngineTable(myArrayList);
					div+=table;
					div+='</div>';
					$('#STRulesHPE').html(div);
				}else if(temp.type=="STRulesHPI")
				{
					var div='<div class="statusDiv">';
					div+='<h1>HPI Sales Territory Rules Engine - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table=formatEngineTable(myArrayList);
					div+=table;
					div+='</div>';
					$('#STRulesHPI').html(div);
				}else if(temp.type=="FrcstSTRulesHPE")
				{
					var div='<div class="statusDiv">';
					div+='<h1>HPE Forecast Sales Territory Rules Engine - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table=formatEngineTable(myArrayList);
					div+=table;
					div+='</div>';
					$('#FrcstSTRulesHPE').html(div);
				}else if(temp.type=="FrcstSTRulesHPI")
				{
					var div='<div class="statusDiv">';
					div+='<h1>HPI Forecast Sales Territory Rules Engine - PRO</h1>';
					div+='<h5>last updated: '+formatDate(updateAt)+'</h5>';
					var table=formatEngineTable(myArrayList);
					div+=table;
					div+='</div>';
					$('#FrcstSTRulesHPI').html(div);
				}
				
			}
		 }
	});
});
function   formatEngineTable(myArrayList)   {
	var table='<table cellpadding="0" cellspacing="1">';
					table+='<tr>'
						+'			<th>Total Backlog</th>'
						+'			<th>Queued for Processing</th>'
						+'			<th>Last Processed Rule Date (UTC)</th>'
						+'			<th>Processed in Last 24hr</th>'
						+'			<th>Processed Yesterday</th>'
						+'			<th>Processed 2 Days Ago</th>'
						+'		</tr>';
					for(var j=0;j<myArrayList.length;j++)
					{
						table+='<tr>'
							+'			<td>'+myArrayList[j].map.total+'</td>'
							+'			<td>'+myArrayList[j].map.queued+'</td>'
							+'			<td>'+myArrayList[j].map.lastprocesed+'</td>'
							+'			<td>'+myArrayList[j].map.processedin24HRS+'</td>'
							+'			<td>'+myArrayList[j].map.processedyest+'</td>'
							+'			<td>'+myArrayList[j].map.processed3+'</td>'
							+'		</tr>';
					}
					table+='</table>';
	return table;
}
function   formatUrl(url)   {
	var start=url.indexOf('://');
	var end=url.indexOf('.');
	return url.substring(start+3, end);
}
//时间转换 
function   formatDate(now)   {
    var   now= new Date(now);     
    var   year=now.getFullYear();     
    var   month=now.getMonth()+1;     
    var   date=now.getDate();     
    var   hour=now.getHours();
    var   minute=now.getMinutes();     
    var   second=now.getSeconds();
    return   year+"-"+fixZero(month,2)+"-"+fixZero(date,2)+"&nbsp;&nbsp;"+fixZero(hour,2)+":"+fixZero(minute,2)+":"+fixZero(second,2); 
}  
//时间如果为单位数补0 
function fixZero(num,length){     
    var str=""+num;
    var len=str.length;     var s="";
    for(var i=length;i-->len;){         
        s+="0";
    }
    return s+str;
}
</script>
</head>
<body style="margin:0px">
<div style="padding-left: 10px;height: 70px;border-bottom: 4px solid #000000;padding-top: 10px;">
<img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="" style="height:60px;">
<div style="width:100%;text-align:right;margin-top:-80px;">
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
</div>
</div>
<div id="DB"></div>
<div id="JBOSS"></div>
<div id="MSG"></div>
<div id="JOB"></div>
<div id="FrcstSTRulesHPE"></div>
<div id="FrcstSTRulesHPI"></div>
<div id="STRulesHPE"></div>
<div id="STRulesHPI"></div>
<!-- 
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
</div> -->


</body>
</html>