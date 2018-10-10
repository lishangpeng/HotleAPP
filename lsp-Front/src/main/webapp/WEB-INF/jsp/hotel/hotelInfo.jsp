<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<script type="text/javascript" src="<%=contxtPath %>/Scripts/bootstrap.js"></script>
<body>
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

    
<div class="container">
<ul class="unstyled hotel-bar">
	<li class="first">
    <a href="<%=contxtPath %>/hotel/detail?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">房型</a>
	</li>
	<li><a href="#BookRoom"  class="active">简介</a></li>
	<li><a href="<%=contxtPath %>/hotel/hotelMap?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">地图</a></li>
	<li><a href="<%=contxtPath %>/hotel/hotelComment?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">评论</a></li>
</ul>


 <span class="hotel-prompt-title">酒店图片</span>
<div id="slider" style="margin-top: 10px;">
    


<div id="myCarousel" class="carousel slide">
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
  </ol>
  <!-- Carousel items -->
  <div class="carousel-inner">
    <div class="active item">
    	<img src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/298b5300-9410-49a6-954f-08924559e068.jpg"/>
    </div>
    <div class="item">
    	<img src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/4bbc5c1e-877c-4801-94cb-a70467f8a4ec.jpg"/>
    </div>
  </div>
  <!-- Carousel nav -->
  <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
  <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
</div>

<div id="hotelinfo" class="hotel-prompt ">
			<span class="hotel-prompt-title">酒店简介</span>
			<p>${hotel.hotelName }</p>
            <p>地址：${hotel.address }</p>
            <p>电话：${hotel.phoneNum }</p>
		</div>
</div>
<%@include file="../footer.jsp" %>
</div>
</body>
</html>
