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
						table+='<tr>'
							+'			<td>'+myArrayList[j].map.database_name+'</td>'
							+'			<td>'+myArrayList[j].map.environment+'</td>'
							+'			<td>'+myArrayList[j].map.status+'</td>'
							+'		</tr>';
					}
					table+='</table>';
					div+=table;
					div+='</div>';
					$('body').append(div);
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
					$('body').append(div);
				}
				
			}
		 }
	});
});
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
<div style="padding-left: 10px;height: 70px;border-bottom: 4px solid black;padding-top: 10px;">
<img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="" style="width:60%;"></div>

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