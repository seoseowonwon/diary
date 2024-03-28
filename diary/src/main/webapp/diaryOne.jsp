<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>
<%
	
// login(인증) 분기
	// diary.login.my_session (DB이름, 테이블, 컬럼) => my_session의 값이 OFF이면 -> redirect ("loginForm.jsp")으로 이동
	String sql1 = "select my_session mySession from login"; //mySession같은 경우 아이어스 별칭
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("OFF")){
		
		String errMsg = URLEncoder.encode( "잘못된 접근 입니다. 로그인 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 
		
		return; // 코드 진행을 끝내는 문법
	} 
	
	// 어떤 값들을 가져올 거
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("diaryOne diaryDate --> "+diaryDate);
	String sql2 = "select diary_date diaryDate, title, weather, content, update_date updateDate, create_date createDate from diary where diary_date = ?";
	System.out.println(sql2);
	
	
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	// 문자열 쿼리안에 ?(표현식을 값으로 치환)
	stmt2.setString(1, diaryDate);
	// 정확히 치환되었는지 꼭 stmt 디버깅
	System.out.println("diaryOne stmt2 --> "+stmt2);
	
	ResultSet rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>diaryOne</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	a{
		text-decoration: none;
		color: #000000;
	}

	header {
		height: 100px;
	
	}
	
	header a:hover {
		text-decoration: none;
		font-weight: bold;
	}
	</style>
</head>
<body class="bg-warning">
	<div class="container">
		<header>
			<div class="row">
				<div class="col-2">
					<h1 class="m-4 text-white">Diary</h1>
				</div>
				<div class="col-8">
					<div style="margin-top: 40px; margin-left: 20px">
						<a class="text-white fs-4 " href="/diary/diary.jsp">Calendar</a>
						<a class="ms-5 text-white fs-4 " href="/diary/diaryList.jsp">List</a>
						<a class="ms-5 text-white fs-4 " href="/diary/addDiaryForm.jsp">Write</a>
					</div>
				</div>
				<div class="col-2">
					<div style="margin-top: 40px; margin-left: 20px">
						<a class="text-white fs-6" href="/diary/logout.jsp">로그아웃</a>
					</div>
				</div>
			</div>
		</header>
		<div class="row">
			<div class="col-2"></div>
			<div class="mt-5 col-8 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
				<%
					if(rs2.next()){
				%>
				<table class="table table-hover">
				<h2>Diary 상세보기</h2>
					<tr>
						<td>diary Date</td>
						<td><%=rs2.getString("diaryDate")%></td>
					</tr>
					
						<td>title</td>
						<td><%=rs2.getString("title")%></td>
					
					<tr>
						<td>weather</td>
						<td><%=rs2.getString("weather")%></td>
					</tr>
					
					<tr>
						<td>content</td>
						<td><%=rs2.getString("content")%></td>
					</tr>
				
					<tr>
						<td>updateDate</td>
						<td><%=rs2.getString("updateDate")%></td>
					</tr>
					<tr>
						<td>createDate</td>
						<td><%=rs2.getString("createDate")%></td>
					</tr>
				</table>
				<a href="/diary/updateDiaryForm.jsp?diaryDate=<%=rs2.getString("diaryDate") %>" class="btn btn-outline-danger">글 수정</a>
				<a href="/diary/deleteDiaryForm.jsp?diaryDate=<%=rs2.getString("diaryDate") %>" class="btn btn-outline-danger">글 삭제</a>
				<% 
					}
				%>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
</body>
</html>