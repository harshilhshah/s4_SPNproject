<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*, spn_test.ConnectionManager, spn_test.LoginBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Courses</title>
</head>
<body>
		<%
			Connection conn = ConnectionManager.getConnection();
			LoginBean sesUser = (LoginBean)session.getAttribute("currentSessionUser");
			PreparedStatement ps = null;
			String newsql = "select * from course C, enrolled E, student S, class L "
					+ "where E.netid = S.netid AND L.c_id = C.c_id AND E.c_id = L.c_id AND S.netid = '" + sesUser.getUsername() + "';";
			String sql = "select *	FROM class l, course s WHERE l.c_id = s.c_id";
			ps = conn.prepareStatement(newsql);
			ResultSet rs = ps.executeQuery();
		%>
		<h1 style = text-align:center>List Of Courses</h1>
		
  		<table align = "center" ; style ="border:1px solid black">
  		 
    	<tr><th>Course Name</th><th>Start Time</th><th>End Time</th></tr>
		<%
			while (rs.next()) {
				String course = rs.getString("c_name");
				String stime = rs.getString("start_time");
				String etime = rs.getString("end_time");
		%>
			
    	<tr><td><%=course%></td><td><%=stime %></td><td><%= etime %></td></tr>
			<% }%>
		
		</table>
		</div>
	</form>
</div>
<table>
<tr><td><a href="StudentMain.jsp">Back</a></td></tr>
<tr><td><a href="Main.jsp">Logout</a><td></tr>
</table>
</body>
</html>