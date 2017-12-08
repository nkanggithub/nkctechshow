/*
Create By AZ
Date: 2016-01-11 
blog: http://www.tuterm.com
可以任意使用，保留作者信息以溯源
*/
;
(function($) {
	$.fn.speech = function(options) {
		var defaults = {
			"speech": true, //通过点击链接播报，还是直接播报
			"lang": "zh", //语言			
			"speed": speed, //语速			
			"sWidth": 16, //链接按钮的宽度			
			"sHeight": 13, //链接按钮的高度		
			"https": true, //启用https	
			"bg": "./image/speech.png", //链接按钮的背景图片			
			"content": "这是一段测试内容" //直接播报内容
		};
		var options = $.extend(defaults, options);
		return this.each(function() {
			var _this = $(this),
				_iframe = _this.find(".speech_iframe"),
				http = options.https ? "http" : "http",
				content = _this.text();
			content = (!content || content === undefined || content === null) ? options.content : content;


			if (options.speech) {
				//点击链接播报
				var _speech = $(".start");
				_speech.on('click', function() { //捕获点击事件	
					_this.html("");
					$("#startPanel").hide();
					$("#answerPanel").hide();
					$("#fakePanel").show();
					if(questionNumber!=0&&questionNumber%10==0){
						swal({  
					        title:"真棒，休息一下吧？",  
					        text:"<input type='hidden'>",
					        html:"true",
					        showConfirmButton:"true", 
							showCancelButton: true,   
							closeOnConfirm: false,  
					        confirmButtonText:"我要休息",  
					        cancelButtonText:"我要继续",
					        animation:"slide-from-top"  
					      }, 
							function(inputValue){
								if (inputValue === false){

									return false;
								}
								else{
									window.location.href = "NavigatorForBasic.jsp?UID=" + uid;
								}
					      });
					
					}
					questionNumber++;
					$("#answer").val("");
					$("#timestext").val(questionNumber+"/"+totalQuestion);
				var src = http + '://tts.baidu.com/text2audio?lan=' + options.lang + '&ie=UTF-8&text=' + getNum() + '&spd='+speed;		
				console.log("getNumber:"+getNum());
					_iframe.length > 0 ? _iframe.attr("src", src) : (function() {
						var iframe = "<audio controls='' autoplay='' name='media' onended='endVoice()'><source id='voice' src='' type='audio/mp3'></audio>";
						_this.append(iframe);
						$("#voice").attr("src",src);
					})();
				});
			} else { //自动播报
				_iframe.length > 0 ? _iframe.attr("src", src) : (function() {
					var iframe = "<iframe height='0' width='0' class='speech_iframe' scrolling='no' frameborder='0' src='" + src + "' ></iframe>";
					_this.append(iframe);
				})();
			}
		});
	};
})(jQuery);