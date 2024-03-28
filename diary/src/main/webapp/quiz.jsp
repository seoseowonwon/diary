<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>quiz</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	
	<h1>Quiz</h1>
	<form action="./quizAction.jsp">
		1) 자바 프로그램 개발 과정을 순서대로 적어보세요. ( ) -> ( ) -> ( ) -> ( )
		1. javac 명령어로 컴파일한다.
		2. 소스 파일(~.java)을 작성한다.
		3. java 명령어로 실행한다.
		4. 실행 결과를 확인한다.
		<br>
		<input type="text" name="quiz" placeholder="띄어쓰지말고 입력">
		<br>
		<br>
		2) 자바 소스에 대한 설명 중 소문자 영어 : o, x 
		1. 컴파일하면 클래스이름.class라는 바이트 코드 파일이 생성된다.
		2. main()메소드는 반드시 클래스 블록 내부에서 작성해야 한다.
		3. main()메소드를 작성할 때 중괄호 블록을 만들지 않아도 된다.
		4. 컴파일 후 실행을 하려면 반드시 main() 메소드가 있어야 한다.
		<br>
		<input type="text" name="quiz" placeholder="띄어쓰지말고 입력">
		<br>
		<br>
		
		
		3) 주석에 대한 설명 중 맞는 것에 o, x
		1. 뒤의 라인 내용은 모두 주석이 된다.
		2. /*부터 시작해서 */까지 모든 내용이 주석이 된다.
		3.주석이 많으면 바이트 코드 파일의 크기가 커지므로 꼭 필요한 경우에만 작성한다.
		4. 문자열 안에는 주석을 만들 수 없다.
		<br>
		<input type="text" name="quiz" placeholder="띄어쓰지말고 입력">
		<br>
		<br>
		
		4)이클립스의 자바 프로젝트에 대한 설명 o,x 
		1.기본적으로 소스 파일과 바이트 코드 파일이 저장되는 폴더가 다르다.
		2.자바 소스 파일을 작성하는 폴더는 src이다.
		3.선언되는 클래스 이름은 소스 파일 이름과 달라도 상관없다.
		4.올바르게 작성된 소스파일을 저장하면 자동으로 컴파일되고, 바이트 코드 파일이 생성된다.
		<br>
		<input type="text" name="quiz" placeholder="띄어쓰지말고 입력">
		<br>
		<br>
		
		5)이클립스에서 바이트 코드 파일을 실행하는 방법을 모두 선택해보세요.
		1. Package Explorer뷰에서 소스 파일을 더블클릭한다.
		2. Package Explorer 뷰에서 바이트 코드 파일을 선택하과, 툴 바에서 Run 아이콘을 클릭한다.
		3. Package Explorer 뷰에서 소스 파일을 선택하고, 툴 바에서 Run 아이콘을 클릭한다.
		4. Package Explorer 뷰에서 소스 파일을 선택하고, 마우스 오른쪽 버튼을 클릭한 후 [Run As] - [Java Application]을 선택한다.
		<br>
		<input type="text" name="quiz" placeholder="띄어쓰지말고 입력">
		<br>
		<br>
		<button type="submit">제출</button>
	</form>
</body>
</html>