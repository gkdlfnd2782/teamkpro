<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.pack.db.PackDAO"%>
<%@ page import="net.pack.db.PackBean"%>
<%@ page import="java.util.List"%>
<%@ page import="net.reply.db.ReplyDAO"%>
<%@ page import="net.reply.db.ReplyBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="./js/jquery-3.2.0.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>
<%
	PackBean PB = (PackBean) session.getAttribute("PackBean");
	//sdf
%>
<body>
	<h3>My Google Maps Demo</h3>

	<script>

	// 찜하기, 예약하기 버튼 클릭 시 각각 버튼 마다 이동할 페이지
	function submit_fun(i)
	{
		if (i == 1)
		{
			document.fr.action = "selectTest.jsp";  // 찜하기
		}
		if (i == 2)
		{
			document.fr.action = "selectTest1.jsp";  // 예약하기
		}
	}
	
	
	// 주변 명소, 주변 맛집 클릭 시  검색할 값을 구글맵으로 보낸다
	// 현재 페이지의 City, Sarea 값을 가져온다
	var value="<%=PB.getCity()%> <%=PB.getSarea()%>";
	jQuery(document).ready(function($){
		$('#middle2 input').click(function(){  // 주변명소, 주변맛집  버튼 클릭 시 이벤트 발생
	
	   		var btn = $(this).attr("value");   // 클릭된 버튼의 value 값을 가져온다
			
	   		if (btn == "주변 명소")
			{
				value = "<%=PB.getCity()%> " + "<%=PB.getSarea()%> " + btn;   
				// ex) value = 부산 해운대 주변 명소
			}
			else if (btn == "주변 맛집")
			{
				value = "<%=PB.getCity()%> " + "<%=PB.getSarea()%> " + btn;
				// ex) value = 부산 해운대 주변 맛집
			}
	   		
			// value 값을 구글맵 검색 input에 넘겨준다
	    	$("#pac-input").attr("value", value);
	    	
	    	// 구글맵 검색 input에 포커스 및 엔터 입력 되게 처리 (input 클릭 시 엔터 입력되서 자동 검색)
	    	var input = document.getElementById('pac-input');
	    	google.maps.event.trigger(input, 'focus');
		    google.maps.event.trigger(input, 'keydown', { keyCode: 13 });
		});
		
		
		// 작은 이미지 클릭 시 큰 이미지부분이 클릭한 이미지로 교체
		$('.bxslider img').click(function(){
			
			// 모든 이미지의 테두리값을 없앤다
			$('.bxslider img').css("border", "");  
			
			// 클릭된 이미지에 회색 테두리를 만든다
			// 선택된 효과
			$(this).css({
				"border" : "5px solid #A6A6A6",
				"box-sizing" : "border-box"
			});
			
			// 클릭된 이미지의 src 주소값을 가져온다
			var imgurl = $(this).attr("src");
			// 큰 이미지 부분에 클릭된 작은이미지 src 적용
			$('#main').attr("src", imgurl);
		});
		
		
		$('#close').click(function(){
			$('#banner').hide();
			$('#banner_sub').hide();
		});
		
	});

	//구글맵 v3
	function initAutocomplete() {

		var geocoder = new google.maps.Geocoder();

		var addr = value;  // 버튼 클릭 시 넘겨받을 장소
		var lat = "";   // 위도값
		var lng = "";   // 경도값
		var prev_infowindow = false; // 이전 infowindow값 저장할 변수
		
		geocoder.geocode({
			'address' : addr
		},

		function(results, status) {

			if (results != "") {

				var location = results[0].geometry.location;	// 검색하는 장소의 위치값을 가져온다

				lat = location.lat();   // 검색하는 장소의 위도값
				lng = location.lng();   // 검색하는 장소의 경도값

				var latlng = new google.maps.LatLng(lat, lng);  // 위도, 경도 설정
				var myOptions = {
					zoom : 14,									// 구글맵 줌 거리 설정
					center : latlng,							// 구글맵 좌표 설정
					mapTypeControl : true,
					mapTypeId : google.maps.MapTypeId.ROADMAP
				};
				var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);  // 구글맵 생성
				
				var infoWindow = new google.maps.InfoWindow({
					map : map
				});
		    	

			    
				// 검색창과 UI요소와 연결
				var input = document.getElementById('pac-input');
				var searchBox = new google.maps.places.SearchBox(input);
				map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

				// Bias the SearchBox results towards current map's viewport.
				map.addListener('bounds_changed', function() {
					searchBox.setBounds(map.getBounds());
				});

				var markers = [];
				// 검색할때 이벤트 처리 
				searchBox.addListener('places_changed', function() {
					var places = searchBox.getPlaces();

					if (places.length == 0) {
						return;
					}

					// 오래된 마커를 지웁니다
					markers.forEach(function(marker) {
						marker.setMap(null);
					});
					markers = [];

					
					
					// 그 장소에 대한 더 자세한 내용
					// 각 장소의 아이콘과 이름, 위치를 가져온다
					var bounds = new google.maps.LatLngBounds();
					places.forEach(function(place) {
						if (!place.geometry) {
							console.log("Returned place contains no geometry");
							return;
						}
						
						// 해당 장소의 사진을 가져온다
						var photos = place.photos;
						  if (!photos) {
						    return;
					 	}
						
						// 해당 장소에 마커를 만든다
						var marker = new google.maps.Marker({
						  map: map,
						  position: place.geometry.location,
						  title: place.name
						  
						});
		            	markers.push(marker);

		            	
		            	// 말풍선에 넣을 이미지 및 문구 설정
		            	var imgurl = photos[0].getUrl({'maxWidth': 150, 'maxHeight': 150});
		            	var contentString = "<table border='1'><tr><td rowspan='2'><img style='width:100px; height:100px' src=" + imgurl + "></td><td><center><p>" + place.name + "</p></center></td></tr>"
		            	 + "<tr><td><center><p>" + place.formatted_address + "</p></center></td></tr></table>";
						
						var infowindow1 = new google.maps.InfoWindow({ content: contentString});
						 
						
						// 마커를 클릭했을 때 이벤트 처리 
						google.maps.event.addListener(marker, 'click', function() {
							if (prev_infowindow)  // 값이 있을 시 실행
								{
									prev_infowindow.close();  // 이전 정보창을 닫는다
								}
							prev_infowindow = infowindow1;  // prev_infowindow에 현재 inforwindow1 값을 저장
							infowindow1.open(map, this);	// 클릭된 마커의 정보창을 연다
				        });
						
						 
// 						// 마커 위에 마우스가 올라갔을때 이벤트 처리 
// 						google.maps.event.addListener(marker, 'mouseover', function() {
// 				            infowindow1.open(map, this);
// 				        });
							
// 						// 마커 위에 마우스가 내려갔을때 이벤트 처리
// 						google.maps.event.addListener(marker, 'mouseout', function() {
// 				            infowindow1.close(map, this);
// 				        });
						
								
						
						if (place.geometry.viewport) {
							// Only geocodes have viewport.
							bounds.union(place.geometry.viewport);
						} else {
							bounds.extend(place.geometry.location);
						}
					});
					map.fitBounds(bounds);
				});
			} else
				$("#map_canvas").html("위도와 경도를 찾을 수 없습니다.");	
		})
	}

	// 대댓글 작성 시 해당 댓글 밑에 입력창 보여주기/숨기기
	function rewrite(renum){
		$('#con' + renum).toggle();
	}

	

