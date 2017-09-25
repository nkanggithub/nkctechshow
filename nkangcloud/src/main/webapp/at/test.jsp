﻿<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!-- 公共的js，css -->
        <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit"/>
		<meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <!-- 开发标准页面时引用此文件，提供了基本的js及css -->
    <link rel="stylesheet" href="global-wap.css">
    <script src="global-wap.js"></script>
    <script type="text/javascript">
      seajs.config({
          base: '//images.koolearn.com/shark/',
          importBase: '//images.koolearn.com/shark/',
          comboExcludes: function(uri) {
              return true
          }
      });
    </script>
    <!-- 公共部分结束 -->
    <title>医考在线模拟考场_医师资格|执业药师|护理|药学|主治医师在线模拟测评-新东方在线</title>
    <meta name="keywords" content="医考在线模拟考场,医师资格测评,执业药师测评,护理职称测评,药学职称测评" />
    <meta name="description" content="新东方在线医学推出手机版医考在线模拟考场，为广大医学考生提供执业医师资格测评、执业药师测评、护士资格测评、护理职称测评、药学职称测评，以及主治医师测评，精品习题手机随刷随练，助考生医考通关。" />
    <link rel="stylesheet" href="style.css" />
    <script type="text/javascript" src="wap-resize.js"></script>
    <script type="text/javascript" src="lodash.js"></script>
    <script type="text/javascript" src="vue.js"></script>
    <script>
        document.domain = 'koolearn.com';
    </script>
</head>
<body>
<div class="i-base-wrap">
    <div id="ji-header" class="i-header">
        <div class="fl">
            <a class="logo" target="_blank"></a>
        </div>
        <div class="i-divider"></div>
        <a class="i_name fl" href="#">医学</a>

        <div class="fr">
            <div id="i-header-info" class="header-rc i-head-login">
                <a class="user i-head-login"><i></i></a>
            </div>
        </div>
    </div>
</div>
<div id="content_data" style="display: none">
<div class="item">
        <p class="item_name">医师资格</p>
        <ul class="sub_item">
            <li paper-id="53305">临床执业</li>
            <li paper-id="53306">临床助理</li>
            <li paper-id="53307">中医执业</li>
            <li paper-id="53308">中医助理</li>
            <li paper-id="53309">中西医执业</li>
            <li paper-id="53311">中西医助理</li>
            <li paper-id="53312">口腔执业</li>
			<li paper-id="53313">口腔助理</li>
        </ul>
        <div class="kb" title="医师资格选课中心" more="http://un.koolearn.com/alliance/clickword?userid=ff80808138fed9e801390002fcd60001&kid=ff80808153735ddb015373bc3cc2057b&url=http://m.koolearn.com/ke/yishi/
