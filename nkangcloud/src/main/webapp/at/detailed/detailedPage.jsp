<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
        <title>超炫jQuery测试答题功能</title>
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
            var init = {'questions': [{'question': 'jQuery是什么？', 'answers': ['JavaScript库', 'CSS库', 'PHP框架', '以上都不是'], 'correctAnswer': 1}, {'question': '找出不同类的一项?', 'answers': ['写字台', '沙发', '电视', '桌布'], 'correctAnswer': 3}, {'question': '国土面积最大的国家是：', 'answers': ['美国', '中国', '俄罗斯', '加拿大'], 'correctAnswer': 3}, {'question': '月亮距离地球多远？', 'answers': ['18万公里', '38万公里', '100万公里', '180万公里'], 'correctAnswer': 2}]};

            $(function() {
                $('#quiz_area').jquizzy({
                    questions: init.questions
                });
            });
        </script>
    </body>
</html>
