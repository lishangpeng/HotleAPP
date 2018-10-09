<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<body>
 <div class="header">
 <a href="index.html" class="home">
            <span class="header-icon header-icon-home"></span>
            <span class="header-name">主页</span>
</a>
<div class="title" id="titleString"></div>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
        </a>
 </div>

        
    <script type="text/javascript" src="http://gmu.baidu.com/src/extend/touch.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/extend/matchMedia.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/extend/event.ortchange.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/extend/parseTpl.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/core/gmu.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/core/event.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/core/widget.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/slider.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/arrow.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/dots.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/$touch.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/$autoplay.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/$lazyloadimg.js"></script>
    <script type="text/javascript" src="http://gmu.baidu.com/src/widget/slider/imgzoom.js"></script>
      <link rel="stylesheet" type="text/css" href="http://gmu.baidu.com/assets/widget/slider/slider.css" />
        <link rel="stylesheet" type="text/css" href="http://gmu.baidu.com/assets/widget/slider/slider.default.css" />
    
<div class="container">
<ul class="unstyled hotel-bar">
	<li class="first">
    <a href="Hotel.aspx.html">房型</a>
	</li>
	<li><a href="HotelInfo.aspx"  class="active">简介</a></li>
	<li><a href="#">地图</a></li>
	<li><a href="HotelReview.aspx.HTML">评论</a></li>
</ul>
<script type="text/javascript">
    $('#titleString').text($(document)[0].title);
</script>
<div class="hotel-prompt ">
    <span class="hotel-prompt-title">酒店图片</span>
<div id="slider" style="margin-top: 10px;">
    
 <div>
        <img src="http://www.gridinn.com/photos/201212/20121231113309m.jpg">
        <p>酒店外观</p>
 </div>             
       
 <div>
        <img src="http://www.gridinn.com/photos/201212/20121231113406m.jpg">
        <p>大堂</p>
 </div>             
       
 <div>
        <img src="http://www.gridinn.com/photos/201212/20121231113520m.jpg">
        <p>阳光大床房</p>
 </div>             
        
</div>
</div>
<div id="hotelinfo" class="hotel-prompt ">
			<span class="hotel-prompt-title">酒店简介</span>
			<p>格子微酒店南宁南宁秀灵路店位于广西最著名大学广西大学东门旁，紧邻邕江边，周边超市、餐饮、银行等配套设施完善，出行便利。 酒店倡导低碳环保，客房内配有24小时热水、wifi网络、电视等设施，客房虽小，设施齐全。酒店服务周到细致，是您出行的不错选择。 酒店开业时间2012年12月。</p>
            <p>地址：秀灵路55号（出入境管理局旁）</p>
            <p>电话：0771-3391588</p>
		</div>
</div>
<script>
    //创建slider组件
    $('#slider').slider({ imgZoom: true });
</script>
<%@include file="../footer.jsp" %>

</body>
</html>
