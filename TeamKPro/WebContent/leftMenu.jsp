<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script src="./js/jquery-3.2.0.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($){
		
		var OnOff = 1;
		
		$('#click').click(function(){
			if(OnOff == 1)  // 1일 때 나와서 메뉴 보인다
			{
				$('#menu').css('width', '300px');
				$('#click').css('margin-left', '500px');
				$('#menu_list').css('display', 'block');  // menu_list를 보이게
				OnOff = 0;
			}
			else if(OnOff == 0) // 0일때 들어가서 메뉴 안보인다
			{
				$('#menu').css('width', '0px');
				$('#click').css('margin-left', '200px');
				$('#menu_list').css('display', 'none');  // menu_list를 안보이게
				OnOff = 1;
			}			
		});
	});
</script>

<style type="text/css">

div#menu
{
	width : 0px;
	height : 500px;
	transition: 0.5s;
	background-color: orange;
	position: fixed;
	margin-left : 200px;
	top : 25%;
	
}

div#menu ul#menu_list
{
	display: none;
}

div#logo_menu
{
	width : 200px;
	height : 500px;
	transition: 0.5s;
	background-color: orange;
	position: fixed;
	margin-left : 0px;
	top : 25%;
}


div#click
{
	width : 80px;
	height : 50px;
	transition: 0.5s;
	background-color: orange;
	position: fixed;
	margin-left : 200px;
	top : 25%;
}
</style>

</head>
<body>
	<div id="click">
		<span>Menu</span>
	</div>
	<div id="logo_menu">
		<img alt="로고" src="" width="200px"; height="200px";>
		<p>내용내용내용내용</p>
	</div>
	<div id="menu">
		<ul id="menu_list">
			<li><a href="#">메인</a></li>
			<li><a href="#">패키지</a></li>
			<li><a href="#">상품</a></li>
			<li><a href="#">리뷰게시판</a></li>
			<li><a href="#">Q&A</a></li>
		</ul>
	</div>
</body>
</html>