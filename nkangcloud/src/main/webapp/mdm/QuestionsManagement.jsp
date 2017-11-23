<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nkang.kxmoment.baseobject.AbacusQuizPool" %>
 <%
AbacusQuizPool aqp = (AbacusQuizPool)request.getAttribute("aq");
%>
<%-- <% ArrayList<AbacusQuizPool> list = request.getAttribute("aq");%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-看算练习-题库管理</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
	<link href="../Jsp/JS/leshu/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<%@ include file="tiku.jsp" %>
</head>
<body>
	<center>
		<img
			src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EG8wW&amp;oid=00D90000000pkXM"
			height="51" width="100">
	</center>
	<div>题库管理</div>

 <form name="Form" method="get" action="../AbacusQuiz/getAbacusQuizPoolBycategory1">
 <p> category:	<input type="text" name="category"></p>
  	
  	
  	 <input type="submit" value="显示" />
  </form>
------------------------------------------------------------------------------------------
  <form name="Form" method="post" action="../AbacusQuiz/getAllAbacusQuizPool">
  	<input type="text" name="category">
  	<p>First name: <input type="text" name="fname" /></p>
  	
  	 <input type="submit" value="显示所有题" />
  </form>
  
  
  =============================================
  
  <p>
  time:${requestScope.time}
 <br/>
  category :<%=aqp.category %>
  <br>
 tag :<%=aqp.tag.toString() %>
  <br>
   checkpoint :<%=aqp.checkpoint.toString() %>
  <br>
   question :<%=aqp.question %>
  <br>
   answer :<%=aqp.answer %>
  <br>
  grade:<%=aqp.grade %>
  --------------------------------------------------
  <br>
  <c:forEach items="${sessionScope.list}" var="aqp">  
    <tr>
<td>${aqp.category }</td>
<td>${aqp.tag}</td>
<td>${aqp.checkpoint}</td>
<td>${aqp.question}</td>
<td>${aqp.answer}</td>
<td>${aqp.grade}</td>
</tr>  
<br>
</c:forEach>
</body>
</html>