<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../header.jsp" %>
<script type="text/javascript">
	$(function(){
		$("#commit").click(function(){
			$("form").submit();
		})
	})
</script>
<style type="text/css">
	input[type="file"]{
		height:100px;
		width:100%;
	}
	input[type="text"]{
		word-break: break-all;
	}
</style>
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
<div class="container width80 pt20">
<form action="<%=contxtPath%>/user/comment" method="post">
	<input type="hidden" name="hotelId" value="${hotelId }"/>
	<input type="hidden" name="roomId" value="${roomId }"/>
	<fmt:formatDate value="${checkInDate }" var="inDate" pattern="yyyy-MM-dd"/>
	<fmt:formatDate value="${checkOutDate }" var="outDate" pattern="yyyy-MM-dd"/>
	<input type="hidden" name="checkInDate" value="${inDate }"/>
	<input type="hidden" name="checkOutDate" value="${outDate }"/>
   <label>评论：</label><textarea style="width:98%;height:100px" name="comment" id="comment"></textarea>
   <div class="control-group">
         <button onClick="commit" id="commit" class="btn-large green button width100" style="margin-top:30px" >评论</button>
  </div>
</form>  
<%@include file="../footer.jsp" %>	
</div>
</body>
</html>