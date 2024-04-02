<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>

<%
	//0. login(인증) 분기
	// diary.login.my_session (DB이름, 테이블, 컬럼) => my_ssion의 값이 ON이면 -> redirect ("diary.jsp")으로 이동
	
	/*String sql1 = "select my_session mySession from login"; //mySession같은 경우 아이어스 별칭
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
		response.sendRedirect("/diary/loginForm.jsp?"); // 
		
		//자원 반납 코드
		rs1.close();
		stmt1.close();
		conn.close();
		return; // 코드 진행을 끝내는 문법
	}*/
%>
<%
	String loginMember = (String) session.getAttribute("loginMember");
	//session.getAttribute 찾는 변수가 없으면 null값을 반환
	// null 이라면 로그아웃상태, != 로그인 상태
	System.out.println("loginForm loginMember-->"+loginMember);
	
	//loginForm페이즌
	if(loginMember != null){
		response.sendRedirect("/diary/diary.jsp?");
		return;
	}
	
	// loginMember가 null이다 -> session공간에 loginMember변수를 생성하고
%>
<%
	// 1. 요청값 분석 -> 로그인 성공 -> session에 loginMember생성
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	// member테이블의 ID, PW 정보
	String sql2 = "select member_id memberId from member where member_id= ? and member_pw = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, memberId);
	stmt2.setString(2, memberPw);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()){
		//로그인 성공
		// diary.login.my_session 값을 "ON"으로 UPDATE
		System.out.println("로그인 성공");
		/*
		String sql3 = "update login set my_session = 'ON', on_date = NOW()";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println("loginAction row --> "+row);
		*/
		// login 성공시 DB값 설정 -> sesssion변수 설정
		response.sendRedirect("/diary/diary.jsp");
		session.setAttribute("loginMember", rs2.getString("memberId"));
		
	} else {
		//로그인 실패
		String errMsg = URLEncoder.encode( "ID와 PW를 확인해 주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		System.out.println("로그인 실패");
	}
	
	//자원반납 동시에 로그인할 때 에러뜨는것을 방지한다는뎁쇼?
	
	
	rs2.close();
	stmt2.close();
	
	conn.close();
	

%>