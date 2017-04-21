<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>数据可视化</title>
			 <script src="../mdm/uploadfile_js/jquery-1.11.2.min.js"></script>
			 <script src="../Jsp/JS/iscroll.js"></script>
			  <script src="../Jsp/JS/avgrund.js"></script>
<link rel="stylesheet" href="../Jsp/CSS/about.css">
</head>
<body style="margin:0px">

		<aside style="margin-top:100px;height:500px" id="default-popup" class="avgrund-popup">

			<h2 id="title" style="margin-bottom:10px;"></h2>

			<p style="margin-top:20px;" id="content">
			
			</p>

			<button style="position:absolute;bottom:20px;right:20px;padding:4px 8px;" onClick="javascript:closeDialog();">Close</button>

		</aside>

<div style="padding-left: 10px;height: 70px;border-bottom: 4px solid black;padding-top: 10px;">
<img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9IMj&amp;oid=00D90000000pkXM" alt="" style="width:60%;">
</div>
<div id="wrapper">
<div class="box scroller">

	<ul class="event_list">


		<li><span>4月21日</span><p><span onClick="javascript:openDialog(this);">第一季度中国出口塑料制品248万吨，同比增长14.1%;出口金额为576.97亿元，同比增长21.3%。3月当月出口95万吨，同比增长23.38%;出口金额为224.01亿元，同比增长23.76%。 </span></p></li>

		<li><span>4月20日</span><p><span onClick="javascript:openDialog(this);">  本周，余姚中国塑料城塑料原料市场气氛欠佳，行情普遍回落。受诸多因素制约，下游工厂采购积极性始终难以提升，终端需求尚难摆脱低迷态势，石化企业出货并不顺畅，在库存压力减增的情况下，下调报价的不在少数。受此影响，场内看空情绪抬头，贸易商对后市信心不足，跟随小幅下调报价为主。从整体来看，目前场内利好并不明显，行情好转可能还需时间配合。预计，近期市场可能尚难摆脱弱势态势。</span></p></li>

		<li><span>4月19日</span><p><span onClick="javascript:openDialog(this);">据国家统计局最新统计显示，2017年一季度，中国规模以上工业增加值同比实际增长6.8%，增速比上年同期加快1.0个百分点，比上年全年加快0.8个百分点。
3月当月，中国规模以上工业增加值同比实际增长7.6%，比1-2月份加快1.3个百分点。环比增长0.83%。
分行业看，3月份，41个大类行业中有33个行业增加值保持同比增长。分产品看，3月份，596种产品中有430种产品同比增长。</span></p></li>

		<li><span>4月18日</span><p><span onClick="javascript:openDialog(this);">文字信息43</span></p></li>

		<li><span>4月17日</span><p><span onClick="javascript:openDialog(this);">文字信息42</span></p></li>
	</ul>
	<div class="more"><i class="pull_icon"></i><span>上拉加载...</span></div>
	</div>
	</div>
<script>
$(function(){
	function openDialog(obj) {
		var content=$(obj).text();
		var title=$(obj).parent().siblings("span").text();
		$("#content").text(content);
		$("#title").text(title);
		Avgrund.show( "#default-popup" );

	}

	function closeDialog() {

		Avgrund.hide();

	}
	window.openDialog=openDialog;
	window.closeDialog=closeDialog;
});

var date=16;
		var myscroll = new iScroll("wrapper",{
			onScrollMove:function(){
				if (this.y<(this.maxScrollY)) {
					$('.pull_icon').addClass('flip');
					$('.pull_icon').removeClass('loading');
					$('.more span').text('释放加载...');
				}else{
					$('.pull_icon').removeClass('flip loading');
					$('.more span').text('上拉加载...')
				}
			},
			onScrollEnd:function(){
				if ($('.pull_icon').hasClass('flip')) {
					$('.pull_icon').addClass('loading');
					$('.more span').text('加载中...');
					pullUpAction();
				}
				
			},
			onRefresh:function(){
				$('.more').removeClass('flip');
				$('.more span').text('上拉加载...');
			}
			
		});
		
		function pullUpAction(){
			setTimeout(function(){
				/*$.ajax({
					url:'/json/ay.json',
					type:'get',
					dataType:'json',
					success:function(data){
						for (var i = 0; i < 5; i++) {
							$('.scroller ul').append(data);
						}
						myscroll.refresh();
					},
					error:function(){
						console.log('error');
					},
				})*/
				var mindate;
				if(date>=5){
					mindate=date-5;
				}else{mindate=0;}
				if(date>=5){	
				for (var i = date; i > mindate; i--) {
									
					
					$('.scroller ul').append("<li><span>4月"+i+"月</span><p><span  onClick='javascript:openDialog(this);'>文字信息44</span></p></li>");
					
				}
				}
				else{
					$('.more span').text("已到底部");
				}
				if(date>=5){
					date=date-5;
				}else{date=0;}
				
				myscroll.refresh();
			}, 1000)
		}
		if ($('.scroller').height()<$('#wrapper').height()) {
			$('.more').hide();
			myscroll.destroy();
		}

	</script>
</body></html>