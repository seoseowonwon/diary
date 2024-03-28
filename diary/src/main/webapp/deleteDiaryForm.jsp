<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	//요청 값
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("deleteDiaryForm diaryDate --> "+diaryDate);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteDiaryForm</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<form method="post" action="/diary/deleteDiaryAction.jsp">
		<div class="row">
			<div class="col"></div> <!-- 간격 채우기용 -->
			<div class="mt-5 col-8 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
				<div class="input-group input-group-sm mb-3">
  					<span class="input-group-text">날짜를 입력하세요</span>
  					<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="diaryDate" >
  					<button type="submit">삭제</button>
				</div>
			</div>
			<div class="col"></div> <!-- 간격 채우기용 -->
		</div>
	</form>
</body>
</html>