">
            <ul class="kb_item" title="笔试-VIP旗舰协议班" >
                <li>
                    <span class="class-name">临床执业医师</span>
                    <span class="class-time">490</span>
                    <span class="class-price">1980</span>
                    <span class="class-src">http://m.koolearn.com/product/47026_1.html</span>
                </li>
                <li>
                    <span class="class-name">临床助理医师</span>
                    <span class="class-time">437</span>
                    <span class="class-price">1980</span>
                    <span class="class-src">http://m.koolearn.com/product/47027_1.html</span>
                </li>
				<li>
                    <span class="class-name">中医执业医师</span>
                    <span class="class-time">384</span>
                    <span class="class-price">1980</span>
                    <span class="class-src">http://m.koolearn.com/product/47052_1.html</span>
                </li>
				<li>
                    <span class="class-name">中医助理医师</span>
                    <span class="class-time">357</span>
                    <span class="class-price">1980</span>
                    <span class="class-src">http://m.koolearn.com/product/47030_1.html</span>
                </li>
				<li>
                    <span class="class-name">中西医执业医师</span>
                    <span class="class-time">403</span>
                    <span class="class-price">1980</span>
                    <span class="class-src">http://m.koolearn.com/product/47028_1.html</span>
                </li>
				<li>
                    <span class="class-name">中西医助理医师</span>
                    <span class="class-time">370</span>
                    <span class="class-price">1980</span>
                    <span class="class-src">http://m.koolearn.com/product/47031_1.html</span>
                </li>
				<li>
                    <span class="class-name">口腔执业医师</span>
                    <span class="class-time">112</span>
                    <span class="class-price">980</span>
                    <span class="class-src">http://m.koolearn.com/product/47036_1.html</span>
                </li>
				<li>
                    <span class="class-name">口腔助理医师</span>
                    <span class="class-time">97</span>
                    <span class="class-price">980</span>
                    <span class="class-src">http://m.koolearn.com/product/47045_1.html</span>
                </li>
            </ul>
            <ul class="kb_item" title="实践技能-特训通关班" >
                <li>
                    <span class="class-name">临床执业医师</span>
                    <span class="class-time">26</span>
                    <span class="class-price">360</span>
                    <span class="class-src">http://www.koolearn.com/product/47097_1.html</span>
                </li>
                <li>
                    <span class="class-name">临床助理医师</span>
                    <span class="class-time">25</span>
                    <span class="class-price">360</span>
                    <span class="class-src">http://m.koolearn.com/product/47098_1.html</span>
                </li>
                <li>
                    <span class="class-name">中医执业医师</span>
                    <span class="class-time">34</span>
                    <span class="class-price">360</span>
                    <span class="class-src">http://m.koolearn.com/product/47094_1.html</span>
                </li>
				<li>
                    <span class="class-name">中医助理医师</span>
                    <span class="class-time">34</span>
                    <span class="class-price">360</span>
                    <span class="class-src">http://m.koolearn.com/product/47096_1.html</span>
                </li>
				<li>
                    <span class="class-name">中西医执业医师</span>
                    <span class="class-time">34</span>
                    <span class="class-price">360</span>
                    <span class="class-src">http://m.koolearn.com/product/47093_1.html</span>
                </li>
				<li>
                    <span class="class-name">中西医助理医师</span>
                    <span class="class-time">34</span>
                    <span class="class-price">360</span>
                    <span class="class-src">http://m.koolearn.com/product/47093_1.html</span>
                </li>
				<li>
                    <span class="class-name">口腔执业医师</span>
                    <span class="class-time">20</span>
                    <span class="class-price">300</span>
                    <span class="class-src">http://m.koolearn.com/product/47099_1.html</span>
                </li>
				<li>
                    <span class="class-name">口腔助理助理</span>
                    <span class="class-time">20</span>
                    <span class="class-price">300</span>
                    <span class="class-src">http://m.koolearn.com/product/47100_1.html</span>
                </li>
            </ul>
        </div>
    </div>
	<div class="item">
        <p class="item_name">执业药师</p>
        <ul class="sub_item">
            <li paper-id="53336">西药一</li>
            <li paper-id="53337">西药二</li>
            <li paper-id="53338">西药综</li>
            <li paper-id="53333">中药一</li>
            <li paper-id="53334">中药二</li>
            <li paper-id="53335">中药综</li>
            <li paper-id="53339">药事管理法规</li>
        </ul>
        <div class="kb" title="执业药师选课中心" more="http://un.koolearn.com/alliance/clickword?userid=ff80808138fed9e801390002fcd60001&kid=ff80808153735ddb015373bc3cc2057b&url=http://m.koolearn.com/ke/zhiyeyaoshi/
