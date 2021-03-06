<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./header.jsp" %>
<body>
 <div class="header">
 <a href="<%=contxtPath %>/" class="home">
            <span class="header-icon header-icon-home"></span>
            <span class="header-name">主页</span>
</a>
<div class="title" id="titleString">选择城市</div>
<a href="javascript:history.go(-1);" class="back">
            <span class="header-icon header-icon-return"></span>
            <span class="header-name">返回</span>
        </a>
 </div>

        
    <script type="text/javascript" src="<%=contxtPath %>/calendar/touch.js"></script><!--新版zepto合并版中不包括touch.js-->
    <script type="text/javascript" src="<%=contxtPath %>/calendar/highlight.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/gmu.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/event.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/widget.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/calendar.js"></script>
	
    <link rel="stylesheet" type="text/css" href="<%=contxtPath %>/calendar/calendar.css" />
    <link rel="stylesheet" type="text/css" href="<%=contxtPath %>/calendar/calendar.default.css" />

<script type="text/javascript">
	$(function(){
		changeArea("${sessionScope.user.city }");
		 $('#cityname').click(function (e) {
	            $('.citybox').toggle();
	     });

		$("#btnGo").click(function(){
			$('#cityname').text('全部');
			$('.citybox').css("display","block");
			var city = $("#cityChange").val();
		    $.post('<%=contxtPath %>/user/editCity', {cityChange:$("#cityChange").val()}, function(ajaxResult) {
		        if (ajaxResult.status == 'success') {
		        	$("#city").val(city);
		        	$("#cityChange").val('');
		        	$("#citySpan").html('');
		        	$("#citySpan").append(ajaxResult.data);
		        	changeArea(ajaxResult.data);
		        }else{
		        	alert(ajaxResult.data)
		        }
		    }, 'json');
		})
	})
	
	function bindClick(){
        $('.citybox span').click(function (e) {
            $('#cityname').text($(this).text());
            $('.citybox').toggle();
            $('#cityArea').val($(this).text());
        });
	}
	
	function changeArea(city){
	    $.post('<%=contxtPath %>/user/changeArea',{city:city},function(ajaxResult) {
	        if (ajaxResult.status == 'success') {
				$("#area").html('');
				var list = ajaxResult.data;
				if(typeof(list.length)== "undefined"){
					$('#cityname').text("没有下级区域");
					$('#cityArea').val("没有下级区域");
				}
	        	for(var i=0;i<list.length;i++){
		        	$("#area").append("<span cityId="+i+">"+list[i]+"</span>");
	        	}
	        	bindClick();
	        }else{
	        	alert(ajaxResult.data)
	        }
	    }, 'json');
	}
		
	
</script>
	
<div class="container width90 pt20">
 <form action="<%=contxtPath %>/hotel/hotelList" method="get" id="form1">
<ul class="search-group unstyled">
	  <style type="text/css">
        .section {
            background: #f3f3f3;
            font-size: 14px;
        }
        #datepicker_wrap {
            overflow: hidden;
            height: 0;
            -webkit-transition: height 200ms ease-in-out;
            background: #e1e1e1;
            -webkit-box-sizing:border-box;
            box-sizing:border-box;
        }
        #datepicker_wrap>div {
            display: none;
            padding: 5px 5px 25px 5px;
        }

        .filter {
            padding: 10px;
        
        }
        .filter:after {
            content: '\0020';
            clear: both;
            display: block;
            height: 0;
            font-size: 0;
            line-height: 0;
        }

        a.datebox {
            border: 1px solid #e1e1e1;
            text-decoration: none;
            color: #000;
            padding: 5px 26px 5px 5px;
            margin: 0px 5px 0 0;
            position: relative;
            background: #fff;
            top: 5px;
        }

       .ui-icon-down {
            position: absolute;
            top: 50%;
            right: 5px;
            background-image: url("http://gmu.baidu.com/demo/assets/icons-36-black.png");
            -webkit-background-size: 776px 18px;
            background-size: 776px 18px;
            width:18px;
            height: 18px;
            margin-top: -9px;
            background-position: 	-216px 50%;
        }
        .filter a.ui-state-active, .filter a.ui-state-hover {
            background: #fff;
        }
        .filter a.ui-state-active .ui-icon-down, .filter a.ui-state-hover .ui-icon-down {
            background-position: 	-180px 50%;
        }

        .filter a.search {
            float: right;
            padding: 5px;
            margin: 0;
        }
        .result {
            padding: 15px;
            text-align: left;
        }
    </style>	
    			<li class="control-group" >
    				 <input name="cityChange" type="text" id="cityChange" class="width80 input " style="background: none repeat scroll 0 0 #F9F9F9;padding: 8px 0px 8px 4px;" placeholder="切换城市" />
    				 <span class="input-group-btn">
				        <button class="btn btn-default" type="button" id="btnGo">Go!</button>
				     </span>
				     <div style="height:10px"></div>
    			</li>
    			
    			<li>
    				<span class="search-icon location-icon"></span>
				    <span class="coupon-label">选择城市：</span>
				    <span class="coupon-input"><span style="font-size: 16px; line-height: 35px;" ><span style="color:red;font-size: 18px;" id="citySpan">${sessionScope.user.city }</span></span></span></span>
    			</li>
    			    			
				<li>
					<div class="coupon-nav coupon-nav-style">
						<span class="search-icon location-icon"></span>
						<span class="coupon-label">选择市区：</span>
					    <span class="coupon-input"> <span style="font-size: 16px; line-height: 35px;" id="cityname">全部</span></span>
					</div>
                   <div class="citybox" id="area">
                      <span cityId="0">全部</span> 
                   </div>
				</li>
			<li>
					<div class="coupon-nav coupon-nav-style">
						<span class="search-icon time-icon"></span>
						<span class="coupon-label">入住日期：</span>
					    <span class="coupon-input"><a id="datestart" class="datebox" href="javascript:void(0)"><span class="ui-icon-down"></span></a></span>
					</div>
                    <div id="dp_start" class="none">
                     <div id="datepicker_start"></div>
                     </div>
				</li>
                  <li>
					<div class="coupon-nav coupon-nav-style">
						<span class="search-icon time-icon"></span>
						<span class="coupon-label">离店日期：</span>
					    <span class="coupon-input"><a id="dateend"  class="datebox"  href="javascript:void(0)"><span class="ui-icon-down"></span></a></span>
					</div>
                    <div id="dp_end" class="none">
                     <div id="datepicker_end"></div>
                     </div>
				</li>
   
                </ul>
                <%
                	Date now = new Date();
                	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                	String formatDate = format.format(now);
                	
                	 Calendar c = Calendar.getInstance();
                     c.setTime(now);
                     c.add(Calendar.DAY_OF_MONTH, 1);
                     Date tomorrow = c.getTime();
                     String formatTomorrow =  format.format(tomorrow);
                %>
                 <input id="checkInDate" name="checkInDate" value="<%=formatDate %>" type="hidden" />
                 <input id="checkOutDate" name="checkOutDate" value="<%=formatTomorrow %>" type="hidden" />
                 <input id="cityArea" name="cityArea" value="全部" type="hidden" />
                 <input id="city" name="city" value="${sessionScope.user.city}" type="hidden"/>
