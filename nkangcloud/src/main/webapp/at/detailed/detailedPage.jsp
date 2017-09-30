<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="com.nkang.kxmoment.baseobject.Quiz"%>
<%@ page import="java.util.*"%>
<%
List<Quiz> tfquizs=MongoDBBasic.getQuizsByType("TrueOrFalse");
List<Quiz> scquizs=MongoDBBasic.getQuizsByType("SingleChoice");
List<Quiz> mcquizs=MongoDBBasic.getQuizsByType("MultipleChoice");
/* List<Quiz> mcquizs=MongoDBBasic.getQuizsByType(""); */
%>
<!DOCTYPE html>
<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
        <title>测试答题功能</title>
        <meta name="keywords" content="jQuery答题,测试答题" />
		
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta name="description" content="今天我给大家分享一个炫酷的测试答题功能，你可以放在自己的网站来做在线调查或在线测试。" />
    <link rel="stylesheet" type="text/css" href="styles.css" />
		
        <link rel="stylesheet" type="text/css" href="page.css" />
        <style type="text/css">
		body{padding:0px;
		margin:0px;}
		html{background: #f5f7fa;}
		.content{    word-wrap: break-word;
    margin: 7px 1px 7px 51px;
    display: block;}
		.num{position: absolute;
    top: 50%;
    margin-top: -18px;
    width: 33px;
    height: 33px;
    line-height: 33px;
    float: left;
    vertical-align: top;
    text-align: center;
    font-size: 18px;
    background: #fff;
    border: 1px solid #45c5ce;
    border-radius: 20px;
    cursor: pointer;}
	.num.selected{
	    background: #45c5ce;
    color: #fff;}
            .tip{width:120px; padding:10px; border:1px solid #ffecb0; background-color:#fffee0; position:absolute; margin-left:750px; top:124px;}
            #nav{width:720px; height:42px; position:absolute; margin-left:20px; border:1px solid #d3d3d3; background:#f7f7f7;-moz-border-radius:2px; -webkit-border-radius:2px; border-radius:2px; }
            .shadow{-moz-box-shadow:1px 1px 2px rgba(0,0,0,.2); -webkit-box-shadow:1px 1px 2px rgba(0,0,0,.2); box-shadow:1px 1px 2px rgba(0,0,0,.2);}
            #nav li{float:left; height:42px; line-height:42px; padding:0 10px; border-right:1px solid #d3d3d3; font-size:14px; font-weight:bold}
            #nav li.current{background:#f1f1f1; border-top:1px solid #f60}
            #nav li a{text-decoration:none;}
            #nav li.current a{color:#333}
            #nav li a:hover{color:#f30}
			span a{    text-decoration:none;color:white;}
        </style>
    </head>
    <body>
	<div style="
    width: 100%;
    height: 50px;
    background: #2f3a4a;
">
<span id="submitInadvance" style="
    position: absolute;
    top: 15px;
    right: 100px;
    color: white;
    font-family: &quot;Microsoft yahei&quot;,sans-serif;
">提前交卷</span>
<span style="
    position: absolute;
    top: 15px;
    right: 20px;
    color: white;
    font-family: &quot;Microsoft yahei&quot;,sans-serif;
"><a href="detailedPage.jsp">重新测试</a></span>
</div>
            <div class="demo">
                <div id='quiz_area'></div>
            </div>  
        <script type="text/javascript" src="jquery.js"></script>
        <script src="quiz.js"></script>
        <script>
            var init = {'questions': 
            	[
        	   	 <% for(int i=0;i<tfquizs.size();i++){%>
            	 <% if(i!=tfquizs.size()-1){%>
            	 {'question': '<%=tfquizs.get(i).getQuestion() %>', 'answers': ['<%=tfquizs.get(i).getAnswers().get(0)%>', '<%=tfquizs.get(i).getAnswers().get(1)%>'], 'correctAnswer': '<%=tfquizs.get(i).getCorrectAnswers() %>','type':'<%=tfquizs.get(i).getType() %>','score':'<%=tfquizs.get(i).getScore() %>','caseStudy':'<%=tfquizs.get(i).getCaseStudy() %>'}, 
            	 <%}else{%>
            	 <%if(scquizs.size()==0&&mcquizs.size()==0){%>
            	 {'question': '<%=tfquizs.get(i).getQuestion() %>', 'answers': ['<%=tfquizs.get(i).getAnswers().get(0)%>', '<%=tfquizs.get(i).getAnswers().get(1)%>'], 'correctAnswer': '<%=tfquizs.get(i).getCorrectAnswers() %>','type':'<%=tfquizs.get(i).getType() %>','score':'<%=tfquizs.get(i).getScore() %>','caseStudy':'<%=tfquizs.get(i).getCaseStudy() %>'}
            	 <%}else{%>
            	 {'question': '<%=tfquizs.get(i).getQuestion() %>', 'answers': ['<%=tfquizs.get(i).getAnswers().get(0)%>', '<%=tfquizs.get(i).getAnswers().get(1)%>'], 'correctAnswer': '<%=tfquizs.get(i).getCorrectAnswers() %>','type':'<%=tfquizs.get(i).getType() %>','score':'<%=tfquizs.get(i).getScore() %>','caseStudy':'<%=tfquizs.get(i).getCaseStudy() %>'},
            	 <%}%>
            	 <%}%>
            	 <%}%>           	 
            	   	 <% for(int j=0;j<scquizs.size();j++){%>
            	 <% if(j!=scquizs.size()-1){%>
            	 {'question': '<%=scquizs.get(j).getQuestion() %>', 'answers': ['<%=scquizs.get(j).getAnswers().get(0)%>', '<%=scquizs.get(j).getAnswers().get(1)%>', '<%=scquizs.get(j).getAnswers().get(2)%>', '<%=scquizs.get(j).getAnswers().get(3)%>'], 'correctAnswer': '<%=scquizs.get(j).getCorrectAnswers() %>','type':'<%=scquizs.get(j).getType() %>','score':'<%=scquizs.get(j).getScore() %>','caseStudy':'<%=scquizs.get(j).getCaseStudy() %>'}, 
            	 <%}else{%>
            	 <%if(mcquizs.size()==0){%>
            	 {'question': '<%=scquizs.get(j).getQuestion() %>', 'answers': ['<%=scquizs.get(j).getAnswers().get(0)%>', '<%=scquizs.get(j).getAnswers().get(1)%>', '<%=scquizs.get(j).getAnswers().get(2)%>', '<%=scquizs.get(j).getAnswers().get(3)%>'], 'correctAnswer': '<%=scquizs.get(j).getCorrectAnswers() %>','type':'<%=scquizs.get(j).getType() %>','score':'<%=scquizs.get(j).getScore() %>','caseStudy':'<%=scquizs.get(j).getCaseStudy() %>'}
            	 <%}else{%>
            	 {'question': '<%=scquizs.get(j).getQuestion() %>', 'answers': ['<%=scquizs.get(j).getAnswers().get(0)%>', '<%=scquizs.get(j).getAnswers().get(1)%>', '<%=scquizs.get(j).getAnswers().get(2)%>', '<%=scquizs.get(j).getAnswers().get(3)%>'], 'correctAnswer': '<%=scquizs.get(j).getCorrectAnswers() %>','type':'<%=scquizs.get(j).getType() %>','score':'<%=scquizs.get(j).getScore() %>','caseStudy':'<%=scquizs.get(j).getCaseStudy() %>'},
            	 <%}%>
            	 <%}%>
            	 <%}%>
            	 
        	   	 <% for(int q=0;q<mcquizs.size();q++){%>
            	 <% if(q!=mcquizs.size()-1){%>
            	 {'question': '<%=mcquizs.get(q).getQuestion() %>', 'answers': ['<%=mcquizs.get(q).getAnswers().get(0)%>', '<%=mcquizs.get(q).getAnswers().get(1)%>', '<%=mcquizs.get(q).getAnswers().get(2)%>', '<%=mcquizs.get(q).getAnswers().get(3)%>','<%=mcquizs.get(q).getAnswers().get(4)%>'], 'correctAnswer': '<%=mcquizs.get(q).getCorrectAnswers() %>','type':'<%=mcquizs.get(q).getType() %>','score':'<%=mcquizs.get(q).getScore() %>','caseStudy':'<%=mcquizs.get(q).getCaseStudy() %>'}, 
            	 <%}else{%>
            	 {'question': '<%=mcquizs.get(q).getQuestion() %>', 'answers': ['<%=mcquizs.get(q).getAnswers().get(0)%>', '<%=mcquizs.get(q).getAnswers().get(1)%>', '<%=mcquizs.get(q).getAnswers().get(2)%>', '<%=mcquizs.get(q).getAnswers().get(3)%>','<%=mcquizs.get(q).getAnswers().get(4)%>'], 'correctAnswer': '<%=mcquizs.get(q).getCorrectAnswers() %>','type':'<%=mcquizs.get(q).getType() %>','score':'<%=mcquizs.get(q).getScore() %>','caseStudy':'<%=mcquizs.get(q).getCaseStudy() %>'}
            	 <%}%>
            	 <%}%>            	 
            	 ]};

            $(function() {
                $('#quiz_area').jquizzy({
                    questions: init.questions
                });
            });
        </script>
    </body>
</html>
