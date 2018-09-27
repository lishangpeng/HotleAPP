<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<body>
 <div class="header">
 <a href="<%=contxtPath %>/" class="home">
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
 <form name="aspnetForm" method="post" action="<%=contxtPath %>/user/login" id="aspnetForm" class="form-horizontal">
<div>
<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKLTE4MTUwOTMzMA9kFgJmD2QWAgIBD2QWAgIBD2QWAgILDxYCHgRocmVmBSwvUmVnLmFzcHg/UmV0dXJuVXJsPSUyZk1lbWJlciUyZkRlZmF1bHQuYXNweGQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFJmN0bDAwJENvbnRlbnRQbGFjZUhvbGRlcjEkY2JTYXZlQ29va2ll5P758eqt18XT06y04yVxkKJyzYw=" />
</div>

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


  <div class="control-group">
      <input name="info" type="text" id="info" class="input width100 " style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请输入手机号/身份证" />
  </div>
  <div class="control-group">
      <input name="password" type="password" id="password" class="width100 input" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请输入密码" />
  </div>
  
    <div class="control-group">
      <span style="color:red" class="width100 span"> ${message }</span>
  </div>
  <div class="control-group">
   
      <label class="checkbox fl">
          <input name="ctl00$ContentPlaceHolder1$cbSaveCookie" type="checkbox" id="ctl00_ContentPlaceHolder1_cbSaveCookie" style="float: none;margin-left: 0px;" /> 记住账号
      </label>
     <a class="fr" href="GetPassword.aspx">忘记密码？</a>
 
  </div>
     <div class="control-group">
       <span class="red"></span>
   </div>
  <div class="control-group">
         <button onClick="__doPostBack('ctl00$ContentPlaceHolder1$btnOK','')" id="ctl00_ContentPlaceHolder1_btnOK" class="btn-large green button width100">立即登陆</button>
  </div>
    <div class="control-group">
         还没账号？<a href="<%=contxtPath%>/user/register" id="ctl00_ContentPlaceHolder1_RegBtn">立即免费注册</a>
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
