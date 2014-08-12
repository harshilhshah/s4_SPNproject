<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,spn_test.ConnectionManager, spn_test.LoginBean" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Main Page</title>
</head>
<body>
<%
			LoginBean sesUser = (LoginBean)session.getAttribute("currentSessionUser");
			Connection conn = ConnectionManager.getConnection();
			PreparedStatement ps = null;
			String sql = "select * 	FROM permission p, class c, course S WHERE c.c_id = p.c_id AND S.c_id = c.c_id "
					+ " AND p.netid = '" + sesUser.getUsername() + "'";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
		%>
		<div style="position:fixed; height: 500px; width: 750px; margin: 20px 50px 100px 65px; 
    	border: 1px solid red; background-color: #f4f4ef">
    	<h1 style = "text-align:center">Requested Special Permission Numbers</h1>
    	<div>
    	<table>
    	<tr>
   	 	<th style = "padding-left: 75px"> Classes </th>
      	<th style = "padding-left: 75px"> Status </th>
      	<th style = "padding-left: 75px"> Delete </th>
    	</tr>
   		<% while(rs.next()){
   			String course = rs.getString("c_name");
   			String status = rs.getString("status");
   			%>
   				<tr><td style = "padding-left: 75px"><%= course %></td> <td style = "padding-left: 75px"><%=status %></td> <td style = "padding-left: 75px"><button type ="button">delete</button></td> </tr>
   		<%} %>
  </table>
  	</div>
  	<div>
  		<a href = "list_course.jsp">schedule</a>
  		<a href = "drop_down_menu.jsp">Select Spn#</a>
  		
  		</div>
    	</div>
<table>
<tr><td><a href="Student_login.jsp">Back</a></td></tr>
<tr><td><a href="Main.jsp">Logout</a></td></tr>
</table>
</body>
</html>
