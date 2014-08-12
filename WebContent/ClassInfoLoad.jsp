<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page
	import="spn_test.ClassInfoDAO, spn_test.ClassInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Load Class Info</title>
</head>
<body>

<% if (request.getParameter("quantity")!=null 
			&& Integer.parseInt(request.getParameter("quantity"))>0){
					
	ClassInfoDAO dao =  (ClassInfoDAO) session.getAttribute("dao");	
	boolean b = dao.createNewSPN(Integer.parseInt(request.getParameter("quantity")), 
			(ClassInfo) session.getAttribute("Sel"));
			
			
	System.out.print(b);
}
		%>
<a href="ClassInfoPage.jsp">Success. Go back.</a>
</body>
</html>