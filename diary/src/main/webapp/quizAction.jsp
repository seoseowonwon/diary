<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int score = 0;

	String arr[] = request.getParameterValues("quiz");
	//디버깅
	System.out.println("quizAciton arr --> "+arr);
	String numbers[] = {"2134","ooxo","ooxo","ooxo","34"};
	for(int i=0; i<numbers.length; i++) {
		for(int j=0; j<numbers[i].length(); j++){
			if(j <= numbers[i].length()-1){
				if(numbers[i].substring(j,j+1).equals(arr[i].substring(j,j+1))){
					//디버깅
					System.out.println(numbers[i].substring(j,j+1)+ arr[i].substring(j,j+1));
					score += 1;
				}
			}
			
		}
    	
	}
	System.out.println(score);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>quiz</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<input type="text" value="<%=score%>개 맞추셨습니다!">
</body>
</html>