">
            <ul class="kb_item" title="执业西药师课程" >
                <li>
                    <span class="class-name">全科VIP协议通关班</span>
                    <span class="class-time">146</span>
                    <span class="class-price">1680</span>
                    <span class="class-src">http://m.koolearn.com/product/47149_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">146</span>
                    <span class="class-price">1480</span>
                    <span class="class-src">http://m.koolearn.com/product/47150_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科夯实基础班</span>
                    <span class="class-time">73</span>
                    <span class="class-price">1200</span>
                    <span class="class-src">http://m.koolearn.com/product/47151_1.html</span>
                </li>
				<li>
                    <span class="class-name">考前冲刺特训班</span>
                    <span class="class-time">40</span>
                    <span class="class-price">900</span>
                    <span class="class-src">http://m.koolearn.com/product/47152_1.html</span>
                </li>
            </ul>
            <ul class="kb_item" title="执业中药师课程" >
                <li>
                    <span class="class-name">全科VIP协议通关班</span>
                    <span class="class-time">167</span>
                    <span class="class-price">1680</span>
                    <span class="class-src">http://m.koolearn.com/product/47145_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">167</span>
                    <span class="class-price">1480</span>
                    <span class="class-src">http://m.koolearn.com/product/47146_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科夯实基础班</span>
                    <span class="class-time">99</span>
                    <span class="class-price">1200</span>
                    <span class="class-src">http://m.koolearn.com/product/47147_1.html</span>
                </li>
				<li>
                    <span class="class-name">考前冲刺特训班</span>
                    <span class="class-time">38</span>
                    <span class="class-price">900</span>
                    <span class="class-src">http://m.koolearn.com/product/47148_1.html</span>
                </li>
            </ul>
        </div>
    </div>
	<div class="item">
        <p class="item_name">护理职称</p>
        <ul class="sub_item">
            <li paper-id="53318">护士资格</li>
            <li paper-id="53322">初级护师</li>
            <li paper-id="53326">主管护师</li>
        </ul>
        <div class="kb" title="护理职称选课中心" more="http://m.koolearn.com/171-0-10-0-0-0/">
            <ul class="kb_item" title="护士资格课程" >
                <li>
                    <span class="class-name">全程通关旗舰协议班</span>
                    <span class="class-time">105</span>
                    <span class="class-price">1100</span>
                    <span class="class-src">http://m.koolearn.com/product/45760_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">108</span>
                    <span class="class-price">550</span>
                    <span class="class-src">http://m.koolearn.com/product/45762_1.html</span>
                </li>
                <li>
                    <span class="class-name">精讲精炼班</span>
                    <span class="class-time">83</span>
                    <span class="class-price">350</span>
                    <span class="class-src">http://m.koolearn.com/product/45765_1.html</span>
                </li>
            </ul>
            <ul class="kb_item" title="初级护师课程" >
                <li>
                    <span class="class-name">全程通关旗舰协议班</span>
                    <span class="class-time">126</span>
                    <span class="class-price">750</span>
                    <span class="class-src">http://m.koolearn.com/product/45766_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">126</span>
                    <span class="class-price">600</span>
                    <span class="class-src">http://m.koolearn.com/product/45768_1.html</span>
                </li>
                <li>
                    <span class="class-name">精讲精炼班</span>
                    <span class="class-time">87</span>
                    <span class="class-price">400</span>
                    <span class="class-src">http://m.koolearn.com/product/45771_1.html</span>
                </li>
            </ul>
			<ul class="kb_item" title="主管护师课程" >
                <li>
                    <span class="class-name">全程通关旗舰协议班</span>
                    <span class="class-time">280</span>
                    <span class="class-price">800</span>
                    <span class="class-src">http://m.koolearn.com/product/45781_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">280</span>
                    <span class="class-price">650</span>
                    <span class="class-src">http://m.koolearn.com/product/45782_1.html</span>
                </li>
                <li>
                    <span class="class-name">精讲精炼班</span>
                    <span class="class-time">184</span>
                    <span class="class-price">450</span>
                    <span class="class-src">http://m.koolearn.com/product/45783_1.html</span>
                </li>
            </ul>
        </div>
    </div>
	<div class="item">
        <p class="item_name">药学职称</p>
        <ul class="sub_item">
            <li paper-id="53327">初级药士</li>
            <li paper-id="53328">初级药师</li>
            <li paper-id="53329">主管药师</li>
            <li paper-id="53330">初级中药士</li>
            <li paper-id="53331">初级中药师</li>
            <li paper-id="53332">主管中药师</li>
        </ul>
        <div class="kb" title="药学职称选课中心" more="http://m.koolearn.com/124-0-10-0-0-0/">
            <ul class="kb_item" title="初级药士课程" >
                <li>
                    <span class="class-name">全科全程通关VIP协议班</span>
                    <span class="class-time">77</span>
                    <span class="class-price">750</span>
                    <span class="class-src">http://m.koolearn.com/product/45846_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">74</span>
                    <span class="class-price">600</span>
                    <span class="class-src">http://m.koolearn.com/product/45849_1.html</span>
                </li>
            </ul>
            <ul class="kb_item" title="初级药师课程" >
                <li>
                    <span class="class-name">全科全程通关VIP协议班</span>
                    <span class="class-time">91</span>
                    <span class="class-price">800</span>
                    <span class="class-src">http://m.koolearn.com/product/45831_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">89</span>
                    <span class="class-price">650</span>
                    <span class="class-src">http://m.koolearn.com/product/45835_1.html</span>
                </li>
            </ul>
			           <ul class="kb_item" title="主管药师课程" >
                <li>
                    <span class="class-name">全程通关VIP协议班</span>
                    <span class="class-time">82</span>
                    <span class="class-price">850</span>
                    <span class="class-src">http://m.koolearn.com/product/45855_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">80</span>
                    <span class="class-price">700</span>
                    <span class="class-src">http://m.koolearn.com/product/45858_1.html</span>
                </li>
            </ul>
			           <ul class="kb_item" title="初级中药士课程" >
                <li>
                    <span class="class-name">全程通关VIP协议班</span>
                    <span class="class-time">76</span>
                    <span class="class-price">750</span>
                    <span class="class-src">http://m.koolearn.com/product/45879_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">74</span>
                    <span class="class-price">600</span>
                    <span class="class-src">http://m.koolearn.com/product/45880_1.html</span>
                </li>
            </ul>
			           <ul class="kb_item" title="初级中药师课程" >
                <li>
                    <span class="class-name">全程通关VIP协议班</span>
                    <span class="class-time">108</span>
                    <span class="class-price">800</span>
                    <span class="class-src">http://m.koolearn.com/product/45886_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">102</span>
                    <span class="class-price">650</span>
                    <span class="class-src">http://m.koolearn.com/product/45887_1.html</span>
                </li>
            </ul>
			           <ul class="kb_item" title="主管中药师课程" >
                <li>
                    <span class="class-name">全程通关VIP协议班</span>
                    <span class="class-time">128</span>
                    <span class="class-price">850</span>
                    <span class="class-src">http://m.koolearn.com/product/45892_1.html</span>
                </li>
                <li>
                    <span class="class-name">全科全程通关班</span>
                    <span class="class-time">126</span>
                    <span class="class-price">700</span>
                    <span class="class-src">http://m.koolearn.com/product/45893_1.html</span>
                </li>
            </ul>
        </div>
    </div>
	<div class="item">
        <p class="item_name">主治医师</p>
        <ul class="sub_item">
            <li paper-id="53550">内科主治</li>
            <li paper-id="53549">外科主治</li>
        </ul>
        <div class="kb" title="主治医师选课中心" more="http://m.koolearn.com/124-0-10-0-0-0/">
            <ul class="kb_item" title="内科主治医师课程" >
                <li>
                    <span class="class-name">高频考题解析班(套餐)</span>
                    <span class="class-time">19</span>
                    <span class="class-price">400</span>
                    <span class="class-src">http://m.koolearn.com/product/46578_1.html</span>
                </li>
                <li>
                    <span class="class-name">单科-基础知识</span>
                    <span class="class-time">4</span>
                    <span class="class-price">100</span>
                    <span class="class-src">http://m.koolearn.com/product/46577_1.html</span>
                </li>
                <li>
                    <span class="class-name">单科-相关/专业知识</span>
                    <span class="class-time">12</span>
                    <span class="class-price">200</span>
                    <span class="class-src">http://m.koolearn.com/product/46575_1.html</span>
                </li>
				<li>
                    <span class="class-name">单科-专业实践能力</span>
                    <span class="class-time">3</span>
                    <span class="class-price">100</span>
                    <span class="class-src">http://m.koolearn.com/product/46574_1.html</span>
                </li>
            </ul>
            <ul class="kb_item" title="外科主治医师课程" >
                  <li>
                    <span class="class-name">高频考题解析班(套餐)</span>
                    <span class="class-time">16</span>
                    <span class="class-price">400</span>
                    <span class="class-src">http://m.koolearn.com/product/46584_1.html</span>
                </li>
                <li>
                    <span class="class-name">单科-基础知识</span>
                    <span class="class-time">7</span>
                    <span class="class-price">100</span>
                    <span class="class-src">http://m.koolearn.com/product/46582_1.html</span>
                </li>
                <li>
                    <span class="class-name">单科-相关/专业知识</span>
                    <span class="class-time">5</span>
                    <span class="class-price">200</span>
                    <span class="class-src">http://m.koolearn.com/product/46581_1.html</span>
                </li>
				<li>
                    <span class="class-name">单科-专业实践能力</span>
                    <span class="class-time">4</span>
                    <span class="class-price">100</span>
                    <span class="class-src">http://m.koolearn.com/product/46579_1.html</span>
                </li>
            </ul>
        </div>
    </div>
