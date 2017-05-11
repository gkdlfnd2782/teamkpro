<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
body {
	background-image: url("./images/bg_img.png");
	background-repeat : no-repeat;
	margin: 0;
	padding: 0;
}

div#wrap {
	margin-top: 100px;
	background-color: rgba(230, 230, 230, 0.5);
	width: 100%;
	min-height: 100%;
	padding-top: 50px;
	margin: 0 auto;
}

div#map {
	width: 700px;
	height: 500px;
	background-color: skyblue;
	margin: 0 auto;
}

div#search {
	width: 500px;
	height: 50px;
	background-color: white;
	border: 3px solid pink;
	margin: 0 auto;
	margin-top: 50px;
}

div#main_go {
	width: 85px; 
	height : 50px;
	font-size: 2em;
	margin: 0 auto;
	margin-top: 50px;
}

div#login_join {
	width: 125px;
	height: 20px;
	font-size: 0.9em;
	color: gray;
	margin: 0 auto;
	margin-top: 50px;
}

div#footer {
	width: 100%;
	height: 200px;
}
</style>
</head>
<body>

	<!--왼쪽 메뉴 -->
	<div>
		<jsp:include page="leftMenu.jsp"></jsp:include>
	</div>
	<!--왼쪽 메뉴 -->
	
	<div id="wrap">
		
		<!--지도 들어갈 부분 -->
		<div id="map">
			<center>지도지도지도지도지도지도지도지도지도지도지도지도지도지도지도</center>
		</div>
		<!--지도 들어갈 부분 -->
		
		<!--검색하는 부분 -->
		<div id="search">검색창</div>
		<!--검색하는 부분 -->
		
		<!--클릭 시 메인 이동-->
		<div id="main_go"><a href="./PackList.po">Main</a></div>
		<!--클릭 시 메인 이동-->
		
		<!--로그인 & 회원가입-->
		<div id="login_join">
			<a href="#">로그인</a> | <a href="#">회원가입</a>
		</div>
		<!--로그인 & 회원가입-->
		
		<div id="footer"></div>
	</div>
	
	<!--오른쪽 메뉴 -->
	<div>
		<jsp:include page="rightMenu.jsp"></jsp:include>
	</div>
	<!--오른쪽 메뉴 -->
</body>
</html>