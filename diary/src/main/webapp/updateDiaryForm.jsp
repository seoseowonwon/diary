<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("updateDiaryForm diaryDate --> "+diaryDate);
	
	String sql= "SELECT diary_date diaryDate, title,  weather, content, update_date updateDate, create_date createDate FROM diary WHERE diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt = null;
	stmt =conn.prepareStatement(sql);
	ResultSet rs =  null;
	stmt.setString(1, diaryDate);
	System.out.println("updateDiaryForm stmt --> "+stmt);
	rs=stmt.executeQuery();
	
	if(rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateDiaryForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<h3>수정</h3>
	<form method="post" action="/diary/updateDiaryAction.jsp">
		<div>
			<label class="form label">날짜</label> <input type="text"
				class=form-control name="diaryDate"
				value='<%=rs.getString("diaryDate")%>' readonly="readonly">
		</div>
		
		<div>
			<label class="form-label">제목</label> <input type="text"
				class="form-control" name="title" value='<%=rs.getString("title")%>'>
		</div>

		<div>
			<label class="form-label">날씨</label> <input type="text"
				class="form-control" name="weather" value='<%=rs.getString("weather")%>' readonly="readonly">
		</div>

		<div>
			<label class="form-label">update_date</label> <input type="text"
				class="form-control" name="updateDate"
				value='<%=rs.getString("updateDate")%>' readonly="readonly">
		</div>

		<div>
			<label class="form-label">create_date</label> <input type="text"
				class="form-control" name="createDate"
				value='<%=rs.getString("createDate")%>' readonly="readonly">
		</div>

		<div class="input-group">
  			<span class="input-group-text">내용</span>
  			<textarea class="form-control" aria-label="With textarea"
  			name="content"><%=rs.getString("content") %></textarea>
		</div>

		<div>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>
<%
	}
%>
