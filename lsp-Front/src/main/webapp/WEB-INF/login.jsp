<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>仿格子微酒店触屏版html5手机wap旅游网站模板下载登陆</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<link href="styles/bootstrap.min.css" rel="stylesheet" />
<link href="styles/NewGlobal.css" rel="stylesheet" />

<script type="text/javascript" src="Scripts/zepto.js"></script>

</head>
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
 <form name="aspnetForm" method="post" action="login.aspx?ReturnUrl=%2fMember%2fDefault.aspx" id="aspnetForm" class="form-horizontal">
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
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
//]]>
</script>


<div>

	<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEWBQLZmqilDgLJ4fq4BwL90KKTCAKqkJ77CQKI+JrmBdPJophKZ3je4aKMtEkXL+P8oASc" />
</div>
  <div class="control-group">
      <input name="ctl00$ContentPlaceHolder1$txtUserName" type="text" id="ctl00_ContentPlaceHolder1_txtUserName" class="input width100 " style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="请输入手机号/身份证/会员卡号" />
  </div>
  <div class="control-group">
      <input name="ctl00$ContentPlaceHolder1$txtPassword" type="password" id="ctl00_ContentPlaceHolder1_txtPassword" class="width100 input" style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px" placeholder="默认密码为证件号后4位" />
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
         还没账号？<a href="Reg.aspx@ReturnUrl=_252fMember_252fDefault.aspx" id="ctl00_ContentPlaceHolder1_RegBtn">立即免费注册</a>
  </div>
  <div class="control-group">
        或者使用合作账号一键登录：<br/>
        <a class="servIco ico_qq" href="qlogin.aspx"></a>
        <a class="servIco ico_sina" href="default.htm"></a>
  </div>
</form>
  </div>


  <div class="footer">
  <div class="gezifooter">
      
      <a href="login.aspx" class="ui-link">立即登陆</a> <font color="#878787">|</font> 
       <a href="reg.aspx" class="ui-link">免费注册</a> <font color="#878787">|</font>                 
                  

       <a href="../www.gridinn.com/@display=pc" class="ui-link">电脑版</a>
  </div>
  <div class="gezifooter">
    <p style="color:#bbb;">格子微酒店连锁 &copy; 版权所有 2012-2014</p>
  </div>
  </div>

</body>
</html>
