<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("deleteDiaryAction diaryDate --> "+diaryDate);
	
	
	// 삭제할때 사용
	
		String sql1 = "delete from diary where diary_date = ?";
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
		PreparedStatement stmt1 = null;
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, diaryDate);

		
		int row = stmt1.executeUpdate();
		
		if(row == 1){  
			System.out.println("삭제 성공");
			response.sendRedirect("/diary/diary.jsp?");
		} else {
			response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
		}
		
		  
	%>