<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256" %>
<%@page
	import="java.sql.*, spn_test.LoginBean, spn_test.ClassInfoDAO, spn_test.ClassInfo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>Login Page</title> </head>
<body>
<%	
	if(request.getAttribute("user")!= null && request.getAttribute("user").equals("fail")){ 
		System.out.println("Fail");%>
	<p> <em> Authentication Failed </em> </p>
	<% } %>
	
<form name="studentForm" action="LoginServlet" method ="GET">
<table>
<tr><td>Enter your Username: </td><td><input type="text" name="uname"/></td></tr>
<tr><td>Enter your Password: </td><td><input type="password" name="password"/></td></tr>
<tr><td colspan="2" align="center"><input type="submit" value="submit"> </td></tr>
</table>
</form>
<table>
<td><a href="Main.jsp">Back</a></td>
</table>
</body>
</html>