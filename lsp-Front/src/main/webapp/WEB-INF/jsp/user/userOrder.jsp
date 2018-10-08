<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contxtPath = request.getContextPath();
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
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
 <a href="index.html" class="home">
            <span class="header-icon header-icon-home"></span>
            <span class="header-name">主页</span>
</a>
<div class="title" id="titleString">我的订单</div>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
        </a>
 </div>

        
   <div class="container">
    <ul class="giftlist unstyled">
      
     <c:forEach items="${createDate }" var="date" varStatus="loop">
		  <li>
		   <div class="imgbox">
		   	<a href="Gift.aspx.html"><img src="http://www.gridinn.com/photos/gift/13.jpg"> </a> 
		   </div>
		   <div class="desc">
		     <a href="Gift.aspx@id=13">萨摩充电宝</a> <br/>
		     <a href="Gift.aspx@id=13"><em>9600 积分 </em></a> 
		     <a href="Gift.aspx@id=13"><em>创建时间:${date } </em></a> 
		     <a href="Gift.aspx@id=13"><em>创建时间:${date } </em></a> 
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
