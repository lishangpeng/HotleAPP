<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>    
<%@include file="../header.jsp" %>
<body>
 <div class="header">
 <a href="index.html" class="home">
            <span class="header-icon header-icon-home"></span>
            <span class="header-name">主页</span>
</a>
<div class="title" id="titleString">登陆</div>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
        </a>
 </div>

        
<div class="container width80 pt20">
 <form name="aspnetForm" method="post" action="<%=contxtPath %>/user/register" id="aspnetForm" class="form-horizontal">

<!-- 利用腾讯api 获取用户的地理位置 -->
<iframe id="geoPage" width=0 height=0 frameborder=0  style="display:none;" scrolling="no"
    src="https://apis.map.qq.com/tools/geolocation?key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp">
</iframe>

<script type="text/javascript">
	var location;
	
	window.addEventListener('message', function(event) {
	    // 接收位置信息
	    var loc = event.data;
	    if(loc){
			$("#city").val(loc.city);
			$("#lat").val(loc.lat);
			$("#lng").val(loc.lng);
	    }
	    console.log('location', loc);
	}, false)       ;
	
	setTimeout(function() {
	    if (!this.loc) {
	       console.log('定位超时')
	    }
	}, 6000); // 6s为推荐值，业务调用方可根据自己的需求设置改时间，不建议太短
	
</script>
<script type="text/javascript">
//<![CDATA[
var theForm = document.forms['aspnetForm'];
if (!theForm) {
    theForm = document.aspnetForm;
}
function __doPostBack(eventTarget, eventArgument) {
     theForm.submit();
}
//]]>
</script>


<div>

  <input type="hidden" name="city" id="city">
  <input type="hidden" name="lat" id="lat">
  <input type="hidden" name="lng" id="lng">
</div>
  <div class="control-group">
      <input name="phoneNum" type="text" id="phoneNum" class="input width100 " value="${param.phoneNum }" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请输入手机号" />
  </div>
   <div class="control-group">
      <input name="idCard" type="text" id="idCard" class="input width100 "  value="${param.idCard }" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请输入身份证号" />
  </div>
  <div class="control-group">
      <input name="Password" type="password" id="Password" class="width100 input" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请输入密码" />
  </div>
  <div class="control-group">
      <input name="rePassword" type="password" id="rePassword" class="width100 input" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请重新输入密码" />
  </div>
  <div class="control-group" style="color:red" id="message"> ${message }</div>
  <div class="control-group">
   <input name="yzm" type="text" id="yzm" class="width75 input" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请重新输入验证码" />
   <img alt="验证码" src="<%=contxtPath %>/imageCode?t=<%= new Date().getTime() %>" onclick="this.src='<%=contxtPath %>/imageCode?'+ new Date()">
 
  </div>
     <div class="control-group">
       <span class="red"></span>
   </div>
  <div class="control-group">
         <button onClick="__doPostBack('ctl00$ContentPlaceHolder1$btnOK','')" id="ctl00_ContentPlaceHolder1_btnOK" class="btn-large green button width100">立即登陆</button>
  </div>
    <div class="control-group">
  </div>
  <div class="control-group">
        或者使用合作账号一键登录：<br/>
        <a class="servIco ico_qq" href="qlogin.aspx"></a>
        <a class="servIco ico_sina" href="default.htm"></a>
  </div>
</form>
  </div>


<%@include file="../footer.jsp" %>

</body>
</html>
