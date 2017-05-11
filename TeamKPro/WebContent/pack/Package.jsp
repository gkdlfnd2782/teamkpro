<%@page import="javax.websocket.Session"%>
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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="./js/jquery-3.2.0.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
	jQuery(document).ready(function($){
		
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
		
		$('ul li.tab_color').click(function() {
			$('.tab_color').css("background-color", "white");  //탭부분 배경색 하얀색으로
			$(".tab_content").hide();					// 탭 내용 전체 숨김
			$(this).css("background-color", "#BDBDBD");		// 클릭된 탭부분 배경색 #BDBDBD으로
			var activeTab = $(this).attr("name");		// 클릭된 탭부분 name 속성값 가져와서 저장
			$("#" + activeTab).fadeIn();		// 해당 탭내용 부분을 보여준다  흐릿 -> 또렷하게 애니메이션 효과			
		});


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

#package_tab
{
	margin : 0 auto;
	margin-top : 50px;
	width : 785px;
	height : 630px;
	border : 1px solid blue;
}



ul.tabs {
	margin: 0;
	padding: 0;
	width: 785px;
	height: 32px;
	float: left;
	list-style: none;
	border: 1px solid black;
	border-bottom: none;
	border-right: none;
}

ul.tabs li {
	width: 73px;
 	height: 32px;
	float: left;
	border-right: 1px solid black;
	text-align: center;
	cursor: pointer;
	font-weight: bold;
	line-height: 31px;
}

.tab_container {
	border: 1px solid black;
	float: left;
	min-width: 730px;
	min-height: 600px;
	padding : 10px;
	margin : 0 auto;
}

.img_size
{
	width : 250px;
	height : 150px;
	border: 1px solid pink;
}


#img_content
{
	padding-top : 10px;
	padding-left: 10px;
}

/* 탭 패키지  */


.clear {
	clear: both;
}


</style>

</head>
<body>
<!-- 왼쪽 메뉴 -->
<jsp:include page="../leftMenu.jsp"></jsp:include>
<!-- 왼쪽 메뉴 -->
<%

	// 세션으로 로그인한 아이디 값 받아오기
// 	String session_id = (String) session.getAttribute("id");
	String session_id = "admin";

	// 각 탭에 들어갈 내용 받아옴
	List List1 = (List)request.getAttribute("list1");
	List List2 = (List)request.getAttribute("list2");
	List List3 = (List)request.getAttribute("list3");
	List List4 = (List)request.getAttribute("list4");
	List List5 = (List)request.getAttribute("list5");
	List List6 = (List)request.getAttribute("list6");
	List List7 = (List)request.getAttribute("list7");
	
	int count = ((Integer)request.getAttribute("count")).intValue();
	String pageNum = (String)request.getAttribute("pageNum");
	int pageCount = ((Integer)request.getAttribute("pageCount")).intValue();
	int pageBlock = ((Integer)request.getAttribute("pageBlock")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();

	
%>

<div id="wrap">
	<!--여행지 검색창 -->
	<div id = "search_div">
		<form action="./PackSearchAction.po" name="fr" method="get" onsubmit="return input_chk()">
			<table>
				<tr>
					<td>여행지</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" id="city_search" name="city" class="input_style" required="yes" placeholder="도시를 입력해주세요"></td>
				</tr>
				<tr>
					<td>시작날</td>
					<td>끝나는날</td>
				</tr>
				<tr>
					<td><input type="text" id="date_from" class="input_style" name="startDate" required="yes"></td>
					<td><input type="text" id="date_to" class="input_style" name="endDate" required="yes"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="검색" id="search_btn" class="input_style"></td>
				</tr>
			</table>
		</form>
	</div>
	<!--여행지 검색창 -->
	
	<div id="package_tab">
		<form action="./Package.po" method="get" id="pf">
		<!-- 탭 부분 -->
		<ul class="tabs">
			<li name="tab1" class="tab_color" style="background-color: #BDBDBD;" value="서울">서울</li>
			<li name="tab2" class="tab_color" value="경기도">경기도</li>
			<li name="tab3" class="tab_color" value="경상도">경상도</li>
			<li name="tab4" class="tab_color">전라도</li>
			<li name="tab5" class="tab_color">충청도</li>
			<li name="tab6" class="tab_color">강원도</li>
			<li name="tab7" class="tab_color">제주도</li>
		</ul>
		<!-- 탭 부분 -->
		</form>
		<div class="clear"></div>
		
		<!-- 탭 내용 -->
		<div class="tab_container">   
			<div id="tab1" class="tab_content">서울입니당
			<table>
			<%
			PackBean pb;
			if (count!=0)
			{
				for (int i = 0; i <List1.size(); i++)
				{
					pb =(PackBean)List1.get(i);
			%>		
					<td>
						<div>
							<a href="./PackContent.po?num=<%=pb.getNum() %>">
							<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
							<div id="img_content">
								<b><%=pb.getSubject() %></b>
								<p><%=pb.getIntro() %></p>
								<b><%=pb.getCost() %></b>
							</div>
							</a>
						</div>
					</td>
					
				<%
					if (i == 2 || i == 5)
					{
					%>
							<tr>
							</tr>
					<%
					}
				}
			}
				%>
			</table>
			</div>
			<div id="tab2" class="tab_content">경기도입니당
			<table>
				<%
				if (count!=0)
				{
					for (int i = 0; i <List2.size(); i++)
					{
						pb =(PackBean)List2.get(i);
				%>		
						<td>
							<div>
								<a href="./PackContent.po?num=<%=pb.getNum() %>">
								<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
								<div id="img_content">
									<b><%=pb.getSubject() %></b>
									<p><%=pb.getIntro() %></p>
									<b><%=pb.getCost() %></b>
								</div>
								</a>
							</div>
						</td>
						
					<%
						if (i == 2 || i == 5)
						{
						%>
								<tr>
								</tr>
						<%
						}
					}
				}
				%>
			</table>
			</div>
			<div id="tab3" class="tab_content">경상도다 임마
			<table>
				<%
				if (count!=0)
				{
					for (int i = 0; i <List3.size(); i++)
					{
						pb =(PackBean)List3.get(i);
				%>		
						<td>
							<div>
								<a href="./PackContent.po?num=<%=pb.getNum() %>">
								<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
								<div id="img_content">
									<b><%=pb.getSubject() %></b>
									<p><%=pb.getIntro() %></p>
									<b><%=pb.getCost() %></b>
								</div>
								</a>
							</div>
						</td>
						
					<%
						if (i == 2 || i == 5)
						{
						%>
								<tr>
								</tr>
						<%
						}
					}
				}
				%>
			</table>
			</div>
			<div id="tab4" class="tab_content">거시기 여기가 전라도왔구마잉
			<table>
				<%
				if (count!=0)
				{
					for (int i = 0; i <List4.size(); i++)
					{
						pb =(PackBean)List4.get(i);
				%>		
						<td>
							<div>
								<a href="./PackContent.po?num=<%=pb.getNum() %>">
								<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
								<div id="img_content">
									<b><%=pb.getSubject() %></b>
									<p><%=pb.getIntro() %></p>
									<b><%=pb.getCost() %></b>
								</div>
								</a>
							</div>
						</td>
						
					<%
						if (i == 2 || i == 5)
						{
						%>
								<tr>
								</tr>
						<%
						}
					}
				}
				%>
			</table>
			
			</div>
			<div id="tab5" class="tab_content">충청도엔 무슨 일이여~
			<table>
				<%
				if (count!=0)
				{
					for (int i = 0; i <List5.size(); i++)
					{
						pb =(PackBean)List5.get(i);
				%>		
						<td>
							<div>
								<a href="./PackContent.po?num=<%=pb.getNum() %>">
								<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
								<div id="img_content">
									<b><%=pb.getSubject() %></b>
									<p><%=pb.getIntro() %></p>
									<b><%=pb.getCost() %></b>
								</div>
								</a>
							</div>
						</td>
						
					<%
						if (i == 2 || i == 5)
						{
						%>
								<tr>
								</tr>
						<%
						}
					}
				}
				%>
			</table>
			</div>
			<div id="tab6" class="tab_content">감자묵어봤나?
			<table>
				<%
				if (count!=0)
				{
					for (int i = 0; i <List6.size(); i++)
					{
						pb =(PackBean)List6.get(i);
				%>		
						<td>
							<div>
								<a href="./PackContent.po?num=<%=pb.getNum() %>">
								<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
								<div id="img_content">
									<b><%=pb.getSubject() %></b>
									<p><%=pb.getIntro() %></p>
									<b><%=pb.getCost() %></b>
								</div>
								</a>
							</div>
						</td>
						
					<%
						if (i == 2 || i == 5)
						{
						%>
								<tr>
								</tr>
						<%
						}
					}
				}
				%>
			</table>
			</div>
			<div id="tab7" class="tab_content">혼저옵서예
			<table>
				<%
				if (count!=0)
				{
					for (int i = 0; i <List7.size(); i++)
					{
						pb =(PackBean)List7.get(i);
				%>		
						<td>
							<div>
								<a href="./PackContent.po?num=<%=pb.getNum() %>">
								<img class="img_size" alt="" src="./writeAPI/upload/<%=pb.getFile1() %>">
								<div id="img_content">
									<b><%=pb.getSubject() %></b>
									<p><%=pb.getIntro() %></p>
									<b><%=pb.getCost() %></b>
								</div>
								</a>
							</div>
						</td>
						
					<%
						if (i == 2 || i == 5)
						{
						%>
								<tr>
								</tr>
						<%
						}
					}
				}
				%>
			</table>
			</div>
		</div>
		<!-- 탭 내용 -->
	</div>
	<%
		if (session_id.equals("admin"))
		{
	%>
	<input type="button" value="글쓰기" onclick="location.href='./PackWrite.po'">
	<%
		}
	%>
</div>
<!-- 오른쪽 메뉴 -->
<jsp:include page="../rightMenu.jsp"></jsp:include>
<!-- 오른쪽 메뉴 -->
</body>
</html>