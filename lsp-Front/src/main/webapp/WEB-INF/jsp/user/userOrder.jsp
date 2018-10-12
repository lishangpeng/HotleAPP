<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contxtPath = request.getContextPath();
%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>仿格子微酒店触屏版html5手机wap旅游网站模板下载礼品商城</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
<meta content="yes" name="apple-mobile-web-app-capable" /><link href="<%=contxtPath %>/styles/bootstrap.min.css" rel="stylesheet" />
<link href="<%=contxtPath %>/styles/NewGlobal.css" rel="stylesheet" />

<script type="text/javascript" src="<%=contxtPath %>/Scripts/zepto.js"></script>

</head>
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
    <ul class="giftlist unstyled">
      
     <c:forEach items="${filterOrder }" var="mapEntry">
		<fmt:formatDate value="${mapEntry.value.checkInDate }" var="inDate"  pattern="yyyy-MM-dd"/>
		<fmt:formatDate value="${mapEntry.value.checkOutDate }" var="outDate"  pattern="yyyy-MM-dd"/>
		  <li>
		   <div class="imgbox">
		   	<a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${mapEntry.value.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}"><img src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/4bbc5c1e-877c-4801-94cb-a70467f8a4ec.jpg"> </a> 
		   </div>
		   <div class="desc">
			<c:set var="flag" value="true"/>
			<c:forEach items="${hotelList }" var="hotel">
				<c:if test="${hotel.id eq mapEntry.value.hotelId }">
					<c:if test="${flag }">
						<a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${mapEntry.value.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}">${hotel.hotelName }</a>
						<c:set var="flag" value="false"/>
					</c:if>
				</c:if>
			</c:forEach>
			
			<c:set var="flag" value="true"/>
			<c:forEach items="${roomList }" var="room">
				<c:if test="${room.id eq mapEntry.value.roomId }">
					<c:if test="${flag }">
						<a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${mapEntry.value.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}">${room.roomName }</a></br>
						<c:set var="flag" value="false"/>
					</c:if>
				</c:if>
			</c:forEach>
			
		     <c:forEach items="${orderType }" var="type">
		     	<c:if test="${type.key eq mapEntry.key }">
					<c:if test="${type.value eq '未付款' }">
						<a href="#">
							去付款
						</a><br/>
					</c:if>
					<c:if test="${type.value eq '已付款' }">
			     		<a href="javascript:void(0)">
							<c:out value="${type.value }"></c:out>
			    		</a> <br/>
					</c:if>
					<c:if test="${type.value eq '已失效' }">
			     		<a href="javascript:void(0)">
							<c:out value="${type.value }"></c:out>
			    		</a> <br/>
					</c:if>
			    </c:if>
		     </c:forEach>
		     <a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${mapEntry.value.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}"><em>入住时间：
		     	<fmt:formatDate value="${mapEntry.value.checkInDate }" pattern="yyyy-MM-dd" />
		     </em></a></br> 
		     <a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${mapEntry.value.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}"><em>离开时间：
		     <fmt:formatDate value="${mapEntry.value.checkOutDate }" pattern="yyyy-MM-dd" />
		     </em></a> 
		  </div>
		 </li>
     </c:forEach>
         
    </ul>
   </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.giftlist li img').each(function () {

                var width = $(this).width(); // 图片实际宽度
                var height = $(this).height(); // 图片实际高度

                // 检查图片是否超宽
                if (width != height) {
                 
                    $(this).css("height", width); // 设定等比例缩放后的高度
                }
            });
        });
    </script>


  <div class="footer">
  <div class="gezifooter">
      
      <a href="login.aspx" class="ui-link">立即登陆</a> <font color="#878787">|</font> 
       <a href="reg.aspx" class="ui-link">免费注册</a> <font color="#878787">|</font>                 
                  

       <a href="http://www.gridinn.com/@display=pc" class="ui-link">电脑版</a>
  </div>
  <div class="gezifooter">
    <p style="color:#bbb;">格子微酒店连锁 &copy; 版权所有 2012-2014</p>
  </div>
  </div>

</body>
</html>
