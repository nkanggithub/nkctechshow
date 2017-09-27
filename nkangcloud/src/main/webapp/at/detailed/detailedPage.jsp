<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
            var init = {'questions': [{'question': '工程项目质量安全责任第一责任人是？', 'answers': ['企业负责人', '专职安全生产管理人员', '项目经理', '项目技术负责人'], 'correctAnswer': 1}, {'question': '梁纵向受力钢筋的常用直径为?', 'answers': ['12～25mm', '12～20mm', '10～25mm', '10～20mm'], 'correctAnswer': 3}, {'question': '利用标准专砌墙，一砖半墙的墙厚为（）mm?', 'answers': ['120', '240', '360', '370'], 'correctAnswer': 3}, {'question': '力偶对物体的作用效应是？', 'answers': ['使物体水平方向移动', '使物体任意方向移动，又使物体转动', '只有转动效应', '使物体竖直方向移动'], 'correctAnswer': 2}, {'question': '不属于钢结构连接方式的是？', 'answers': ['射钉连接', '焊接连接', '铆钉连接', '螺栓连接'], 'correctAnswer': 2}, {'question': '构件抵抗变形的能力是？', 'answers': ['刚度', '稳定性', '强度', '抗剪力'], 'correctAnswer': 2}, {'question': '下列不属于楼梯详图内容的是？', 'answers': ['楼梯平面图', '楼梯平台详图', '楼梯节点详图', '楼梯剖面图'], 'correctAnswer': 2}, {'question': '下列不属于设计总说明内容的是？', 'answers': ['施工图设计依据', '室内外的用料和施工要求说明', '建筑面积', '结构施工图'], 'correctAnswer': 2}]};

            $(function() {
                $('#quiz_area').jquizzy({
                    questions: init.questions
                });
            });
        </script>
    </body>
</html>
