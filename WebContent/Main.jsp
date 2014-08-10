<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="position:fixed; height: 500px; width: 750px; margin: 5px; 
	border: 1px solid red; background-color: #f4f4ef">
	<img src ="http://paul.rutgers.edu/~tgaaly/images2/header.jpg"
	width= "750px" height = "100px">
  <h1 style = "text-align:center">Select Your User Type </h1>
  <div style = "position:fixed; padding-left:250px">
  <form action = "Student_login.jsp">
  <input type = "submit" name = "student" value = "Student" style = "margin:15px; height: 40px; width: 100px; font-size: 20px; border: 0;">
  </form>
  <form action = "Professor_login.jsp">
  <input type = "submit" name = "professor" value = "Professor" style = "margin: 15px; height: 40px; width: 100px; font-size: 20px; border: 0;">
  </form>
  </div>
	</div>
</body>
</html>