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

        
    <form name="aspnetForm" method="post" action="HotelReview.aspx?id=5" id="aspnetForm">
<div>
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
	 
      <div class="hotel-user-comment">
				<span class="hotel-user"><img width="32" height="32" src="http://www.gridinn.com//images/user01.png">会员李*清:</span>
				<div class="hotel-user-comment-cotent">
					<p>	这次去这个房间有点烟味，住了这么多次只有这个有烟味~除了烟味都是一如既往的好！</p>
					<span>2014-04-11</span>
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
      
      <div class="hotel-user-comment">
				<span class="hotel-user"><img width="32" height="32" src="http://www.gridinn.com//images/user02.png">会员韩*芳:</span>
				<div class="hotel-user-comment-cotent">
					<p>	好~</p>
					<span>2014-04-10</span>
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
      
      <div class="hotel-user-comment">
				<span class="hotel-user"><img width="32" height="32" src="http://www.gridinn.com//images/user02.png">会员韩*芳:</span>
				<div class="hotel-user-comment-cotent">
					<p>	一如既往的不错~</p>
					<span>2014-04-10</span>
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
      
      <div class="hotel-user-comment">
				<span class="hotel-user"><img width="32" height="32" src="http://www.gridinn.com//photos/201306/6426.jpg">会员陈*蓉:</span>
				<div class="hotel-user-comment-cotent">
					<p>	比昨天住的简直好太多了。唯一一点不好就是洗完澡之后那些积水什么的都渗漏到房间里来了，找前台来帮忙清理，清理了10分钟。。。真恐怖。。。</p>
					<span>2014-04-10</span>
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
      
      <div class="hotel-user-comment">
				<span class="hotel-user"><img width="32" height="32" src="http://www.gridinn.com//photos/201306/6426.jpg">会员陈*蓉:</span>
				<div class="hotel-user-comment-cotent">
					<p>	房间空调是坏了还是老化了16度的温度和26度似的，坐厕也是坏的，老是冲不下去。酒店的过道地毯可能应该清洗了，走过去一阵阵臭味。办理入住的时候前台也没说阁楼要加10块电脑费啊以前都不用的，退房的时候又加收了10块钱。总之没有以前住的舒坦。</p>
					<span>2014-04-10</span>
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
          	

		</div>
            <div class="page">
    
<!-- AspNetPager V7.2 for VS2005 & VS2008  Copyright:2003-2008 Webdiyer (www.webdiyer.com) -->
<div id="ctl00_ContentPlaceHolder1_AspNetPager1" style="width:100%;text-align:center;">
<a class="nextprebutton" class="nextprebutton" disabled="disabled" style="margin-right:5px;">上页</a><span class="currentpage" style="margin-right:5px;">1</span><a href="HotelReview.aspx@id=5&page=2" style="margin-right:5px;">2</a><a href="HotelReview.aspx@id=5&page=3" style="margin-right:5px;">3</a><a href="HotelReview.aspx@id=5&page=4" style="margin-right:5px;">4</a><a href="HotelReview.aspx@id=5&page=5" style="margin-right:5px;">5</a><a href="HotelReview.aspx@id=5&page=6" style="margin-right:5px;">...</a><a class="nextprebutton" class="nextprebutton" href="HotelReview.aspx@id=5&page=2" style="margin-right:5px;">下页</a>
</div>
<!-- AspNetPager V7.2 for VS2005 & VS2008 End -->

  
    </div>	
</div>
</form>


<%@include file="../footer.jsp" %>

</body>
</html>
