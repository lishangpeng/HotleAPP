<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        
<form name="aspnetForm" method="post" action="<%=contxtPath %>/hotel/hotelComment" id="aspnetForm">
<div>
<input type="hidden" id="curr" name="curr" />
<input type="hidden" value="${hotelId }" name="hotelId" />
<input id="checkInDate" name="checkInDate" type="hidden" value="${checkInDate }" />
<input id="checkOutDate" name="checkOutDate" type="hidden" value="${checkOutDate }" />
</div>

<div class="container">
<ul class="unstyled hotel-bar">
	<li class="first">
    <a href="<%=contxtPath %>/hotel/detail?hotelId=${hotelId}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">房型</a>
	</li>
	<li><a href="<%=contxtPath %>/hotel/hotelInfo?hotelId=${hotelId}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">简介</a></li>
	<li><a href="<%=contxtPath %>/hotel/hotelMap?hotelId=${hotelId}&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}">地图</a></li>
	<li><a href="#BookRoom"  class="active">评论</a></li>
</ul>
<script type="text/javascript">
    $('#titleString').text($(document)[0].title);
</script>

<div class="hotel-comment-list">
	 
	 <c:forEach items="${pageInfo.list }" var="comment">
	      <div class="hotel-user-comment">
					<span class="hotel-user"><img width="32" height="32" src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/298b5300-9410-49a6-954f-08924559e068.jpg">会员${comment.phoneNum }:</span>
					<div class="hotel-user-comment-cotent">
						<p>	${comment.comment }</p>
						<span>
							<fmt:formatDate value="${comment.createTime }" pattern="yyyy-MM-dd"/>
						</span>
					</div>
		  </div> 
	            
	      <div class="hotel-user-comment hotel-apply-user-comment none">
					<div class="hotel-apply-comment">
						<div class="hotel-apply-div"><span class="hotel-user">店长回复</span></div>
						<div class="hotel-user-comment-cotent">
							<p></p>
					</div>
					</div>
		 </div>         
	 </c:forEach>
      
      
<!-- <div class="page">
AspNetPager V7.2 for VS2005 & VS2008  Copyright:2003-2008 Webdiyer (www.webdiyer.com)
<div id="ctl00_ContentPlaceHolder1_AspNetPager1" style="width:100%;text-align:center;">
<a class="nextprebutton" class="nextprebutton" disabled="disabled" style="margin-right:5px;">上页</a><span class="currentpage" style="margin-right:5px;">1</span><a href="HotelReview.aspx@id=5&page=2" style="margin-right:5px;">2</a><a href="HotelReview.aspx@id=5&page=3" style="margin-right:5px;">3</a><a href="HotelReview.aspx@id=5&page=4" style="margin-right:5px;">4</a><a href="HotelReview.aspx@id=5&page=5" style="margin-right:5px;">5</a><a href="HotelReview.aspx@id=5&page=6" style="margin-right:5px;">...</a><a class="nextprebutton" class="nextprebutton" href="HotelReview.aspx@id=5&page=2" style="margin-right:5px;">下页</a>
</div>
AspNetPager V7.2 for VS2005 & VS2008 End
</div>	 -->
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

</div>
</form>


<%@include file="../footer.jsp" %>

</body>
</html>
