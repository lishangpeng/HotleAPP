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

    <form action="<%=contxtPath%>/user/userOrder">
    
   
   <div class="container">
    <input type="hidden" id="curr" name="curr" />
    <ul class="giftlist unstyled">
     <c:forEach items="${pageInfo.list }" var="order">
		<fmt:formatDate value="${order.checkInDate }" var="inDate"  pattern="yyyy-MM-dd"/>
		<fmt:formatDate value="${order.checkOutDate }" var="outDate"  pattern="yyyy-MM-dd"/>
		  <li>
		   <div class="imgbox">
		   	<a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${order.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}"><img  style="height:202px" src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/4bbc5c1e-877c-4801-94cb-a70467f8a4ec.jpg"> </a> 
		   </div>
		   <div class="desc">
			<c:set var="flag" value="true"/>
			<c:forEach items="${hotelList }" var="hotel">
				<c:if test="${hotel.id eq order.hotelId }">
					<c:if test="${flag }">
						<a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${order.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}">${hotel.hotelName }</a>
						<c:set var="flag" value="false"/>
					</c:if>
				</c:if>
			</c:forEach>
			
			<c:set var="flag" value="true"/>
			<c:forEach items="${roomList }" var="room">
				<c:if test="${room.id eq order.roomId }">
					<c:if test="${flag }">
						<a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${order.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}">${room.roomName }</a></br>
						<c:set var="flag" value="false"/>
					</c:if>
				</c:if>
			</c:forEach>
			
				<fmt:formatDate value="${order.checkInDate }" var="inDate" pattern="yyyy-MM-dd"/>
				<fmt:formatDate value="${order.checkOutDate }" var="outDate" pattern="yyyy-MM-dd"/>
				<c:if test="${order.orderType eq '未付款' }">
					<a href="<%=contxtPath %>/room/order?hotelId=${order.hotelId }&roomId=${order.roomId }&checkInDate=${inDate }&checkOutDate=${outDate}">
						去付款
					</a><br/>
				</c:if>
				<c:if test="${order.orderType eq '已付款' }">
		     		<a href="javascript:void(0)">
						<c:out value="${order.orderType }"></c:out>
		    		</a> <br/>
				</c:if>
				<c:if test="${order.orderType eq '已失效' }">
		     		<a href="javascript:void(0)">
						<c:out value="${order.orderType }"></c:out>
		    		</a> <br/>
				</c:if>
				
				<fmt:formatDate value="${order.createDate }" var="createDate" pattern="yyy-MM-dd hh:mm:ss"/>
				<em>创建时间：${createDate }</em><br/>

		     <a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${order.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}"><em>入住时间：
		     	<fmt:formatDate value="${order.checkInDate }" pattern="yyyy-MM-dd" />
		     </em></a></br> 
		     <a href="<%=contxtPath%>/hotel/hotelInfo?hotelId=${order.hotelId }&checkInDate=${inDate }&checkOutDate=${outDate}"><em>离开时间：
		     <fmt:formatDate value="${order.checkOutDate }" pattern="yyyy-MM-dd" />
		     </em></a> 
		  </div>
		 </li>
     </c:forEach>
    </ul>
   </div>
    </form>
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
   		<c:if test="${pageInfo.pages>1 }">
           <div id="pagination" style="margin: 30px;"></div>
           <script type="text/javascript" src="<%=contxtPath%>/Scripts/laypage/1.2/laypage.js"></script>
           <script type="text/javascript">
               laypage({
                   cont:'pagination',
                   pages:${pageInfo.pages},
                   curr: ${pageInfo.pageNum},
                   jump:function(obj,first){
                       if(!first){
                           $("#curr").val(obj.curr);
                           $("form").submit();
                       }
                   }
               });
           </script>
	</c:if>


<%@include file="../footer.jsp" %>

</body>
</html>