</script>

<!-- 구글맵에 필요한 스크립트 -->
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAABj1RgLJEG6AlmrrpOAyD9Jq_ciRKdt0&libraries=places&callback=initAutocomplete"
	async defer>
</script>
<!-- 구글맵에 필요한 스크립트 -->

<style type="text/css">

.clear {
	clear: both;
}

#wrap {
	width: 1000px;
	min-height: 1000px;
	border: 1px solid black;
	margin: 0 auto;
	padding-top: 50px;
}


/* 이미지, 가격, 인원수 정보 부분 */
#top {
	width: 960px;
}


#imgdiv ul
{
	list-style: none;
}


#imgdiv{
	width: 470px;
	height: 400px;
	border: 3px solid orange;
	float: left;
}

#imgdiv img {
	width: 470px;
	height: 300px;
	float: left;
}

#imgdiv ul li img{
	width: 80px;
	height: 80px;
	margin-top : 10px;
	margin-left : 5px;
}

/* 이미지에 마우스를 올렸을 때 이벤트 */
#imgdiv ul li img:HOVER{
	box-sizing : border-box;
	border : 5px solid #A6A6A6;
}

#contentdiv1 {
	width: 400px;
	height: 400px;
	border: 3px solid blue;
	float: left;
}


/* 이미지, 가격, 인원수 정보 부분 */
	
	

