<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        
<form name="aspnetForm" method="post" action="<%=contxtPath %>/hotel/hotelComment" id="aspnetForm">
<div>
<input type="hidden" id="curr" name="curr" />
<input type="hidden" value="${hotelId }" name="hotelId" />
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE4NzEzNzgyMjkPZBYCZg9kFgICAQ9kFgICAQ9kFgRmDxYCHgtfIUl0ZW1Db3VudAIFFgpmD2QWAmYPFQYSL2ltYWdlcy91c2VyMDEucG5nB+adjirmuIVz6L+Z5qyh5Y676L+Z5Liq5oi/6Ze05pyJ54K554Of5ZGz77yM5L2P5LqG6L+Z5LmI5aSa5qyh5Y+q5pyJ6L+Z5Liq5pyJ54Of5ZGzfumZpOS6hueDn+WRs+mDveaYr+S4gOWmguaXouW+gOeahOWlve+8gQoyMDE0LTA0LTExBG5vbmUAZAIBD2QWAmYPFQYSL2ltYWdlcy91c2VyMDIucG5nB+mfqSroirME5aW9fgoyMDE0LTA0LTEwBG5vbmUAZAICD2QWAmYPFQYSL2ltYWdlcy91c2VyMDIucG5nB+mfqSroirMW5LiA5aaC5pei5b6A55qE5LiN6ZSZfgoyMDE0LTA0LTEwBG5vbmUAZAIDD2QWAmYPFQYXL3Bob3Rvcy8yMDEzMDYvNjQyNi5qcGcH6ZmIKuiTicUB5q+U5pio5aSp5L2P55qE566A55u05aW95aSq5aSa5LqG44CC5ZSv5LiA5LiA54K55LiN5aW95bCx5piv5rSX5a6M5r6h5LmL5ZCO6YKj5Lqb56ev5rC05LuA5LmI55qE6YO95riX5ryP5Yiw5oi/6Ze06YeM5p2l5LqG77yM5om+5YmN5Y+w5p2l5biu5b+Z5riF55CG77yM5riF55CG5LqGMTDliIbpkp/jgILjgILjgILnnJ/mgZDmgJbjgILjgILjgIIKMjAxNC0wNC0xMARub25lAGQCBA9kFgJmDxUGFy9waG90b3MvMjAxMzA2LzY0MjYuanBnB+mZiCrok4nSAuaIv+mXtOepuuiwg+aYr+Wdj+S6hui/mOaYr+iAgeWMluS6hjE25bqm55qE5rip5bqm5ZKMMjbluqbkvLznmoTvvIzlnZDljpXkuZ/mmK/lnY/nmoTvvIzogIHmmK/lhrLkuI3kuIvljrvjgILphZLlupfnmoTov4fpgZPlnLDmr6/lj6/og73lupTor6XmuIXmtJfkuobvvIzotbDov4fljrvkuIDpmLXpmLXoh63lkbPjgILlip7nkIblhaXkvY/nmoTml7blgJnliY3lj7DkuZ/msqHor7TpmIHmpbzopoHliqAxMOWdl+eUteiEkei0ueWViuS7peWJjemDveS4jeeUqOeahO+8jOmAgOaIv+eahOaXtuWAmeWPiOWKoOaUtuS6hjEw5Z2X6ZKx44CC5oC75LmL5rKh5pyJ5Lul5YmN5L2P55qE6IiS5Z2m44CCCjIwMTQtMDQtMTAEbm9uZQBkAgEPDxYEHhBDdXJyZW50UGFnZUluZGV4AgEeC1JlY29yZGNvdW50ArAJZGRkZD6s7lxwIjucCEN24we/4UN2rGA=" />
</div>

<div class="container">
<ul class="unstyled hotel-bar">
	<li class="first">
    <a href="Hotel.aspx.HTML">房型</a>
	</li>
	<li><a href="HotelInfo.aspx.html">简介</a></li>
	<li><a href="#">地图</a></li>
	<li><a href="HotelReview.aspx.html" class="active">评论</a></li>
</ul>
<script type="text/javascript">
    $('#titleString').text($(document)[0].title);
</script>

<div class="hotel-comment-list">
	 
	 <c:forEach items="${pageInfo.list }" var="comment">
	      <div class="hotel-user-comment">
					<span class="hotel-user"><img width="32" height="32" src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/298b5300-9410-49a6-954f-08924559e068.jpg">会员李*清:</span>
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

</div>
</form>


<%@include file="../footer.jsp" %>

</body>
</html>
