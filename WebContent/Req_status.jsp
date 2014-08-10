<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/test";
        String uname = "root";
        String pwd = "RashmikA1994";
        Class.forName("com.mysql.jdbc.Driver");
        try
        {
            conn = DriverManager.getConnection(url,uname,pwd);
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
			PreparedStatement ps = null;
			String sql = "select * 	FROM permission p, class c, course S WHERE c.c_id = p.c_id AND S.c_id = c.c_id ";
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
  	<div style = "margin-top:-50px">
  		<a href = "list_course.jsp">schedule</a>
  		<a href = "drop_down_menu.jsp">Select Spn#</a>
  		
  		</div>
    	</div>
</body>
</html>