/* 여행정보 내용 */

#contentdiv2 {
	width: 960px;
	min-height: 700px;
	border: 3px solid gray;
}

/* 여행정보 내용 */

/* 구글맵 */
#map_canvas {
	width: 740px;
	height: 400px;
}

.controls {
	margin-top: 10px;
	border: 1px solid transparent;
	border-radius: 2px 0 0 2px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	height: 32px;
	outline: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

#pac-input {
	background-color: #fff;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	margin-left: 12px;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 300px;
}

#pac-input:focus {
	border-color: #4d90fe;
}


/* 구글맵 */


/* 상품 문의 */
#QnA {
	width: 800px;
	height: 500px;
	border: 3px solid pink;
}
/* 상품 문의 */



/* 추천상품 배너 */
#banner_sub
{
	margin : 0px;
	padding : 0px;
	width : 100px;
	height : 20px;
	border : 2px solid black;
	position : fixed;
	right : 374px;
	bottom : 182px;
	background-color: white;
	text-align: center;
	font-size: 0.8em;
}


#banner
{
	margin : 0px;
	padding : 0px;
	width : 464px;
	height : 180px;
	border : 2px solid black;
	position : fixed;
	right : 10px;
	bottom : 0px;
	background-color: white;

}

#banner_content
{
	position : relative;
	top : -20px;
}

#banner_content td
{
	text-align: center;
}


#banner img
{
	width : 150px;
	height : 150px;
}


#close
{
	background-color: black;
	color : white;
	width : 50px;
	height : 20px;
	float: right;
	position : relative;
	z-index: 1;
	text-align: center;
}

#close:HOVER
{
	cursor: pointer;
}
/* 추천상품 배너 */

</style>

<%
	// 세션으로 로그인한 아이디 값 받아오기
	//	String session_id = (String) session.getAttribute("id");
	String session_id = "admin";

