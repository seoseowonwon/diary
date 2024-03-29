<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	/*String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
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
	// 출력 리스트 모듈
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	/*
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	*/
	
	int startRow = (currentPage-1)*rowPerPage; // 1-0, 2-10, 3-20, 4-30,....
	
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	/*
		select diary_date diaryDate, title
		from diary
		where title like ?
		order by diary_date desc
		limit ?, ?
	*/
	String sql2 = "select diary_date diaryDate, title, update_date updateDate, create_date createDate from diary where title like ? order by diary_date desc limit ?, ?";
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	Connection conn = null;
	conn = DriverManager.getConnection( "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
%>

<%
	// lastPage 모듈
	String sql3 = "select count(*) cnt from diary where title like ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow = 0;
	if(rs3.next()) {
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>diaryList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	<style>
.container {
	display: flex;
	flex-direction: column;
	align-items: center;
}

a:hover {
	text-decoration: none;
	font-weight: bold;
	color: #000000;
}

a {
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
			<div class="col"></div>
			<div class="mt-5 col-12 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
		<h1>일기 목록</h1>
		<form method="get" action="/diary/diaryList.jsp">
		<div class="input-group mb-3">
  			<input type="text" class="form-control" placeholder="Search" name="searchWord">
  			<button class="btn btn-success" type="submit">검색</button>
		</div>
		<table class="table table-striped table-hover">
			 <thead>
			    <tr>
			      <th scope="col">#</th>
			      <th scope="col">Date	</th>
			      <th scope="col">Title</th>
			      <th scope="col">updateDate</th>
			      <th scope="col">createDate</th>
			    </tr>
			  </thead>
			  <tbody>
			<%
				int i = 1;
				while(rs2.next()) {
			%>
					<tr>
						<th scope="row"><%=i%></th>
						<td><a href="" class="diaryList-a"><%=rs2.getString("diaryDate")%>&nbsp;&nbsp;</a></td>
						<td><%=rs2.getString("title")%>&nbsp;&nbsp;</td>
						<td><%=rs2.getString("updateDate")%>&nbsp;&nbsp;</td>
						<td><%=rs2.getString("createDate")%>&nbsp;&nbsp;</td>
					</tr>
			<%		
					i += 1;
				}
			%>
			</tbody>
		</table>
		</div>
		<div class="col"></div>
		</div>
		</div>
		<div class="container">
			<div>
				<a href="">이전</a>
				<a href="">다음</a>
			</div>
		</div>
	</form>
</body>
</html>
