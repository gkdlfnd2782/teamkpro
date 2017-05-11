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
<script type="text/javascript" src="./writeAPI/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.2.0.js"></script>
<script>
	jQuery(document).ready(function($){
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
		$("#txt_prodStart").datepicker();
	    $('img.ui-datepicker-trigger').attr('align', 'absmiddle');
		
	});
</script>

<style type="text/css">


#wrap
{
	width : 1000px;
	min-height : 1000px;
	border : 1px solid black;
	margin : 0 auto;
	padding-top : 50px;
}



</style>

<%
	int num = ((Integer)request.getAttribute("num")).intValue();
	System.out.println("Modify.jsp num >> " + num);
	PackBean pb= (PackBean)request.getAttribute("pb");
	// serial 값에서 날짜를 추출한다
	String date_temp = String.valueOf(pb.getSerial());		// serial 값을 String으로 변환
	String year = date_temp.substring(0, 4);				// serial 값에서 year값 추출
	String month = date_temp.substring(4, 6);				// serial 값에서 month값 추출
	String day = date_temp.substring(6, 8);					// serial 값에서 day값 추출
	String date = "";
	
	System.out.println(year);
	System.out.println(month);
	System.out.println(day);
	
	
	// 추출한 year, month, day 값을 하나로 합친다      형식   yyyy-mm-dd
	for (int i = 0; i < date_temp.length(); i++)
	{
		if (i == 3) {
			  date = year + "-";
		}
		else if (i == 5) {
			  date = date + month + "-";
		}
		else if (i == 7) {
			  date = date + day;
		}
	}
	System.out.println(date);
%>

</head>
<body>
<!-- 왼쪽 메뉴 -->
<jsp:include page="../leftMenu.jsp"></jsp:include>
<!-- 왼쪽 메뉴 -->

