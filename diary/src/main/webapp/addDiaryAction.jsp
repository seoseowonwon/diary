<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.URLEncoder"%>

<%
	//요청 값 받아 오기
	String diaryDate = request.getParameter("diaryDate");
	String feeling = request.getParameter("feeling");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	
	
	//디버깅
	System.out.println("addDiaryAction diaryDate --> "+diaryDate);	
	System.out.println("addDiaryAction feeling --> "+feeling);	
	System.out.println("addDiaryAction title --> "+title);
	System.out.println("addDiaryAction weather --> "+weather);
	System.out.println("addDiaryAction content --> "+content);

	
	
	// 테이블 diary에 값들을 추가
	String sql1 = "INSERT INTO diary (diary_date, feeling, title, weather, content, update_date, create_date) VALUES( ?, ?, ?, ?, ?, NOW(), NOW())";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, diaryDate);
	stmt1.setString(2, feeling);
	stmt1.setString(3, title);
	stmt1.setString(4, weather);
	stmt1.setString(5, content);
	System.out.println("addDiaryAction stmt1 --> "+stmt1);
	
	
	int row =stmt1.executeUpdate();
	//row가 잘 업데이트 되었는가 확인하는 디버깅
	System.out.println("addDiaryAction row --> "+row);
	
	if(row == 1){
		System.out.println("addDiaryAction 입력 성공!!!");
		response.sendRedirect("/diary/diary.jsp");
	} else {
		System.out.println("addDiaryAction 입력 실패...");
		response.sendRedirect("/diary/addDiaryForm.jsp");
	}
	
%>