%>
	<div id="banner_sub">추천상품</div>
	<div id="banner">
		<div id="close">close</div>
		<table id="banner_content">
			<tr>
				<td><a href="#"><img src="./writeAPI/upload/<%=PB.getFile1() %>"></a></td>
				<td><a href="#"><img src="./writeAPI/upload/<%=PB.getFile1() %>"></a></td>
				<td><a href="#"><img src="./writeAPI/upload/<%=PB.getFile1() %>"></a></td>
			</tr>
			<tr>
				<td><div class="info">가격 50000</div></td>
				<td><div class="info">가격 40000</div></td>
				<td><div class="info">가격 30000</div></td>
			</tr>
		</table>
	</div>

	<!-- 왼쪽 메뉴 -->
	<jsp:include page="../leftMenu.jsp"></jsp:include>
	<!-- 왼쪽 메뉴 -->
	<div id="wrap">
		<!--글제목 -->
		<h3><%=PB.getSubject()%></h3>
		<!--글제목 -->
		<!--관리자만 보이게 -->
		<%
		if (session_id.equals("admin"))
		{
		%>
		<input type="button" value="글수정" onclick="location.href='PackModify.po?num=<%=PB.getNum() %>'">
		<input type="button" value="글삭제" onclick="location.href='PackDeleteAction.po?num=<%=PB.getNum() %>'">
		<%
		}
		%>
		<!--관리자만 보이게 -->
		<hr>
		<div id="top">
			<!--상품 이미지 -->
			<div id="imgdiv">
				<!--첫번째 이미지는 무조건 첨부하게 제어 -->
				<img src="./writeAPI/upload/<%=PB.getFile1() %>" id="main">
				<ul class="bxslider">
					<!--첫번째 이미지는 무조건 첨부하게 제어 -->
					<li><img src="./writeAPI/upload/<%=PB.getFile1() %>" style="box-sizing : border-box; border : 5px solid #A6A6A6;"></li>
					<%
					// 2~5번째 이미지는 null이 아닐 경우 출력 o   null 경우 출력 x
					String img[] = {PB.getFile2(), PB.getFile3(), PB.getFile4(), PB.getFile5()};
					
					for (int i = 0; i < img.length; i++)
					{
						if(img[i] != null && !img[i].equals(""))
						{
						%>
							<li><img src="./writeAPI/upload/<%=img[i] %>"></li>
						<%
						}
					}
					%>
				</ul>
			</div>
			<!--상품 이미지 -->
			
			<!--인원수, 가격 -->
			<div id="contentdiv1">
				<form name="fr" method="post">
					<table border="1">
						<tr>
							<td width="50px">성인</td>
							<td width="100px">200,000</td>
						</tr>
						<tr>
							<td>아동</td>
							<td>100,000</td>
						</tr>
					</table>
					<table border="1">
						<tr>
							<td width="75px">성인</td>
							<td width="75px">아동</td>
						</tr>
						<tr>
							<td>
								<!--최대 10명까지 선택가능하게 생성 -->
								<select id="adult" name="adult" onchange="people_Calc(1)">
										<%
											for (int i = 1; i < 11; i++) {
										%>
										<option value="<%=i%>"><%=i%></option>
										<%
											}
										%>
								</select>
								<!--최대 10명까지 선택가능하게 생성 -->
							</td>
							<td>
							<!--초기값은 1명까지 선택되게 생성 -->
							<select id="child" name="child" onchange="people_Calc()">
									<option value="0">0</option>
									<option value="1">1</option>
							</select>
							<!--초기값은 1명까지 선택되게 생성 -->
							</td>
						</tr>
						<tr>
							<td>합계</td>
							<td colspan="2"><p id="p">200000</p> 
							
							<script type="text/javascript">
							// 선택된 인원 수에 따라 가격 변경, 어른 인원에 따라 아이인원제한
							function people_Calc(num){			
								$(document).ready(function(){
									var val1 = $("#adult option:selected").val();  // 어른 인원 선택된 값을 가져온다
									var val2 = $("#child option:selected").val();  // 아이 인원 선택된 값을 가져온다
									
									// 어른 수에 따라 아이 수 제한
									if (num == 1) // 어른 선택 시 호출
									{
										$("#child").find("option").remove();  // 아이에서 선택 값 전부 삭제
										for (i = 0; i <= val1; i++)  // 선택된 어른 수가 최대치인 아이 선택값 생성     ex) 어른 3명 선택 시 아이도 3명까지 선택 가능
										{
											$('#child').append("<option value=" + i + ">" + i + "</option");
										}
									}
									// 선택된 어른 수, 아이 수에 따라 가격 계산 후 출력
									$('#p').html(val1 * 200000 + val2 * 100000);
								});
							}
						</script></td>
						</tr>
						<tr>
							<td><input type="submit" value="찜하기" onclick="submit_fun(1)"></td>
							<td><input type="submit" value="예약하기" onclick="submit_fun(2)"></td>
						</tr>
					</table>
				</form>
			</div>
			<!--인원수, 가격 -->
		</div>
		<div class="clear"></div>

		<!--상품 정보, 내용이 들어가는 영역 -->
		<div id="middle1">
			<div id="contentdiv2">
			
			<%=PB.getContent() %></div>
		</div>
		<!--상품 정보, 내용이 들어가는 영역 -->

		<!--구글맵 제어할 버튼 부분 -->
		<div id="middle2">
			<hr>
			<p id="sub"><%=PB.getCity()%> <%=PB.getSarea()%></p>
			<input type="button" id="btn1" value="주변 명소"> <input
				type="button" id="btn2" value="주변 맛집">
		</div>
		<!--구글맵 제어할 버튼 부분 -->
		
		<!--구글맵 -->
		<input id="pac-input" class="controls" type="text" placeholder="Search Box" readonly>
		<div id="map_canvas"></div>
		<!--구글맵 -->

		<!--상품 문의 -->
		<div id="middle3">
			<div id="QnA">
				<h3>상품 문의</h3>
				<hr>
				<%
					// 디비 객체 생성 BoardDAO
					ReplyDAO cdao = new ReplyDAO();
					//전체글 횟수 구하기 int count = getBoardCount()
					int count = cdao.getCommentCount(PB.getNum());

					//한페이지에 보여줄 글의 갯수
					int pagesize = 10;

					//현재페이지가 몇페이지인지 가져오기
					String pageNum = request.getParameter("pageNum");

					if (pageNum == null)
						pageNum = "1";
					//시작행 구하기   1,  11,  21,  31,  41  ...... 

					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pagesize + 1;

					//끝행 구하기
					int endRow = currentPage * pagesize;

					// 메서드 호출 getBoardList(시작행, 몇개)
					List replyList;
					ReplyBean rb;
				%>
				게시판 전체글 갯수[<%=count%>]

				<table border="1">
					<tr>
						<td>번호</td>
						<td>작성자</td>
						<td>내용</td>
					</tr>
					<%
						if (count != 0) {
							replyList = cdao.getCommentList(startRow, pagesize, PB.getNum());
							for (int i = 0; i < replyList.size(); i++) {
								rb = (ReplyBean) replyList.get(i);
					%>

					<tr>
						<td><%=rb.getNum()%></td>
						<td><%=rb.getId()%></td>
						<td>
							<%
								// 답글 들여쓰기 모양
										int wid = 0;
										if (rb.getRe_lev() > 0) {
											wid = 10 * rb.getRe_lev();
							%> <img src="level.gif" width=<%=wid%>> <img src="re.gif">
							<%
								}
							%> <a href="#?num=<%=rb.getNum()%>&pageNum=<%=pageNum%>"><%=rb.getContent()%></a>
						</td>
						<td><input type="button" value="답글" id="rereply" onclick="rewrite(<%=rb.getNum()%>)"></td>
						<td><input type="button" value="삭제" id="re_delete" onclick="location.href='ReplyDelAction.ro?renum=<%=rb.getNum() %>&id=<%=rb.getId() %>'"></td>
					</tr>

					<tr>
					<tr id="con<%=rb.getNum()%>" style="display: none;">
						<td>
							<form action="./Re_ReplyWriteAction.ro" method="post">
								<input type="hidden" name="num" value="<%=PB.getNum()%>">
								<input type="hidden" name="pageNum" value="<%=pageNum%>">
								<input type="hidden" name="replynum" value="<%=rb.getNum()%>">
								<input type="hidden" name="re_ref" value="<%=rb.getRe_ref()%>">
								<input type="hidden" name="re_lev" value="<%=rb.getRe_lev()%>">
								<input type="hidden" name="re_seq" value="<%=rb.getRe_seq()%>">
						</td>
						<td>ID</td>
						<td><input type="text" name="id"></td>
						<td><textarea cols="60" rows="2" name="content"></textarea> <input
							type="submit" id="re_reply_content" value="답글등록"></td>
						</form>
					<tr>

					</tr>
					<%
						}
							// 최근글위로 re_ref 그룹별 내림차순 re_se q 오름차순
							// 			re_ref desc   re_seq asc
							// 글잘라오기 limit 시작행-1, 개수
						}
					%>
				</table>

				

				<center>
					<%
						if (count != 0) {
							// 페이지 갯수 구하기
							int pageCount = count / pagesize + (count % pagesize == 0 ? 0 : 1);
							int pageBlock = 10;
							// 시작 페이지 구하기
							int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
							// 끝페이지 구하기
							int endPage = startPage + pageBlock - 1;
							if (endPage > pageCount) {
								endPage = pageCount;
							}

							//이전
							if (startPage > pageBlock) {
					%>
					<a href="./ReplyList.ro?pageNum=<%=startPage - pageBlock%>">[이전]</a>
					<%
						}

							//페이지
							for (int i = startPage; i <= endPage; i++) {
					%>
					<a href="./ReplyList.ro?pageNum=<%=i%>">[<%=i%>]
					</a>
					<%
						}

							//다음
							if (endPage < pageCount) {
					%>
					<a href="./ReplyList.ro?pageNum=<%=startPage + pageBlock%>">[다음]</a>
					<%
						}
						}
					%>
				</center>

				<br>
				
				<fieldset>
					<legend></legend>
					<table>
						<tr>
							<form action="./ReplyWrite.ro" method="post">
								<td><label>id</label><input type="text" name="id">
									<input type="hidden" name="pageNum" value="<%=pageNum%>">
									<input type="hidden" name="num" value="<%=PB.getNum() %>">
								</td>
								<td><label>내용</label><input type="text" name="content"
									class="box" style="width: 500px;"></td>
								<td><input type="submit" value="댓글쓰기"></td>
							</form>
						</tr>
					</table>
					<legend></legend>
				</fieldset>
			</div>
		</div>
		<!--상품 문의 -->
	</div>
	<!-- 오른쪽 메뉴 -->
	<jsp:include page="../rightMenu.jsp"></jsp:include>
	<!-- 오른쪽 메뉴 -->
</body>
</html>