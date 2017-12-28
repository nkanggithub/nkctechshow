<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta charset="utf-8" />  
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />  
<meta name="apple-mobile-web-app-capable" content="yes" />  
<meta name="apple-mobile-web-app-status-bar-style" content="black" />  
<meta name="format-detection" content="telephone=no" />  
<title>测试支付</title>   
</head>  
<body>  
    <div class="index_box">  
        
            <p class="cz_btn"><a href="javascript:pay();" class="btn_1">立即支付</a></p>  
        </div>  
    </div>  
<%  
String code = "oI3krwR_gGNsz38r1bdB1_SkcoNw"; 
 %>  
<%-- <input type="text" id="code" value="<%out.print(code); %>"/>  
<input type="text" id="path" value="${pageContext.request.contextPath}"/>  
<div><hr/>  
    code:<%out.print(code); %>  
</div>  --%> 
    <script type="text/javascript">  
        var appId,timeStamp,nonceStr,pg,signType,paySign;  
      function onBridgeReady(){  
           WeixinJSBridge.invoke(  
               'getBrandWCPayRequest', {  
                   "appId" : appId,     //公众号名称，由商户传入       
                   "timeStamp": timeStamp,         //时间戳，自1970年以来的秒数       
                   "nonceStr" : nonceStr, //随机串       
                   "package" : "prepay_id=" + pg,       
                   "signType" : signType,         //微信签名方式:       
                   "paySign" : paySign    //微信签名   
               },  
               function(res){       
                   if(res.err_msg == "get_brand_wcpay_request:ok" ) {  
                         
                       alert("支付成功");  
                   }   
               }  
           );   
        }  
        function pay(){  
            var code = "oI3krwR_gGNsz38r1bdB1_SkcoNw"; 
            //var code = document.getElementById("code").value;  
 		 alert(code);
            send_request(function(value){  
                var json = eval("(" + value + ")");  
                alert("guess");
                if(json.length > 0){  
                    appId = json[0].appId;  
                    alert("appId="+appId);
                    timeStamp = json[0].timeStamp;  
                    nonceStr = json[0].nonceStr;
                    alert("nonceStr="+nonceStr);
                    pg = json[0].pg;  
                    signType = json[0].signType;  
                    paySign = json[0].paySign;  
                    if (typeof WeixinJSBridge == "undefined"){  
                       if( document.addEventListener ){  
                           document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);  
                       }else if (document.attachEvent){  
                           document.attachEvent('WeixinJSBridgeReady', onBridgeReady);   
                           document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);  
                       }  
                    }else{  
                       onBridgeReady();  
                    }   
                }  
            },"http://nkctech.duapp.com/pay/payparm",true);  
        }  
function send_request(callback, urladdress,isReturnData){        
    var xmlhttp = getXMLHttpRequest();  
    alert("urladdress==="+ urladdress);
    xmlhttp.onreadystatechange = function(){  
    	alert("callback==="+callback);
    	
            if (xmlhttp.readyState == 4) {  
            	alert("xmlhttp.readyState == "+xmlhttp.readyState);
                    try{  
                    if(xmlhttp.status == 200){  
                    	alert("status == 200");
                        if(isReturnData && isReturnData==true){
                        	alert("responseText="+xmlhttp.responseText);
                            callback(xmlhttp.responseText);  
                        }  
                    }else{  
                        callback("页面找不到！"+ urladdress +"");  
                    }  
                } catch(e){  
                    callback("请求发送失败，请重试！" + e);  
                }  
           }  
    } 
    alert("haha");
    xmlhttp.open("POST", urladdress, true);
    alert("baba");
    xmlhttp.send(null);  
}  
function getXMLHttpRequest() {  
    var xmlhttp;  
    if (window.XMLHttpRequest) {  
        try {  
            xmlhttp = new XMLHttpRequest();  
            xmlhttp.overrideMimeType("text/html;charset=UTF-8");  
        } catch (e) {}  
    } else if (window.ActiveXObject) {  
        try {  
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");  
        } catch (e) {  
            try {  
                xmlhttp = new ActiveXObject("Msxml2.XMLHttp");  
            } catch (e) {  
                try {  
                    xmlhttp = new ActiveXObject("Msxml3.XMLHttp");  
                } catch (e) {}  
            }  
        }  
    }  
    return xmlhttp;  
}  
    </script>  
</body>  
</html> 