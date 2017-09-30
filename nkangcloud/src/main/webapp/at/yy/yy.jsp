﻿<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>预约功能</title>
<meta name="keywords" content="" />

<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta name="description" content="" />
<link rel="stylesheet" type="text/css" href="press-inner.css" />
<script type="text/javascript" src="jquery-1.7.min.js"></script>
<script src="easytabs.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="formCheck_cn.js"></script>
<script type="text/javascript" src="common.js"></script>
<script type="text/javascript" src="jscroll.js"></script>

<link rel="stylesheet" type="text/css" href="css.css" />
</head>
<script type="text/javascript">
$(function(){
	$("#complete").click(function(){
		var name=$("#user_name").val();
		var tel=$("#user_mobile").val();
		var addr=$("#user_email").val();
		var age=$("#user_age option:selected").val();
		var sex=$("#user_sex option:selected").val();
		var school=$("#user_xq option:selected").val();
		var subject=$("#user_km option:selected").val();
		$.ajax({
			type : "post",
			url : "../../addNewAppointment",
			data:{
				name:name,
				tel:tel,
				addr:addr,
				age:age,
				sex:sex,
				school:school,
				subject:subject
			},
			cache : false,
			success : function(data) {
			if(data=='ok'){
				alert("预约成功");
				$(".btn_submit").css({"background-position":"bottom center","cursor":"pointer"});
			}
			}
		})
	})

	});
</script>
<body style="height: 96%">
	<div class="content-asset" style="height: 100%">
	<center><img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EG8wW&amp;oid=00D90000000pkXM" height="51" width="100"></center>
		<div class="sign" style="height: 100%">
			<h2></h2>

			<div id="register" style="width: 60%; margin-left: 18%">
				<p></p>
				<h2>
					<img src="sign_txt.gif" alt="体验英语免费试听课程 开启孩子的英语旅程！">
				</h2>
				<!-- <form id="Form1" name="Form1" method="post"> -->
					<div class="input_bg0">
						<input name="user_name" value="*孩子姓名" type="text" id="user_name"
							class="sq">
					</div>
					<div class="input_bg0">
						<a href="javascript:;" class="btn_ques"></a>
						<div class="div_answ">
							<div class="div_answ_t"></div>
							<p id="answp">请留下您的电话, 以便我们的客服代表与您联系,
								也便于您获取我们的活动及优惠讯息短信。我们确保不会将您的信息透露给及其成员公司以外的任何第三方。</p>
							<div class="div_answ_b"></div>
						</div>
						<input name="user_mobile" value="*手机号码" type="text"
							id="user_mobile" class="sq">
					</div>
					<div class="input_bg0">
						<a href="javascript:;" class="btn_ques"></a>
						<div id="answ" class="div_answ">
							<div class="div_answ_t"></div>
							<p id="answp">只需正确填写您的家庭住址,我们确保不会将您的信息透露给及其成员公司以外的任何第三方。</p>
							<div class="div_answ_b"></div>
						</div>
						<input name="user_email" value="*家庭住址" type="text" id="user_email"
							class="sq">
					</div>
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td><div class="input_bg1">
										<select name="user_age" id="user_age">
											<option value="" selected="selected">*孩子的年龄</option>
											<option value="0">0</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
										</select>
									</div></td>
								<td><div class="input_bg1">
										<select name="user_sex" id="user_sex">
											<!--user_birth_month-->
											<option value="0" selected="selected">*孩子的性别</option>
											<option value="男">男</option>
											<option value="女">女</option>
										</select>
									</div></td>
							</tr>
						</tbody>
					</table>
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td><div class="input_bg1">
										<select name="user_xq" id="user_xq" onchange="change1(this);">
											<!--user_birth_month-->
											<option value="0" selected="selected">*选择校区</option>

											<option value="26">观音桥校区</option>

											<option value="25">李家沱校区</option>

											<option value="24">南坪校区</option>

										</select>
									</div></td>
								<td><div class="input_bg1" id="kemu" style="display: none;">
										<select name="user_km" id="user_km">
											<!--user_birth_month-->
										</select>
									</div></td>
							</tr>
						</tbody>
					</table>
					<div id="errorTxt"></div>
					<a href="javascript:;" class="btn_submit" id="complete"></a>
				<!-- </form> -->
				<script type="text/javascript" src="initAjax.js"></script>
			</div>

		</div>
	</div>
	<a style="position: absolute; bottom: 0px; z-index: 1000; width: 100%;">
		<img style="width: 100%" src="online_0912.png">
	</a>
</body>
</html>