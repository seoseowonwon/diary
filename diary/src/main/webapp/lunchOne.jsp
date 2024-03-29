<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>

<%
//0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	/*String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection( "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}*/
	
	//session login
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null){
			String errMsg = URLEncoder.encode("잘못된접근");
			response.sendRedirect("/diary/diary.jsp");
			return;
	}
%>
<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("lunchOne diaryDate --> "+ diaryDate);	

	String sql2 = "select lunch_date lunchDate, menu from lunch where lunch_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection( "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, diaryDate);
	rs2 = stmt2.executeQuery();
	System.out.println("lunchOne stmt2 --> "+stmt2);
	
	if(rs2.next()){ // 값이 있을때 출력
%>
		<!DOCTYPE html>
		<html>
		<head>
		<meta charset="UTF-8">
		<title>lunchOne</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		</head>
		<body class="bg-warning">
			<div class="container">
				<div class="row">
					<div class="col-2"></div>
					<div class="mt-5 col-8 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
						<table  class="table table-hover">
							<tr>
								<td>lunchDate</td>
								<td><%=rs2.getString("lunchDate")%></td>
							</tr>
							<tr>
								<td>menu</td>
								<td><%=rs2.getString("menu")%></td>
							<tr>
						</table>
					</div>
				</div>
			</div>
		</body>
		</html>
<%		
		
	} else {
%>
		<html>
		<head>
			<meta charset="UTF-8">
			<title>lunchOne</title>
		</head>
		<body>
			<form action="" method="get">
				<table>
					<div><input type="radio">한식<input type="radio">중식<input type="radio">일식<input type="radio">기타</div>
				</table>
			</form>
		</body>
		</html>
				
<%		
	}
%>