</div><div class="head">
    <img src="head.jpg" />
</div>
<div class="content" id="app" v-cloak>
    <div class="content-nav">
        <ul class="tab fc">
            <li v-for="(data,index) in contentData" :class="tabIndex===index?'bg':''" @click="tabIndex=index">{{data.tabName}}</li>
        </ul>
        <div class="content-nav__lesson" v-for="(data,index) in contentData" :class="tabIndex===index?'bg':''">
            <ul class="testList fc">
                <li class="test" v-for="(list,i) in data.testList">
                    <a target="_blank" :href="'http://kaoshi.koolearn.com/wca/gt/'+data.testListId[i]">
                        <h4>{{list}}</h4>
                        <span>我要测评</span>
                    </a>

                </li>
            </ul>
            <h3>{{data.kbName}}<a :href="data.kbMore" target="_blank">更多</a></h3>
            <table v-for="kbIt in data.kbItem">
                <colgroup>
                    <col width="40%">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                </colgroup>
                <thead>
                    <th>{{kbIt.classTitle}}</th>
                    <th>课时</th>
                    <th>价格</th>
                    <th>购买</th>
                </thead>
                <tbody>
                    <tr v-for="classItem in kbIt.classItem">
                        <td>{{classItem.className}}</td>
                        <td>{{classItem.classTime}}</td>
                        <td>￥{{classItem.classPrice}}</td>
                        <td><a class="buy" :href="classItem.classSrc">购买</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="m-footer">
    <h1>新东方在线</h1>
    <div class="tit2">
        <img src="h2.png" height="25" width="560">
    </div>
    <div class="main">
        <p class="intr">新东方在线（新东方网  839896.OC）是新东方教育科技集团(NYSE:EDU)旗下专业的在线教育公司，新东方在线网（koolearn.com）是国内首批专业在线教育网站之一。</p>
        <div class="logo">
            <div class="lg">
                <a href="http://m.koolearn.com/"><img src="logo1.png" height="81" width="158"></a>
            </div>
            <div class="lg">
                <img src="logo2.png" height="68" width="140">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="page.js"></script>