<script type="text/javascript">
    (function ($, undefined) {
        $(function () {//dom ready
            var open = null, today = new Date();
            var beginday = '<%=formatDate%>';
            var endday = '<%=formatTomorrow%>';
            //设置开始时间为今天
            $('#datestart').html(beginday + '<span class="ui-icon-down"></span>');
            //设置结束事件
            $('#dateend').html(endday +
                '<span class="ui-icon-down"></span>');
            $('#datepicker_start').calendar({//初始化开始时间的datepicker
                date: $('#datestart').text(), //设置初始日期为文本内容
                minDate: new Date(today.getFullYear(), today.getMonth(), today.getDate()), //设置最小日期为当月第一天，既上一月的不能选
                maxDate: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 25), //设置最大日期为结束日期，结束日期以后的天不能选
                select: function (e, date, dateStr) {//当选中某个日期时。
                    var day1 = new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1);
                    $('#datepicker_end').calendar('minDate', day1).calendar('refresh'); //将结束时间的datepick的最小日期设成所选日期
                    $('#dp_start').toggle();
                    //把所选日期赋值给文本
                    $('#datestart').html(dateStr + '<span class="ui-icon-down"></span>').removeClass('ui-state-active');
                    $('#checkInDate').val(dateStr);
                    
                    $('#dateend').html($.calendar.formatDate(day1) + '<span class="ui-icon-down"></span>').removeClass('ui-state-active');
                    $('#checkOutDate').val($.calendar.formatDate(day1));
                }
            });
            $('#datepicker_end').calendar({//初始化结束时间的datepicker
                date: $('#dateend').text(), //设置初始日期为文本内容
                minDate: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1),
                maxDate: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 16),
                select: function (e, date, dateStr) {//当选中某个日期时。
                    //收起datepicker
                    open = null;
                    $('#dp_end').toggle();
                    //把所选日期赋值给文本
                    $('#dateend').html(dateStr + '<span class="ui-icon-down"></span>').removeClass('ui-state-active');
                    $('#checkOutDate').val(dateStr);
                }
            });
            $('#datestart').click(function (e) {//展开或收起日期
                $('#datestart').removeClass('ui-state-active');
                var type = $(this).addClass('ui-state-active').is('#datestart') ? 'start' : 'end';
                $('#dp_start').toggle();

            }).highlight('ui-state-hover');
            $('#dateend').click(function (e) {//展开或收起日期
                $('#dateend').removeClass('ui-state-active');
                var type = $(this).addClass('ui-state-active').is('#dateend') ? 'start' : 'end';
                $('#dp_end').toggle();

            }).highlight('ui-state-hover');
        });
    })(Zepto);
</script>
  <div class="control-group tc">
         <button  class="btn-large green button width80" style="padding-left:0px;padding-right: 0px;" id="btnOK" ><span style="color:blue;">立即查找</span></button>
  </div>
  <div class="control-group tc">
         <a href="<%=contxtPath %>/hotel/nearHotel" style="padding-left:0px;padding-right: 0px;"  class="btn-large green button width80">附近酒店</a>
  </div>
 	</form>
 </div>


<%@include file="./footer.jsp" %>

</body>
</html>
