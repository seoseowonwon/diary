<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
//값 요청
	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	String updateDate = request.getParameter("updateDate");
	String createDate = request.getParameter("createDate");
	
	//디버깅
	System.out.println("updateDiaryAction diaryDate --> "+diaryDate);
	System.out.println("updateDiaryAction title --> "+title);
	System.out.println("updateDiaryAction weather --> "+weather);
	System.out.println("updateDiaryAction content --> "+content);
	System.out.println("updateDiaryAction updateDate --> "+updateDate);
	System.out.println("updateDiaryAction createDate --> "+createDate);
	
	String sql = "UPDATE diary SET title = ?, content = ?, update_date = now() WHERE diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, title);
	stmt.setString(2, content);
	stmt.setString(3, diaryDate);
	
	//디버깅
	System.out.println("updateDiaryAction stmt --> "+stmt);
	
	//성공했다면 row = 1
	int row = stmt.executeUpdate();
	if(row==1) { // update 성공
		  response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
		  System.out.println("updateDiaryAction UPDATE 성공!!!");
	  } else { // update 실패
	  		response.sendRedirect("/diary/diaryOne.jsp?updateDiaryForm="+diaryDate);
	  		System.out.println("updateDiaryAction UPDATE 실패...");	
	  }
%>