<div id="wrap">
	<div>
		<form action="./PackModifyAction.po?num=<%=pb.getNum() %>" id="fr" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>소제목</td>
					<td><input type="text" name="intro" required="yes" value="<%=pb.getIntro() %>"></td>
				</tr>
				<tr>
					<td>출발일자</td>
					<td><input type="text" id="date_from" name="sdate" value="<%=date %>" class="input_style" name="startDate" required="yes"></td>
					
				</tr>
				<tr>
					<td>지역</td>
					<td><input type="text" name="area" required="yes" value="<%=pb.getArea() %>"></td>
				</tr>
				<tr>
					<td>도시</td>
					<td><input type="text" name="city" required="yes" value="<%=pb.getCity() %>"></td>
				</tr>
				<tr>
					<td>소분류</td>
					<td><input type="text" name="sarea" required="yes" value="<%=pb.getSarea() %>" placeholder="ex) 강남, 명동"></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="text" name="cost" required="yes" value="<%=pb.getCost() %>"></td>
				</tr>
				<tr>
					<td>수량</td>
					<td><input type="text" name="stock" required="yes" value="<%=pb.getStock() %>"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" required="yes" value="<%=pb.getSubject() %>"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td style="width:770px; height:412px;"><textarea name="content" id="ir1" rows="10" cols="100" style="width:770px; height:412px;"></textarea></td>
				</tr>
				
				<tr>
					<td>이미지첨부</td>
					<td>
						<input type="text" name="file1" id="file1" value="<%=pb.getFile1()%>" readonly style="width: 300px;">
						
						<input type="button" value="파일수정" class="dup" id="button" onclick="document.getElementById('file11').click();"
						onchange="document.getElementById('file1').value=this.value;">
						
						<input type="button" value="파일삭제" class="dup" id="button" onclick="document.getElementById('file1').value='';">
						
						<input type="file" size="30" name="file" id="file11" style="display: none;"
						onchange="document.getElementById('file1').value=this.value;" />
					</td>
				</tr>
				<tr>
					<td>이미지첨부</td>
					<td>
						<input type="text" name="file2" id="file2" value="<%=pb.getFile2()%>" readonly style="width: 300px;">
						
						<input type="button" value="파일수정" class="dup" id="button" onclick="document.getElementById('file22').click();"
						onchange="document.getElementById('file2').value=this.value;">
						
						<input type="button" value="파일삭제" class="dup" id="button" onclick="document.getElementById('file2').value='';">
						
						<input type="file" size="30" name="file" id="file22" style="display: none;"
						onchange="document.getElementById('file2').value=this.value;" />
					</td>
				</tr>
				<tr>
					<td>이미지첨부</td>
					<td>
						<input type="text" name="file3" id="file3" value="<%=pb.getFile3()%>" readonly style="width: 300px;">
						
						<input type="button" value="파일수정" class="dup" id="button" onclick="document.getElementById('file33').click();"
						onchange="document.getElementById('file3').value=this.value;">
						
						<input type="button" value="파일삭제" class="dup" id="button" onclick="document.getElementById('file3').value='';">
						
						<input type="file" size="30" name="file" id="file33" style="display: none;"
						onchange="document.getElementById('file3').value=this.value;" />
					</td>
				</tr>
				<tr>
					<td>이미지첨부</td>
					<td>
						<input type="text" name="file4" id="file4" value="<%=pb.getFile4()%>" readonly style="width: 300px;">
						
						<input type="button" value="파일수정" class="dup" id="button" onclick="document.getElementById('file44').click();"
						onchange="document.getElementById('file4').value=this.value;">
						
						<input type="button" value="파일삭제" class="dup" id="button" onclick="document.getElementById('file4').value='';">
						
						<input type="file" size="30" name="file" id="file44" style="display: none;"
						onchange="document.getElementById('file4').value=this.value;" />
					</td>
				</tr>
				<tr>
					<td>이미지첨부</td>
					<td>
						<input type="text" name="file5" id="file5" value="<%=pb.getFile5()%>" readonly style="width: 300px;">
						
						<input type="button" value="파일수정" class="dup" id="button" onclick="document.getElementById('file55').click();"
						onchange="document.getElementById('file5').value=this.value;">
						
						<input type="button" value="파일삭제" class="dup" id="button" onclick="document.getElementById('file5').value='';">
						
						<input type="file" size="30" name="file" id="file55" style="display: none;"
						onchange="document.getElementById('file5').value=this.value;" />
					</td>
				</tr>
				<tr>
					<td><input type="submit" value="글수정" id="modify"></td>
					<td><input type="button" value="취소" onclick="history.go(-1)"></td>
				</tr>
			</table>
			<script type="text/javascript">
				var oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: oEditors,
					elPlaceHolder: "ir1",
					sSkinURI: "./writeAPI/SmartEditor2Skin.html",	
					htParams : {
						bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						fOnBeforeUnload : function(){
						}
					}, //boolean
					fOnAppLoad : function(){
						//예제 코드 로딩이 완료되면 본문에 삽입되는 내용
				 		var sHTML = '<%=pb.getContent() %>';
						oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
					},
					fCreator: "createSEditor2"
				});
				
				function pasteHTML(filepath) {
					// textarea에 이미지를 넣어줍니다
					var sHTML = '<img src="<%=request.getContextPath()%>/writeAPI/upload/'+filepath+'">';
				    oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
				}
				
				// 글자체, 크기 기본 셋팅
				function setDefaultFont() {
					var sDefaultFont = '궁서';
					var nFontSize = 24;
					oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
				}
	
				
				// 글수정 버튼 클릭 이벤트
				$("#fr").submit(function(){
					var file1 = $("#file1").val();
					var file2 = $("#file2").val();
					var file3 = $("#file3").val();
					var file4 = $("#file4").val();
					var file5 = $("#file5").val();
					
					var fileArr = [file1, file2, file3, file4, file5];
					
					if(file1 == "")
					{
						alert("첫번째 이미지는 필수로 넣어주세요");
						return false;
					}

					
					for(var i = 0; i < fileArr.length; i++)
					{
						var file = fileArr[i].substring(fileArr[i].lastIndexOf(".") + 1)

				 		if (file != "jpg" && file != "png" && file != "gif" && 
				 				file != "JPG" && file != "PNG" && file != "GIF" && file != "" && file != "null")
				 		{
				 			alert("jpg, png, gif 파일만 업로드 가능합니다");
				 			return false;
				 		}
					}
			 		
					
					var content = oEditors.getById["ir1"].getIR(); // Edit에 쓴 내용을 content 변수에 저장    값 : <br>
					
					if (content == "<br>")  // 빈공간 값 <br>
					{
						alert("글을 입력해주세요");  // 메시지 띄움
						return false;
					}
					else // 글내용 있을 시
					{
						oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []); // Edit에 쓴 내용을 textarea에 붙여넣어준다
// 					    $("#fr").submit();  // form을 submit 시킨다
					}
				});
				
			</script>
		</form>
	</div>
</div>
<!-- 오른쪽 메뉴 -->
<jsp:include page="../rightMenu.jsp"></jsp:include>
<!-- 오른쪽 메뉴 -->
</body>
</html>