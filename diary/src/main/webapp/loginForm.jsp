<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<%
	//0. login(인증) 분기
	// diary.login.my_session (DB이름, 테이블, 컬럼) => my_ssion의 값이 ON이면 -> redirect ("diary.jsp")으로 이동
	
	String sql1 = "select my_session mySession from login"; //mySession같은 경우 아이어스 별칭
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("ON")){
		response.sendRedirect("/diary/diary.jsp?"); // 
		
		//자원 반납 코드
		rs1.close();
		stmt1.close();
		conn.close();
		return; // 코드 진행을 끝내는 문법
	}
	
	//자원반납
	rs1.close();
	stmt1.close();
	conn.close();
	
	// 1. 요청값 분석
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<style>
	.body {
		
	    background-image: url(/diary/img/memo.jpg) ;
	    background-position: center center;
	    height: 100%;
	    width: 50%;
	  	background-size: cover;
	    background-repeat: no-repeat;
	}
	
	.container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh; /* 뷰포트 높이에 맞춰 세로 중앙 정렬 */
    }
	
	.table-center {
		vertical-align: center;
	}
	
</style>
<body>

	<div class="col-4"></div>
	<div
		class="col-4 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
		<form method="post" action="/diary/loginAction.jsp">
			<%
							if(errMsg!=null){
						%>
			<div style="color: #BDBDBD"><%=errMsg %></div>
			<%						
							}
						%>

			<table class="table table-hover">
				<h2>로그인</h2>
				<tr>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" name="memberId"
							placeholder="member Id"> <label for="floatingInput">member
							Id</label>
					</div>
				</tr>
				<tr>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" name="memberPw"
							placeholder="member Password"> <label for="floatingInput">member
							Password</label>
					</div>
				</tr>
			</table>

			<div class="d-flex flex-row-reverse">
				<button type="submit" class="btn btn-outline-success">로그인</button>
			</div>

		</form>
	</div>
	<div class="col-4"></div>
</body>
</html>