var hour, minute, second;// 时 分 秒
hour = minute = second = 0;// 初始化
var millisecond = 0;// 毫秒
var int;
function reset()// 重置
{
	window.clearInterval(int);
	millisecond = hour = minute = second = 0;
	$('#timetext').val('00时00分00秒000毫秒');
}

function timeStart()// 开始
{
	int = setInterval(timer, 50);
}

function timer()// 计时
{
	millisecond = millisecond + 50;
	if (millisecond >= 1000) {
		millisecond = 0;
		second = second + 1;
	}
	if (second >= 60) {
		second = 0;
		minute = minute + 1;
	}

	if (minute >= 60) {
		minute = 0;
		hour = hour + 1;
	}
	$('#timetext').val(
			hour + '时' + minute + '分' + second + '秒' + millisecond + '毫秒');

}

function timeStop()// 暂停
{
	window.clearInterval(int);
}



function replaceZero(oldString,length){
var tempZeros=new Array();
var zero='零';
for(var i=0;i<length-2;i++){
zero+='零';
tempZeros[i]=zero;
}
var newString=oldString;
for(var j=length-3;j>=0;j--){
if(newString.indexOf(tempZeros[j]) >= 0 ) 
{ 
newString=newString.replace(new RegExp(tempZeros[j], 'g'),"零");
}
}
if(newString.substr(newString.length-1,1)=='零'){
newString=newString.substring(0,newString.length-1);
}
return newString;
}
function switchString(num,dw){
if(num==0){
return '零';
}else{
if(dw=="千万"&&wan!=0&&shiwan!=0&wan!=0){
return num+'千';
} 
else if(dw=="百万"&&shiwan!=0&wan!=0)
{
return num+'百';
}
else if(dw=="十万"&wan!=0)
{
return num+'十';
}
else{
return num+dw;
}
}
}