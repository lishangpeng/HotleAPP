<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contxtPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=CpXf96MGs8IlF4qbg0GSM0z3Frv0FlkW"></script>
<title>附近城市</title>
</head>
<body>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
</a>
<div id="allmap">
	<iframe id="geoPage" width=0 height=0 frameborder=0  style="display:none;" scrolling="no"
	    src="https://apis.map.qq.com/tools/geolocation?key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp">
	</iframe>
	
	<script type="text/javascript">
		var location;
		window.addEventListener('message', function(event) {
		    // 接收位置信息
		    var loc = event.data;
		    if(loc){
				var map = new BMap.Map("allmap");          
				map.centerAndZoom(new BMap.Point(loc.lng, loc.lat), 11);
				var local = new BMap.LocalSearch(map, {
					renderOptions:{map: map}
				});
				local.search("宾馆");
		    }
		    console.log('location', loc);
		}, false)       ;
		
		setTimeout(function() {
		    if (!this.loc) {
		       console.log('定位超时')
		    }
		}, 6000); // 6s为推荐值，业务调用方可根据自己的需求设置改时间，不建议太短
		
	</script>
</div>	
</body>
</html>
