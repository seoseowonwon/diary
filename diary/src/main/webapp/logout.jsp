<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	// session.removeAttribute("loginMember");
	System.out.println("logout sessiongetId 호출 전 --> "+ session.getId());
	session.invalidate(); // 초기화
	System.out.println("logout sessiongetId 호출 후 --> "+ session.getId());
	response.sendRedirect("/diary/loginForm.jsp");
%>
