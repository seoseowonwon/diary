<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>
<%
	// login(인증) 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null){
			String errMsg = URLEncoder.encode("잘못된접근");
			response.sendRedirect("/diary/diary.jsp");
			return;
	}
	// diary.login.my_session (DB이름, 테이블, 컬럼) => my_session의 값이 OFF이면 -> redirect ("loginForm.jsp")으로 이동
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
	
	if(mySession.equals("OFF")){
		
		String errMsg = URLEncoder.encode( "잘못된 접근 입니다. 로그인 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 
		
		//자원 반납 코드
		rs1.close();
		stmt1.close();
		conn.close();
		return; // 코드 진행을 끝내는 문법
	} 
	// if문에 걸리지 않을 때..*/
%>

<%	

	
	// 1. 요청 분석
		// 출력하고자는 달력의 년과 월값을 넘겨받음
		
		String targetYear = request.getParameter("targetYear");
		String targetMonth = request.getParameter("targetMonth");
		
		Calendar target = Calendar.getInstance();
		
		if(targetYear != null && targetMonth != null) {
			target.set(Calendar.YEAR, Integer.parseInt(targetYear));
			target.set(Calendar.MONTH, Integer.parseInt(targetMonth)); 
		}
		// 시작공백의 개수 -> 1일의 요일이 필요 -> 요일에 맵핑된 숫자 -> 타겟 날짜를 1일로변경
		target.set(Calendar.DATE, 1);
		
		// 달력 타이틀로 출력할 변수
		int tYear = target.get(Calendar.YEAR);
		int tMonth = target.get(Calendar.MONTH);
		int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일:1, 월:2, .....토:7
		System.out.println(yoNum); 
		// 시작공백의 개수 : 일요일 공백이 없고, 월요일은 1칸, 화요일은 2칸,....yoNum - 1이 공백의 개수
		int startBlank = yoNum - 1;
		int lastDate = target.getActualMaximum(Calendar.DATE); // target달의 마지막 날짜 반환
		System.out.println("diary lastDate --> "+lastDate);
		int countDiv = startBlank + lastDate;
		
		//전달
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.MONTH, tMonth-1);
		int mlastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		System.out.println("저번 달의 마지막 날짜는: " + mlastDay + "일 입니다.");
		
		int cutWeek = 0;
		if(startBlank+lastDate <= 35){
			cutWeek = 35;
		} else {
			cutWeek = 42;
		}
		
		//tYear와 tMonth에 해당되는 diary 목록을 DB에서 가져옴 
		String sql2 = "select diary_date diaryDate, DAY(diary_date) DAY , feeling, left(title, 3) title from diary where year(diary_date) = ? and month(diary_date) = ? ";
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
		
		
		
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, tYear);
		stmt2.setInt(2, tMonth+1);
		System.out.println("diary stmt2 -->"+stmt2);
		
		rs2 = stmt2.executeQuery();
		
		
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Diary</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
.cell {
	float: left;
	width: 70px;
	height: 70px;
	border-radius: 2px;
	margin: 5px;
	border: 1px solid #AED09C;
	background-color: 
}

.sun {
	clear: both;
}

.sat {
	clear: right;
}

.yo {
	float: left;
	width: 70px;
	height: 25px;
	border-radius: 10px;
	margin: 5px;
	text-align: center;
	border: 1px solid #AED09C;
}
	.test{
		 box-sizing:border-box;
	}
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
			<div class="mt-5 col-8 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded test">
				<h1><%=tYear%>년
					<%=tMonth + 1%>월
				</h1>
				<div>
					<a href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth - 1%>&mlastDay=<%=lastDate%>">이전달</a>
					<a href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth + 1%>&mlastDay=<%=lastDate%>">다음달</a>
				</div>
				<div class="yo">일</div>
				<div class="yo">월</div>
				<div class="yo">화</div>
				<div class="yo">수</div>
				<div class="yo">목</div>
				<div class="yo">금</div>
				<div class="yo">토</div>
				<!-- DATE값이 들어갈 DIV -->
				<%
				for (int i = 1; i <= cutWeek; i = i + 1) {

					if (i % 7 == 1) {
				%>
				<div class="cell sun">
					<%
					} else if (i % 7 == 0) {
					%>
					<div class="cell sat">
						<%
						} else {
						%>
						<div class="cell">
							<%
							}
							if (i - startBlank > 0 && i <= lastDate + startBlank) {
							%>
								<%=i - startBlank%><br>
							<%
							
								// 현재 날짜 (i-startBalnk)의 일기가 rs2목록에 있는지 비교하는 코드
								while(rs2.next()){
									//날짜에 일기가 존재한다
									if(rs2.getInt("day")== (i - startBlank)){
							%>
										<div>
											<span><%=rs2.getString("feeling")%></span>
										</div>
										<div>
											<a href='/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>'>
												<%=rs2.getString("title") %>...
											</a>
										</div>
							<%
										break;
									}
								}
								rs2.beforeFirst(); // ResultSet의 커서 위치를 처음으로 되돌리는 소스코드.
							} else if (i - 1 - startBlank < 0) {
							%>
							<div style="color: #BDBDBD"><%=mlastDay - startBlank + i%></div>
							<%
							} else {
							%>
							<div style="color: #BDBDBD"><%=i - countDiv%></div>
							<%
							}
							%>
						</div>
						<%
						}
						%>
					</div>
					<div class="col-2"></div>
				</div>
				<!-- class="row" -->
			</div>
			<!-- class="container" -->
		</div>
	</div>
		
</body>
</html>