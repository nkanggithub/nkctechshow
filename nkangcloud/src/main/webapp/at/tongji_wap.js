/*Google Analytics analytics.js*/
 (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
 
  ga('create', 'UA-16054642-1', 'auto');
  ga('create', 'UA-16054642-3', {'name':'m'});

  ga('send', 'pageview');
  ga('m.send', 'pageview');
/*Google Analytics End*/

var google_conversion_id = 963202888;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
document.write('<scri'+'pt type="text/javascript" src="https://www.googleadservices.com/pagead/conversion.js"></scri'+'pt>');

//M站总的百度统计
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?e89735d560e89742be5242cc4268949e";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();

/* 百度统计代码wap,news下各频道文章记录到该频道的PC流量 */
var channelArr = ["toefl", "cet4", "cet6", "ielts", "kaobo", "gre", "gmat", "sat", "tem", "nce", "english", "language", "gaokao", "gwy", "zhongkao", "shuoshi", "yixue", "sifa", "zhicheng",  "liuxue", "kaoyan", "xiaoxue",  "caijing", "jiaoshi", "act","jinrong","yinhang","news"];
var baiduArr = ["7c6e5662bf5a88eed1f626872a444b9b", "73ba68873b5062152835efc0621bb98f", "f655860b735dfd79d3767a886703cf72", "ba531ab7517c5554a32287787897a854", "f46f9ebb7337d3a6b7cd50d55931ed67", "0233d3588fc43e735c4429370992c3a9", "e1a509351196241e7360fdf3667c0ff5", "56323bd9d4cf2b7275738ff73f0635bc", "3282cd26b9938556d93a108d982b5b75", "f56476a46479ddea0270f0b0cdce29f7", "1e2be2327e3d5ab8c1cb1d6b92f2b775", "4af6f33701162d607d688af6014cc22c", "18f4b85fadefc7f3665379dad5e5a3b3", "1d2ce33dd0a07613e732a5aaedbef4e2", "7b5ca66b8ed43cb10386a22e93d3120e", "87f76fcf14f52f7d0207050084294944", "cbbd1f81f7aedf25847c366661867cc2", "a48aad72d35368400d46befb4e4c80cc", "fa3665729927f8a5999cea733364d219",  "0453b2a37ecc75ca747cb78c395ead69", "10915b7ca443e0281ae1021000b89e57", "8c61271d4fcf8045ac62d69347ba3ec6", "175b499c6d33bcf15e5e02423a68bccd", "5a8c2baf9f46524cbe649f0c024a5458","2fda85a9aee96150855567ec273c8379","3459cecd5d7d87535816ca1b7039f838","47d1f552b30bda6fb93056252506218a","ee8d77c7157d2165318344d21b804dbf"];
window.channelEN = window.channelEN || window.location.pathname.split("/")[1];
if(document.getElementById("analytics") !== null){
  var txtObj = document.getElementById("analytics").getAttribute("txt") || window.channelEN;
  var baiduObj = " ";
  for ( i = 0; i < channelArr.length; i++) {
    if (txtObj == channelArr[i]) {
      baiduObj = baiduArr[i];
    }
  }
}

(function() {
	var hm = document.createElement("script");
	hm.src = "https://hm.baidu.com/hm.js?" + baiduObj;
	var s = document.getElementsByTagName("script")[0];
	s.parentNode.insertBefore(hm, s);
})();
// 为乐语传递kid和uid
(function() {
  if( window.reseveKey ) return;
  var getCookie = function( name ) {
    var arr, reg = new RegExp( "(^| )" + name + "=([^;]*)(;|$)" );
    if( arr = document.cookie.match( reg ) )
      return decodeURIComponent( arr[ 2 ] );
    else
      return null;
  };
  var cookieName = 'koolearn_netalliance_cookie';
  var uid, cookieValue;
  uid = cookieValue = getCookie( cookieName );
  if( uid ) {
    window.reseveKey = '#params:userId,' + uid + ',' + cookieName + ',' + cookieValue;
  }
})();