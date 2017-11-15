<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>语音播报</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	
  <link rel="stylesheet" type="text/css" href="../Jsp/JS/lesu/bootstrap.min.css" />
</head>
<body>
<style type="text/css">
body{background-color:#fff;text-align:center;padding-top:50px;}
#Result{border:3px solid #40AA53;margin:0 auto;text-align:center;width:100%;padding:50px 0;background:#efe;display:none;}
.sa {
    text-align: center;
	}
	.niput {
    width: 150px;
    height: 45px;
    margin: 5px;
    padding: 12px 12px;
    font-size: 19px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.numPanel{
font-size: 50px;
    color: red;
    height: 80px;
    text-align: center;
	font-family: shuxieti;
}

</style>
<section class="white intro">

<div class="sa">
            <div id="ShowNumberPanel" class="numPanel">听数</div>
            <div>

                <input id="txtNumber1" type="text" class=" niput ">

                <input id="txtNumber2" type="text" class=" niput ">

                <input id="txtNumber3" type="text" class=" niput ">

                <input id="txtNumber4" type="text" class=" niput ">

            </div>
            <div>

                <input id="txtNumber5" type="text" class=" niput ">

                <input id="txtNumber6" type="text" class="niput ">

                <input id="txtNumber7" type="text" class=" niput ">

                <input id="txtNumber8" type="text" class="niput  ">


            </div>
			<div>

                <input id="txtNumber9" type="text" class=" niput ">

                <input id="txtNumber10" type="text" class="niput ">


            </div>
			<div>

                <input style="width:310px" placeholder="请输入以上数字总和" id="total" type="text" class="niput ">


            </div>
			<div style="text-align: center; margin: 15px;">
            <input id="start" type="button" class="btn btn-primary" value="开始练习">
            <input id="showAnswer" type="button" class="btn btn-success" value="显示答案" onclick="showAnswer()">
      
        </div>
        </div>
		</section>
<div id="Result" >
</div>
<script src="../Jsp/JS/lesu/jQuery-2.1.4.min.js"></script>
<script src="../Jsp/JS/lesu/jQuery.speech.js"></script>
<script>

	var text="开始,";
	function getNum(){
	text="开始,";
	var temp=0;
	for(var i=0;i<10;i++){
	temp=Math.round(Math.random()*100);
	text=text+temp+",";
	}
	text=text+"结束";
	$("#Result").text(text);
	console.log(text);
	return text;	
	}
	function showAnswer(){
	var array=text.split(",");
	$("#txtNumber1").val(array[1]);
	$("#txtNumber2").val(array[2]);
	$("#txtNumber3").val(array[3]);
	$("#txtNumber4").val(array[4]);
	$("#txtNumber5").val(array[5]);
	$("#txtNumber6").val(array[6]);
	$("#txtNumber7").val(array[7]);
	$("#txtNumber8").val(array[8]);
	$("#txtNumber9").val(array[9]);
	$("#txtNumber10").val(array[10]);
		var total=0;
	for(var i=1;i<array.length-1;i++){
	total+=parseInt(array[i]);}

	$("#total").val(total);
	
	}
	
	$('#Result').speech({
		"speech": true,
		"speed": 9,
		"bg": "./images/speech.png"
	});
</script>
</body>
</html>