<script>
    seajs.use(['project/zt/2017/0420mnkcwap/js/page'], function(exports) {
        $(function() {
            exports.init();
        })
    })
</script>
<script src="header.js"></script>
<script type="text/javascript">
    (function(){
        seajs.use(['project/zt/2016/0530kyldywap/js/common/header/header'], function(init){
            init({
                //右侧登录菜单相关配置
                loginInfoUrl: '//i.koolearn.com/logininfo',
                login: {
                    loginUrl: "//login.koolearn.com/sso/m/toLogin.do",  //登录地址
                    quitUrl: "//login.koolearn.com/sso/logout.do",  //退出地址
                    userCenter: "javascript:;",  //个人中心
                    myCourse: "//study.koolearn.com?wp_f=w_menu",  //我的课程
                    myOrder: "//order.m.koolearn.com/m/user_order/index?wp_f=w_menu",  //我的订单
                    myDiscount: "//order.m.koolearn.com/m/coupon/index?wp_f=w_menu",  //我的优惠券
                    myLearnCard: "//order.m.koolearn.com/m/learning_card_account/index?wp_f=w_menu",  //我的学习卡账户
                    myCash: "//order.m.koolearn.com/m/cash_account/index?wp_f=w_menu"  //我的现金账户
                }
            });
        });
    })()
</script>
<script type="text/javascript" src="tongji_wap.js"></script>
<script type="text/javascript" src="GTM.js"></script>
</body>
</html>

<!-- 
	专题生成的时间:2017-07-11 12:07:10
	修改专题的人:sunzhengxin
	生成专题所用的模板:index_demo-2017-0420mnkcwap
-->