<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="net.pack.db.PackDAO" %>
    <%@ page import="net.pack.db.PackBean" %>
    <%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="./js/jquery-3.2.0.js"></script>
<script>
	$(document).ready(function(){
		
		
		// 달력 관련 소스
		$("#date_from").datepicker({
			dateFormat: 'yy-mm-dd',    // 날짜 포맷 형식
			minDate : 0,			   // 최소 날짜 설정      0이면 오늘부터 선택 가능
			numberOfMonths: 2,		   // 보여줄 달의 갯수
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],  // 일(Day) 표기 형식
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],   // 월(Month) 표기 형식
	        showOn: "both",		// 버튼을 표시      both : input과 buttom 둘다 클릭 시 달력 표시           bottom  :  buttom 클릭 했을 때만 달력 표시
	        buttonImage: "./images/calendar.png",   // 버튼에 사용될 이미지
	        buttonImageOnly: true,					// 이미지만 표시한다    버튼모양 x
	        onClose: function(selectedDate){		// 닫힐 때 함수 호출
	        	$("#date_to").datepicker("option", "minDate", selectedDate);    // #date_to의 최소 날짜를 #date_from에서 선택된 날짜로 설정
	    		$('img.ui-datepicker-trigger').attr('align', 'absmiddle');
	        	}
		});
		
		
		$("#date_to").datepicker({
			dateFormat: 'yy-mm-dd',    // 날짜 포맷 형식
			numberOfMonths: 2,		   // 보여줄 달의 갯수
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],  // 일(Day) 표기 형식
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],   // 월(Month) 표기 형식
	        showOn: "both",			// 버튼을 표시      both : input과 buttom 둘다 클릭 시 달력 표시           bottom  :  buttom 클릭 했을 때만 달력 표시
	        buttonImage: "./images/calendar.png",   // 버튼에 사용될 이미지
	        buttonImageOnly: true,					// 이미지만 표시한다    버튼모양 x
	        onClose: function(selectedDate){		// 닫힐 때 함수 호출
	        	$("#date_from").datepicker("option", "maxDate", selectedDate);   // #date_from의 최대 날짜를 #date_to에서 선택된 날짜로 설정
	    		$('img.ui-datepicker-trigger').attr('align', 'absmiddle');
	        	}
		});
		
	    $("#txt_prodStart").datepicker();
	    $('img.ui-datepicker-trigger').attr('align', 'absmiddle');
	    
	    
	    
	    
	    // 탭 관련 소스
		$(".tab_content").hide();  // 탭 내용 전체 숨김
		$(".tab_content:first").show();  // 탭 첫번째 내용만 보이게
		
		$('ul li').click(function() {
			$('.tab_color').css("background", "white");  //탭부분 배경색 하얀색으로
			$(".tab_content").hide();					// 탭 내용 전체 숨김
			$(this).css("background", "#BDBDBD");		// 클릭된 탭부분 배경색 #BDBDBD으로
			var activeTab = $(this).attr("name");		// 클릭된 탭부분 name 속성값 가져와서 저장
			$("#" + activeTab).show();					// 해당 탭내용 부분을 보여준다
		});
		
		
		
		function input_chk()
		{
			var city = $("#city_search").val();
			var date_f = $("#date_from").val();
			var date_t = $("#date_to").val();
			
			if(city == "")
			{
				alert("도시명을 입력해주세요");
				return false;
			}
			else if(date_f == "")
			{
				alert("날짜를 입력해주세요");
				return false;
			}
			else if(date_t == "")
			{
				alert("날짜를 입력해주세요");
				return false;
			}
			return false;
		}
		
		
	});
	
	
	
</script>

<style type="text/css">

img.ui-datepicker-trigger
{
	cursor : pointer;
	margin-left : 5px;
}



#wrap
{
	width : 1000px;
	min-height : 1000px;
	border : 1px solid black;
	margin : 0 auto;
	padding-top : 50px;
}


/* 검색  */

#search_div
{
	width : 450px;
	height : 200px;
	padding : 10px;
	background-color: #D6F0FF;
	margin : 0 auto;
}

#city_search
{
	width : 430px;
}


.input_style
{
	height : 25px;
	margin-bottom : 10px;
	padding-left : 10px;
	border-radius : 1px;
}

#search_btn
{
	cursor : pointer;
	width : 200px;
	height : 35px;
	margin-left : 100px;
	background-color: #B2CCFF;
}
/* 검색  */





/* 탭 패키지  */

#package_result
{
	margin : 0 auto;
	margin-top : 50px;
	width : 785px;
	height : 630px;
	border : 1px solid blue;
}

.img_size
{
	width : 200px;
	height: 150px;
}



#search_result #img_content
{
	float: left;
}
/* 탭 패키지  */

.clear {
	clear: both;
}




</style>
</head>
<body>
<%

	List list = (List)request.getAttribute("list");
	
	int count = ((Integer)request.getAttribute("count")).intValue();
	String pageNum = (String)request.getAttribute("pageNum");
	int pageCount = ((Integer)request.getAttribute("pageCount")).intValue();
	int pageBlock = ((Integer)request.getAttribute("pageBlock")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	
	String search = (String)request.getAttribute("search");
	String startDate = (String)request.getAttribute("startDate");
	String endDate = (String)request.getAttribute("endDate");

%>

<div id="wrap">
	<div id = "search_div">
		<form action="./PackSearchAction.po" name="fr" method="get" onsubmit="return input_chk()">
			<table>
				<tr>
					<td>여행지</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" value="<%=search %>" id="city_search" name="city" class="input_style" required="yes" placeholder="도시를 입력해주세요"></td>
				</tr>
				<tr>
					<td>시작날</td>
					<td>끝나는날</td>
				</tr>
				<tr>
					<td><input type="text" id="date_from" class="input_style" name="startDate" required="yes" value="<%=startDate%>"></td>
					<td><input type="text" id="date_to" class="input_style" name="endDate" required="yes" value="<%=endDate%>"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="검색" id="search_btn" class="input_style"></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="package_result">
	
		<p>검색조건에 해당하는 상품이 총 <%=count %>개 있습니다</p>
		<hr>		
		<table>
		<%
		
		PackBean pb;
		if (count!=0)
		{
			for (int i = 0; i <list.size(); i++)
			{
				pb =(PackBean)list.get(i);
		%>		<tr>
					<td>
						<div>
							<a href="./PackContent.po?num=<%=pb.getNum() %>">
							<img class="img_size" alt="" src="./images/<%=pb.getFile1() %>">
								<b><%=pb.getSubject() %></b>
								<span><%=pb.getIntro() %></span>
								<b><%=pb.getCost() %></b>
							</a>
						</div>
					</td>
				</tr>
		<%
			}
		}
		%>
		</table>
	</div>
</div>
</body>
</html>