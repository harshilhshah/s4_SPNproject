<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body >
<%
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/s4spnproject";
        String uname = "root";
        String pwd = "rutgerscs336";
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
			String sql = "select * from class, course where course.c_id = class.c_id " + 
			"and exists (select c_id from professor, teaching where p_name = 'Yvette Buchanan')";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String course_title = rs.getString("c_name");
		%>
			<input type = "submit" value = "<%= course_title %>">
<%} %>
		

</body>
</html>