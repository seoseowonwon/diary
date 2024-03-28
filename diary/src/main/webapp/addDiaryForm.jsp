<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
// 0. 로그인(인증) 분기
// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")

	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
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
	}
%>

<%
	String checkDate = request.getParameter("checkDate");
	if(checkDate == null) {
		checkDate = "";
	}
	String ck = request.getParameter("ck");
	if(ck == null) {
		ck = "";
	}
	
	String msg = "";
	if(ck.equals("T")) {
		msg = "입력이 가능한 날짜입니다";
	} else if(ck.equals("F")){
		msg = "일기가 이미 존재하는 날짜입니다";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addDiaryForm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
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
						<a class="text-white fs-4 " href="/diary/diary.jsp">Calenar</a>
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
			<div
				class="mt-5 col-8 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
				<h1>일기쓰기</h1>
				<form method="post" action="/diary/checkDateAction.jsp">
					<div>
						날짜확인 : <input type="date" name="checkDate" value="<%=checkDate%>">
						<span><%=msg%></span>
					</div>
					<div class="d-flex flex-row-reverse">
						<button type="submit" class="btn btn-outline-success">확인</button>
					</div>
				</form>

				<hr>

				<form method="post" action="/diary/addDiaryAction.jsp">
					
					<div>
						<%
							if(ck.equals("T")) {
						%>
						
						<div class="input-group">
						  
						  <input type="text"  class="form-control" value="<%=checkDate%>" name="diaryDate"
							readonly="readonly" >
						  <input type="text"  class="form-control" name = "title" placeholder="title">
						</div>
					

						<%	
							} else {
						%>
						<div class="input-group">

							<input type="text" class="form-control" name="diaryDate"
								placeholder="Date" readonly="readonly"> <input
								type="text" class="form-control" name="title"
								placeholder="title">
						</div>
						
						<%		
							}
						%>
					</div>
					<div>
						기분 : <input type="radio" name="feeling" value="&#128512;">&#128512;
						기분 : <input type="radio" name="feeling" value="&#128513;">&#128513;
						기분 : <input type="radio" name="feeling" value="&#128514;">&#128514;
						기분 : <input type="radio" name="feeling" value="&#128515;">&#128515;
						기분 : <input type="radio" name="feeling" value="&#128516;">&#128516;
					</div>
					<div>
						<select name="weather">
							<option value="맑음">맑음</option>
							<option value="흐림">흐림</option>
							<option value="비">비</option>
							<option value="눈">눈</option>
						</select>
					</div>
					<hr>
					<div class="mb-3">
						<textarea class="form-control" id="exampleFormControlTextarea1" name="content"
							rows="3"></textarea>
					</div>
					<div class="d-flex flex-row-reverse">
						<button type="submit" class="btn btn-outline-success">입력</button>
					</div>
				</form>
			</div>
			<div class="col-2"></div>
		</div>
		<!-- row -->
	</div>
	<!-- contain -->
</body>
</html>