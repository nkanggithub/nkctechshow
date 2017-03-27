<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.baseobject.CongratulateHistory"%>
<%@ page import="com.nkang.kxmoment.util.RestUtils"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="java.util.List"%>
<%	
String uid = request.getParameter("uid");
String num = request.getParameter("num");
List<CongratulateHistory> chList=MongoDBBasic.getRecognitionInfoByOpenID(uid,num);
CongratulateHistory ch=new CongratulateHistory();
if(!chList.isEmpty()){
	ch=chList.get(0);
}
String openid=MongoDBBasic.getRegisterUserByrealName(ch.getFrom());
String signature=MongoDBBasic.getUserWithSignature(openid);


%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en"><head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="hpe">
  </head>
<body style="margin:0;">
            
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing:0;display:table;">
             <tbody>
              <tr>
               <td width="270" valign="top" style="width:202.5pt;padding:0in 7.5pt 0in 15.0pt">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing:0">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in"><p class="MsoNormal" style="/* line-height:14.0pt */"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><b><img id="_x0000_i1025" src="https://myrecognitionpprd.int.hpe.com/hpenterprise/images/designtheme/hp2/1/hpe-logo.png" style="
    width: 100%;
"></b>
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
               <td width="270" valign="bottom" style="width:202.5pt;padding:0in 15.0pt 0in 7.5pt;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing:0;">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in"><h1 align="right" style="margin:0in;margin-bottom:.0001pt;text-align:right;margin-bottom:0!important;color:inherit;margin-bottom: 10px!important;word-wrap:normal;"><span style="font-size: 1px;font-family:&quot;Arial&quot;,sans-serif;color:black;">MyRecognition @hpe
                      <o:p></o:p></span></h1></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
            
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;/* border-collapse:collapse; *//* display:table; *//* border-spacing: 0; */">
             <tbody>
              <tr>
               <td width="588" valign="top" style="width:441.0pt;/* padding:0in 0in 0in 0in */">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;/* border-collapse:collapse; */padding-bottom:0!important;">
                 <tbody>
                  <tr>
                   <td valign="top"><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><img id="_x0000_i1026" src="https://myrecognition.int.hpe.com/hpenterprise/images/designtheme/hp2/1/m2e-hero.jpg" style="
    width: 100%;
">
                      <o:p></o:p></span></p></td>
                   <td width="0" valign="top" style="width:.3pt;padding:0in 0in 0in 0in"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;display:table;border-spacing: 0;height: 100px;">
             <tbody>
              <tr>
               <td width="274" style="width: 50%;background:#F2F2F1;padding:0in 6.0pt 0in 12.0pt;-moz-hyphens: auto;-webkit-hyphens: auto;border-collapse:collapse!important;hyphens: auto;word-wrap: break-word;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;padding-bottom:0!important">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in">
                    <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                     <tbody>
                      <tr>
                       <td width="40%" valign="top" style="width: 40%;padding:0in 7.5pt 0in 7.5pt;"><p class="MsoNormal" align="center" style="text-align:center"><span style="font-size: 30px;font-family:&quot;Arial&quot;,sans-serif;color:black;display: block;margin-top: 40px;"><%=ch.getPoint() %>
                          <o:p></o:p></span></p></td>
                       <td width="60%" valign="top" style="width: 60.0%;-moz-hyphens: auto;border-collapse:collapse!important;"><p class="MsoNormal" style="line-height:14.0pt;"><strong><span style="font-size: 22px;font-family:&quot;Arial&quot;,sans-serif;color:black;display: block;">Points</span></strong><span style="font-size: 1px;font-family:&quot;Arial&quot;,sans-serif;color:black;display: block;line-height: 15px;"><br>have been deposited into your account for immediate use
                          <o:p></o:p></span></p></td>
                      </tr>
                     </tbody>
                    </table></td>
                  </tr>
                 </tbody>
                </table></td>
               <td width="274" style="width: 50%;background:#464646;padding:0in 12.0pt 0in 6.0pt;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><a href="https://login.ext.hpe.com/idp/startSSO.ping?PartnerSpId=hpe_biw_sp"><b><span style="text-decoration:none"><img border="0" id="_x0000_i1027" src="<%=ch.getGiftImg() %>" style="
    width: 80%;
