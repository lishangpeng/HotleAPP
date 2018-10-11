<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style type="text/css">
		#l-map{height:300px;width:100%;}
		#r-result,#r-result table{width:100%;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=CpXf96MGs8IlF4qbg0GSM0z3Frv0FlkW"></script>
	<title>地图</title>
	<link href="<%=contxtPath %>/Scripts/css/loaders.min.css" rel="stylesheet" />
	<link href="<%=contxtPath %>/Scripts/css/loading.css" rel="stylesheet" />
	<style>
	    img {
		   max-width: none;
		}
	</style>
	<script type="text/javascript">
		$(window).load(function(){
			$(".loading").addClass("loader-chanage")
			$(".loading").fadeOut(100)
		})
	</script>
<body>
 <input id="hotelId" name="hotelId" type="hidden" value="${hotelId }" />
   <input id="checkInDate" name="checkInDate" type="hidden" value="${checkInDate }" />
   <input id="checkOutDate" name="checkOutDate" type="hidden" value="${checkOutDate }" />
<!--loading页开始-->
<div class="loading">
	<div class="loader">
        <div class="loader-inner pacman">
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
        </div>
	</div>
</div>
<!--loading页结束-->

 <div class="header">
 <a href="<%=contxtPath %>/" class="home">
            <span class="header-icon header-icon-home"></span>
            <span class="header-name">主页</span>
</a>
<div class="title" id="titleString"></div>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
        </a>
 </div>

<ul class="unstyled hotel-bar">
	<li class="first">
         <a href="<%=contxtPath %>/hotel/detail?hotelId=${hotelId}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">房型</a>
	</li>
	<li><a href="<%=contxtPath %>/hotel/hotelInfo?hotelId=${hotelId}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">简介</a></li>
	<li><a href="#BookRoom"  class="active">地图</a></li>
	<li><a href="<%=contxtPath %>/hotel/hotelComment?hotelId=${hotelId}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">评论</a></li>
</ul>

	<div id="l-map"></div>
	<div id="r-result"></div>
	<%@include file="../footer.jsp" %>
</body>
	<iframe id="geoPage" width=0 height=0 frameborder=0  style="display:none;" scrolling="no"
	    src="https://apis.map.qq.com/tools/geolocation?key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp">
	</iframe>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("l-map");
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 12);

	 var transit = new BMap.DrivingRoute(map, {
		renderOptions: {
			map: map,
			panel: "r-result",
			enableDragging : true //起终点可进行拖拽
		},  
	});
	 //119.642428,29.068079 金职地址
	 //119.635603,29.066756 宾馆位置
/* 	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			var p2 = new BMap.Point(r.point.lng,r.point.lat);
			//var p2 = new BMap.Point(119.5715,29.08624);
		}
		else {
			alert('failed'+this.getStatus());
		}        
	},{enableHighAccuracy: true})  */
	
		var location;
		var p1 = new BMap.Point(${hotel.lon},${hotel.lat});
		window.addEventListener('message', function(event) {
		    // 接收位置信息
		    var loc = event.data;
		    if(loc){
				var p2 = new BMap.Point(loc.lng, loc.lat)
			    transit.search(p2,p1);
		    }
		    console.log('location', loc);
		}, false)       ;
		
		setTimeout(function() {
		    if (!this.loc) {
		       console.log('定位超时')
		    }
		}, 6000); // 6s为推荐值，业务调用方可根据自己的需求设置改时间，不建议太短
</script>
</html>