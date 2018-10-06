<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

        
    <script type="text/javascript" src="<%=contxtPath %>/calendar/touch.js"></script><!--新版zepto合并版中不包括touch.js-->
    <script type="text/javascript" src="<%=contxtPath %>/calendar/highlight.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/gmu.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/event.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/parseTpl.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/widget.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/calendar/calendar.js"></script>
    <script type="text/javascript" src="<%=contxtPath %>/dialog/dialog.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=contxtPath %>/calendar/calendar.css" />
    <link rel="stylesheet" type="text/css" href="<%=contxtPath %>/calendar/calendar.default.css" />
    <link rel="stylesheet" type="text/css" href="<%=contxtPath %>/dialog/dialog.css" />
    <link rel="stylesheet" type="text/css" href="<%=contxtPath %>/dialog/dialog.default.css" />
    <style>
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
            padding:10px 10px 0px;
        
        }
        .filter:after {
            content: '\0020';
            clear: both;
            display: block;
            height: 0;
            font-size: 0;
            line-height: 0;
        }

        .filter a {
            border: 1px solid #e1e1e1;
            text-decoration: none;
            color: #000;
            padding: 5px 26px 5px 5px;
            margin: 0 5px 0 0;
            position: relative;
            background: #fff;
        }
        .icon-down {
            background-image: url("http://gmu.baidu.com/demo/assets/icons-36-black.png");
            background-position: 	-216px 50%;
             width:18px;
            height: 18px;
            display: inline-block;
            -webkit-background-size: 776px 18px;
            background-size: 776px 18px;
            float: right;
              margin-top: 10px;
        }
        .icon-down-up {
            background-position: 	-180px 50%;
        }
        .filter a .ui-icon-down {
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
            padding:10px 15px;
            text-align: left;
        }
    </style>
 <div class="container">
<ul class="unstyled hotel-bar">
			<li class="first">
           <a href="#BookRoom"  class="active">房型</a>
			</li>
			<li><a href="HotelInfo.aspx.html">简介</a></li>
			<li><a href="#">地图</a></li>
			<li><a href="Hotelreview.aspx.html">评论</a></li>
</ul>
 <div id="BookRoom" class="tab-pane active fade in">   
<div class="detail-address-bar">
	<img alt="" src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/map.jpg">
	<p>${hotel.address}</p>
</div>     
<div id="datetab" class="detail-time-bar">
	<img alt="" src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/calendar.jpg">
	<p>${checkInDate } - ${checkOutDate }</p>
   <span class="icon-down"></span>
</div>  
<form id="change" action="<%=contxtPath %>/hotel/detail" method="post">
<div id="datebox" class="section none">
   <div class="filter clearfix">
       <p style="margin-bottom: 10px;display: block;">入住：<a id="datestart" href="javascript:void(0)"><span class="ui-icon-down"></span></a></p>
     <br/>
     <p>  离开：<a id="dateend" href="javascript:void(0)"><span class="ui-icon-down"></span></a></p>
   </div>
   <div id="datepicker_wrap">
       <div id="dp_start">
           <p>入住时间：</p>
           <div id="datepicker_start"></div>
       </div>
       <div id="dp_end">
           <p>离开时间：</p>
           <div id="datepicker_end"></div>
       </div>
   </div>
   <div class="result">
       <input id="timeChange" type="submit" class="btn" value="确定修改" />
       <span class="btn" id="datecancel">取消</span>
   </div>
    <input id="hotelId" name="hotelId" type="hidden" value="${hotel.id }" />
    <input id="checkInDate" name="checkInDate" type="hidden" value="${checkInDate }" />
    <input id="checkOutDate" name="checkOutDate" type="hidden" value="${checkOutDate }" />