"></span></b></a>
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
            <p style="margin: 20px;line-height:14.0pt;"><strong><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Congratulations, <%=ch.getTo() %>!</span></strong><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">
              <o:p></o:p></span></p><p style="margin: 20px;line-height:14.0pt;"><span style="font-size:13px;font-family:&quot;Arial&quot;,sans-serif;color:black"><%=ch.getFrom() %> recognized you in the Manager-to-Employee FY17 Program for the value M2E: <%=ch.getType() %>.
              <o:p></o:p></span></p>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;display:table;border-spacing: 0;">
             <tbody>
              <tr>
               <td width="588" valign="top" style="width: 100%;/* padding:0in 0in 15.0pt 0in; */-moz-hyphens: auto;/* border-collapse:collapse!important; *//* word-wrap: break-word; */">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;/* border-collapse:collapse; *//* border-spacing: 0; */">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in;width: 100%;">
                    <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                     <tbody>
                      <tr>
                       <td width="100%" valign="top" style="width:100.0%;border:none;border-top:solid #A6A6A6 1.0pt;padding:0in 0in 0in 0in"></td>
                      </tr>
                     </tbody>
                    </table></td>
                   <td width="0" style="width:10%;/* padding:0in 0in 0in 0in */"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table><p style="margin: 10px;line-height:14.0pt;"><span style="font-size: 15px;font-family:&quot;Arial&quot;,sans-serif;color:black;">Below shows the impact you made to HPE:
              <o:p></o:p></span></p>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;display:table;border-spacing: 0">
             <tbody>
              <tr>
               <td width="0" style="width: 10%;padding:0in 0in 15.0pt 0in;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;padding-right:10px!important;">
                 <tbody>
                  <tr>
                   <td valign="top" style="text-align: left;padding:0in 0in 0in 15.0pt;"><p class="MsoNormal" style="line-height: 1px;"><span style="font-size: 1PX;font-family:&quot;Arial&quot;,sans-serif;color:black;"><img border="0" id="_x0000_i1028" src="https://myrecognition.int.hpe.com/hpenterprise/images/designtheme/hp2/1/lquote.png" style="
    width: 110%;
">
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
               <td width="193" style="width:145.0pt;padding:0in 0in 15.0pt 0in">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in"><p class="font-size-16" style="margin:0in;margin-bottom:.0001pt;line-height:14.0pt;margin-bottom:0!important"><span style="font-size: 14px;font-family:&quot;Arial&quot;,sans-serif;color:black;display: block;margin: 10px;margin-left: 15px;">Thanks <%=ch.getTo() %> for <%=ch.getComments() %>.
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
               <td width="0" style="width: 8%;padding:0in 0in 15.0pt 0in;">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><img border="0" id="_x0000_i1029" src="https://myrecognition.int.hpe.com/hpenterprise/images/designtheme/hp2/1/rquote.png" style="
    width: 60%;
">
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table><p style="margin: 10px;margin-bottom: 20px;line-height:14.0pt;"><span style="font-size: 14px;font-family:&quot;Arial&quot;,sans-serif;color:black;">Thank you for putting HPE values into action! Please click the green box above to read the full message. A copy of this recognition was sent to your manager.
              <o:p></o:p></span></p>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;display:table;border-spacing: 0">
             <tbody>
              <tr>
               <td width="588" valign="top" style="width:441.0pt;padding:0in 0in 15.0pt 0in;-moz-hyphens: auto;-webkit-hyphens: auto;border-collapse:collapse!important;hyphens: auto;word-wrap: break-word">
                <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                 <tbody>
                  <tr>
                   <td valign="top" style="padding:0in 0in 0in 0in">
                    <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="100%" style="width:100.0%;border-collapse:collapse;border-spacing: 0">
                     <tbody>
                      <tr>
                       <td width="100%" valign="top" style="width:100.0%;border:none;border-top:solid #A6A6A6 1.0pt;padding:0in 0in 0in 0in"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;
                          <o:p></o:p></span></p></td>
                      </tr>
                     </tbody>
                    </table></td>
                   <td width="0" style="width:.3pt;padding:0in 0in 0in 0in"><p class="MsoNormal" style="line-height:14.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;
                      <o:p></o:p></span></p></td>
                  </tr>
                 </tbody>
                </table></td>
              </tr>
             </tbody>
            </table>
            
            
   <div>
   
   </div>
  
 

<div id="sign" style="position:absolute;top:500px;right:50px;"></div>
	<div id="footer">
		<span class="clientCopyRight"><nobr></nobr></span>
	</div>
	<script>
         jQuery.ajax({
     		type : "GET",
     		url : "../QueryClientMeta",
     		data : {},
     		cache : false,
     		success : function(data) {
     			var jsons = eval(data);
     			$('img.HpLogo').attr('src',jsons.clientLogo);
     			$('span.clientCopyRight').text('©'+jsons.clientCopyRight);
     		}
     	});
         </script>
</body></html>
