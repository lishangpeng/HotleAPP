<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header.jsp" %>
<body>
 <div class="header">
 <a href="<%=contxtPath %>/" class="home">
            <span class="header-icon header-icon-home"></span>
            <span class="header-name">主页</span>
</a>
<div class="title" id="titleString">酒店列表</div>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
        </a>
 </div>

        
  <div class="container hotellistbg">
         <ul class="unstyled hotellist">
       		<c:forEach items="${hotelList }" var="hotel">
             <li>
              <a href="<%=contxtPath%>/hotel/detail?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">
                 <img class="hotelimg fl" src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/4bbc5c1e-877c-4801-94cb-a70467f8a4ec.jpg" /> 
              <div class="inline">
                  <h3>${hotel.hotelName }</h3>
                  <p>${hotel.address }</p>
                  <p>评分：4.6 （1200人已评）</p>
              </div>
              <div class="clear"></div>  
               </a> 
               <ul class="unstyled">
                   <li><a href="<%=contxtPath %>/hotel/detail?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}" class="order">预订</a></li>
                   <li><a href="<%=contxtPath %>/hotel/hotelMap?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}" class="gps">导航</a></li>
                   <li><a href="<%=contxtPath %>/hotel/hotelInfo?hotelId=${hotel.id}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}" class="reality">实景</a></li>
               </ul>
             </li>
       		</c:forEach>
           
         </ul>
  </div>


<%@include file="../footer.jsp" %>

</body>
</html>
