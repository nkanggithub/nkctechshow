var __pt=0;

function InitAjax()
{
　var ajax=false; 
　try { 
　　ajax = new ActiveXObject("Msxml2.XMLHTTP"); 
　} catch (e) { 
　　try { 
　　　ajax = new ActiveXObject("Microsoft.XMLHTTP"); 
　　} catch (E) { 
　　　ajax = false; 
　　} 
　}
　if (!ajax && typeof XMLHttpRequest!='undefined') { 
　　ajax = new XMLHttpRequest(); 
　} 
　return ajax;
}

function change1(v){
  // alert();
  var id = $("#user_xq  option:selected").val();
  
  if(id != 0 && id != ""&&id != null){
	 $("#user_km").html("");
	 $("#kemu").show();
	 $("#user_km").append("<option value='0'>选择科目</option>");
	 $.get("find_km.asp",{id:id},function(data){
		  //alert(data);
		  var i = data.split(';');
		 // alert(i.length);
		  for(j=0; j < i.length - 1; j++){
			  var val = i[j].split(',');
			  $("#user_km").append("<option value='"+val[0]+"'>"+val[1]+"</option>");
		  }
	 });
	 
	 
  }else{
	 $("#kemu").hide();
  }
}

function getparastr_source(strname,key) {
    var hrefstr,pos,parastr,para,tempstr;
    hrefstr = window.location.href;
    pos = hrefstr.indexOf("?")
    parastr = hrefstr.substring(pos+1);
    para = parastr.split("&");
    tempstr="";
    for(i=0;i<para.length;i++)    {
     tempstr = para[i]; 
     pos = tempstr.indexOf("=");  
     if(tempstr.substring(0,pos) == strname) {  

		if (tempstr.substring(pos+1) != ""){
			 var url = "/leadform/url_setcookie_ajax.php";
			 var postStr  = key + "=" + tempstr.substring(pos+1);
			 var ajax2 = InitAjax();
			 ajax2.open("POST", url, true); 
			 ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
			 ajax2.send(postStr);
			 ajax2.onreadystatechange = function() { } 
			 return tempstr.substring(pos+1);
		}
		else{
		}
	 }
	}
return null;
}


var programstr = getparastr_source('source','source'); 
var svcode_str = getparastr_source('SV_Code','svcode'); 

$(document).ready(function(){
  	function InitAjax()
				{
				　var ajax=false; 
				　try { 
				　　ajax = new ActiveXObject("Msxml2.XMLHTTP"); 
				　} catch (e) { 
				　　try { 
				　　　ajax = new ActiveXObject("Microsoft.XMLHTTP"); 
				　　} catch (E) { 
				　　　ajax = false; 
				　　} 
				　}
				　if (!ajax && typeof XMLHttpRequest!='undefined') { 
				　　ajax = new XMLHttpRequest(); 
				　} 
				　return ajax;
				}
				
				
				function getQueryVariable(variable,key) {
					var query = window.location.search.substring(1);
					var vars = query.split("&");
					for(var i = 0; i < vars.length; i++) {
						var pair = vars[i].split("=");
						if(pair[0] == variable) {
							
							var url = "/leadform/url_setcookie_ajax.php";
							var postStr  = key + "=" + pair[1] ;
							var ajax2 = InitAjax();
							ajax2.open("POST", url, true); 
							ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
							ajax2.send(postStr);
							ajax2.onreadystatechange = function() { 
							}		
							
							
							return pair[1];
						}
					}
					
				}
				
				

				function completeLogin(response_text, city,fntype,form) {
					var error ='';
					//alert("response_text:"+response_text+"   city:"+city+"   fntype:"+fntype+"    form:"+form);
					if (response_text){
						
						if (success=="1") {
							
						}else{
							
						}
					} else {
						
					}
				}
				var isSending = false;
				$("#sign_submit").click(function(){
					if( isSending || !_checkform.check() ) return;
				
					var user_name =  $("#user_name").val();
					var user_age = 0;
					var user_mobile =  $("#user_mobile").val();
					var user_email =  $("#user_email").val();									
					var user_age = $("#user_age").val();					
					var user_sex = $("#user_sex").val();
					var user_xq = $("#user_xq").val();
					var user_km = $("#user_km").val();
					$.get("right_add.asp", {user_name:user_name,user_age:user_age,user_mobile:user_mobile,user_email:user_email,user_sex:user_sex,user_xq:user_xq,user_km:user_km},function(data){
						isSending = false;
						var success = data;
						if(success != "1"){
							
							alert("提交失败");
							location.reload();
							$("#user_name").val("");
							$("#user_mobile").val("");
							$("#user_email").val("");
						}else{
							
							alert("提交成功");
							location.reload();
							$("#user_name").val("");
							$("#user_mobile").val("");
							$("#user_email").val("");
							(function()
							{   
								function deleteCookie(cookiename)
								{
									var d = new Date();
									d.setDate(d.getDate() - 10000);
									document.cookie = cookiename + "=;expire="+d.toGMTString();
									//alert(cookiename);
								}
								deleteCookie("user_age");
								deleteCookie("user_sex");
								deleteCookie("user_name");
								deleteCookie("user_mobile");
								deleteCookie("user_email");
							})();
						}
			        }); 
					isSending = true;
					$(".btn_submit").css({"background-position":"bottom center","cursor":"pointer"});
				});

			//var source = getQueryVariable("source","source");
			//alert(source);
			
			var coo = (function(){
				var o = {};
				var cookie = document.cookie.split("; ");
				for( var i=0;i<cookie.length;i++ ){
					var s = cookie[i].split("=");
					o[ s[0] ] = s[1];
				}
				return o;
			})();
			
			
			if( coo.user_age ){
				$("#user_age").val(coo.user_age);
			}
			if( coo.user_name ){
				$("#user_name").val(coo.user_name);
			}
			if( coo.user_mobile ){
				$("#user_mobile").val(coo.user_mobile);
			}
			if( coo.user_email ){
				$("#user_email").val(coo.user_email);
			}
			
			if( coo.city1 ){
				$("#city1").val( coo.city1 );
				city_1( document.getElementById('city1').value );
			}
			if( coo.city2 ){
				$("#city2").val( coo.city2 );
				city_2( document.getElementById('city2').value );
			}
			if( coo.mainCity ){
				$("#mainCity").val( coo.mainCity );
				
			}
			
			$("#user_age").change(function(){
				document.cookie = "user_age="+$(this).val();
			});
			$("#user_name").change(function(){
				document.cookie = "user_name="+$(this).val();
			});
			$("#user_mobile").change(function(){
				document.cookie = "user_mobile="+$(this).val();
				
			});
			$("#user_email").change(function(){
				 document.cookie = "user_email="+$(this).val();
			 });
			
			
			$("#city1").change(function(){
				document.cookie = "city1="+$(this).val();
			});
			
			$("#city2").change(function(){
				document.cookie = "city2="+$(this).val();
			});
			
			$("#mainCity").change(function(){
				document.cookie = "mainCity="+$(this).val();
			});
			_checkform.init();
			//_checkform.check();
			
});