</div>
</form>  
<script type="text/javascript">
    (function ($, undefined) {
        $(function () { //dom ready
        	$("#timeChange").click(function(){
				var checkInDate = $("#datestart").html();
				var checkOutDate = $("#dateend").html();
				$("#checkInDate").val(checkInDate);
				$("#checkOutDate").val(checkOutDate);
        	})
            $('#titleString').text($(document)[0].title);
            $('#datetab').click(function () {
                $('#datebox').toggle();
                $('.icon-down').toggleClass('icon-down-up');
            });
            $('#datecancel').click(function () {
                $('#datebox').hide();
            });
         
           
            var open = null, today = new Date();
            var beginday = '${checkInDate}';
            var endday = '${checkOutDate}';
            //设置开始时间为今天
            $('#datestart').html(beginday + '<span class="ui-icon-down"></span>');

            //设置结束事件
            $('#dateend').html(endday +
                '<span class="ui-icon-down"></span>');

            $('#datepicker_start').calendar({
                //初始化开始时间的datepicker
                date: $('#datestart').text(), //设置初始日期为文本内容
                minDate: new Date(today.getFullYear(), today.getMonth(), today.getDate()), //设置最小日期为当月第一天，既上一月的不能选
                maxDate: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 25), //设置最大日期为结束日期，结束日期以后的天不能选
                select: function (e, date, dateStr) { //当选中某个日期时。
                    var day1 = new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1);
                    $('#datepicker_end').calendar('minDate', day1).calendar('refresh'); //将结束时间的datepick的最小日期设成所选日期
                    //收起datepicker
                    open = null;
                    $('#datepicker_wrap').height(0).children().hide();
                    //把所选日期赋值给文本
                    $('#datestart').html(dateStr + '<span class="ui-icon-down"></span>').removeClass('ui-state-active');
                    $('#checkInDate').val(dateStr);

                    $('#dateend').html($.calendar.formatDate(day1) + '<span class="ui-icon-down"></span>').removeClass('ui-state-active');
                    $('#checkOutDate').val($.calendar.formatDate(day1));
                }
            });
            $('#datepicker_end').calendar({
                //初始化结束时间的datepicker
                date: $('#dateend').text(), //设置初始日期为文本内容
                minDate: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1),
                maxDate: new Date(today.getFullYear(), today.getMonth(), today.getDate() + 16),
                select: function (e, date, dateStr) { //当选中某个日期时。
                    $('#datepicker_start').calendar('maxDate', date).calendar('refresh'); //将开始时间的datepicker的最达日期设成所选日期
                    //收起datepicker
                    open = null;
                    $('#datepicker_wrap').height(0).children().hide();
                    //把所选日期赋值给文本
                    $('#dateend').html(dateStr + '<span class="ui-icon-down"></span>').removeClass('ui-state-active');
                    $('#checkOutDate').val(dateStr);
                }
            });
            $('.roompic').click(function () {

                var dialog4 = gmu.Dialog({
                    width: 300,
                    height: 300,
                    autoOpen: false,
                    closeBtn: false,
                    buttons: {
                        '取消': function () {
                            this.close();
                        }
                    },
                    content: '<img style="height:200px;width:250px" src="' + $(this).attr('bigsrc') + '"/>'
                });
                dialog4.open();
            });

            $('#datestart, #dateend').click(function (e) { //展开或收起日期
                $('#datestart, #dateend').removeClass('ui-state-active');
                var type = $(this).addClass('ui-state-active').is('#datestart') ? 'start' : 'end';
                if (open && open != type) {
                    $('#dp_' + open).hide();
                    open = type;
                    $('#dp_' + open).show();
                } else if (open) {
                    $('#date' + open).removeClass('ui-state-active');
                    open = null;
                    $('#datepicker_wrap').height(0);
                } else {
                    open = type;
                    $('#datepicker_wrap').height($('#dp_start, #dp_end').hide().filter('#dp_' + open).show().height());
                }
            }).highlight('ui-state-hover');
        });
    })(Zepto);
</script>
<ul class="unstyled roomlist">
    

 	<c:forEach items="${roomList }" var="room">  		
	     <li>
	        <div class="roomtitle">
	        <div class="roomname">${room.roomName }</div>
	          
	        <div class="fr">
	          <em class="orange roomprice">
	              ￥${room.price } 起
	         </em>
	        <c:forEach items="${roomResultList }" var="roomResult">
	        	<c:if test="${roomResult.roomId eq room.id }">
	        		<c:if test="${roomResult.havePeople}">
						<a href='<%=contxtPath %>/room/order?hotelId=${hotel.id }&roomId=${room.id }&checkInDate=${checkInDate }&checkOutDate=${checkOutDate}' title='立即预定' class='btn btn-success iframe'>预定</a>
	        		</c:if>
	        		<c:if test="${ not roomResult.havePeople}">
	        			<span class='btn'>满房</span>
	        		</c:if>
	        	</c:if>
	        </c:forEach>
			</div>
	        </div>
	        
	                     <a class="fl roompic" bigsrc="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/298b5300-9410-49a6-954f-08924559e068.jpg">
	                            <img title="秀灵上下铺" 
	                         		src="https://upload-lsp.oss-cn-hangzhou.aliyuncs.com/298b5300-9410-49a6-954f-08924559e068.jpg"></a>
	                    
	    </li>  
 	</c:forEach>	   
</ul>
<div style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);" class="hotel-prompt">
			<span class="hotel-prompt-title" id="digxx">特别提示</span>
			<p>最早入住时间为中午12：00，如需提前入住请联系客服。</p>
		</div>
</div> 


	</div>


<%@include file="../footer.jsp" %>

</body>
</html>
