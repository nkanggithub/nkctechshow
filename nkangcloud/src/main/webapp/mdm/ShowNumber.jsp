<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>语音播报</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	
  <link rel="stylesheet" type="text/css" href="../Jsp/JS/leshu/bootstrap.min.css" />
</head>
<body>
<style type="text/css">
body{background-color:#fff;text-align:center;padding-top:50px;}
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
            <div id="ShowNumberPanel" class="numPanel">看数</div>
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
            <input id="start" type="button" class="btn btn-primary" value="开始练习" onclick="start()">
            <input id="showAnswer" type="button" class="btn btn-success" value="显示答案" onclick="showAnswer()">
      
        </div>
        </div>
		</section>
<script src="../Jsp/JS/jquery-1.8.0.js"></script>
<script>

var textToShow="";
        function GetRandomNum(Min, Max) {
            var Range = Max - Min;
            var Rand = Math.random();
            return (Min + Math.round(Rand * Range));
        }

        var numberModel = null;
        var numberLength = 0;
        var showTime = 0;
        var intervalTime = 0;
        var view = null;
        var nnto = null;
        var snto = null;
        function start() {
            view = $("#ShowNumberPanel");
            for (var i = 1; i <= 10; i++) {
                $("#txtNumber" + i).val("");
            }
			$("#total").val("");
            answer = new Array();
            currentShowCount = 0;
            if (nnto != null)
                clearTimeout(nnto);
            if (snto != null)
                clearTimeout(snto);

            view.text("准备");

            numberLength = parseInt($("#NumberLength").val());



            snto = setTimeout("ShowNumber()", 1000);

            numberModel = new Array();
            //fisrt
            var firstModel = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9);
            var firstNumber = new Array();
            for (var i = 0; i < 9; i++) {
                var index = GetRandomNum(0, firstModel.length - 1);
                firstNumber.push(firstModel[index]);
                firstModel.splice(index, 1);
            }
            firstNumber.push(GetRandomNum(1, 9));
            //model
            for (var i = 0; i < 10; i++) {
                numberModel[i] = new Array();
                var model = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
                var fisrtVal = firstNumber[i];
                numberModel[i][0] = fisrtVal;
                for (var j = 1; j < 10; j++) {

                    var index = GetRandomNum(0, model.length - 1);
                    var val = model[index];
                    if (fisrtVal == val) {
                        j--;
                        continue;
                    }
                    if (j == 0 && val == 0) {
                        j--;
                        continue;
                    }
                    numberModel[i][j] = val;
                    model.splice(index, 1);
                }

                var number = parseInt(numberModel[i].slice(0, numberLength).join(''));
                answer.push(number);

            }

        }
        var answer = null;
        var currentShowCount = 0;
		var num=null;
        function ShowNumber() {

            if (currentShowCount >= answer.length) {
                view.text("结束");
                return;
            }
			num=Math.round(Math.random()*100);
            view.text(num);
			textToShow=textToShow+num+",";
            nnto = setTimeout("hideNumber()", 500);
            snto = setTimeout("ShowNumber()", 500);
            currentShowCount++;
        }

        function hideNumber() {
            view.text("");
        }

        
	function showAnswer(){
	textToShow=textToShow.substring(0,textToShow.length-1);
	var array=textToShow.split(",");
	$("#txtNumber1").val(array[0]);
	$("#txtNumber2").val(array[1]);
	$("#txtNumber3").val(array[2]);
	$("#txtNumber4").val(array[3]);
	$("#txtNumber5").val(array[4]);
	$("#txtNumber6").val(array[5]);
	$("#txtNumber7").val(array[6]);
	$("#txtNumber8").val(array[7]);
	$("#txtNumber9").val(array[8]);
	$("#txtNumber10").val(array[9]);
		var total=0;
	for(var i=0;i<array.length;i++){
	total+=parseInt(array[i]);}

	$("#total").val(total);
	textToShow="";
	}
</script>
</body>
</html>