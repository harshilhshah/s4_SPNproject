<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor = "f6f1f0">
<% String formAction = (String)request.getAttribute("formAction"); %>
<div style = "background: #f6F1e0; width: 220px;
    padding-top: 10px; padding-left: 25px; height:250px;
    border: 1px solid red; margin:10px; font-size:0.8em"> &#x25BE; Find Courses
	<form action="/Spn_project/FormServlet" method = "POST">
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
			String sql = "SELECT * FROM department order by d_name";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
		%>
		<p>
			<select name = "item" style = "box-shadow: 0 1px 3px rgba(0,0,0,.15)">
				<option value = "0"> Select a Subject Area ---</option>
				<%
					while (rs.next()) {
							String deptName = rs.getString("d_name");
							String deptID = rs.getString("dept_id");
				%>
				<option value="<%=deptID%>"><%=deptName%></option>
				<%
					}
				%>
			</select>
		</p>
		<input value="Search→" type="submit">
	</form>
</div>
	<%
	int dept_selec_id = 0;
	String dept_selec_str = null;
	if(formAction != null && formAction.equals("getCourses")){
	dept_selec_str = request.getParameter("item");
	dept_selec_id = Integer.parseInt(dept_selec_str);
	if(dept_selec_id != 0) { 
		sql = "select * from course where dept_id = " + dept_selec_str + " order by c_name;";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
%>
<form action = "drop_down_menu.jsp">
<div style = "position:absolute; top:10px; left:264px; right:10px; max-height: 250px; border:1px solid red; overflow:scroll">
<% while (rs.next()) {
	String courseName = rs.getString("c_name");
	%>

<input style = "margin:20px" type = "checkbox" name = "course" value = "<%=courseName%>"> <%=courseName%> <br>
<% } %>
</div>
<div style = "position:absolute; top:200px; left: 85px">
<input style = "border-radius: 20px; height: 30px;
  width: 100px; font-size: 14px; border:0;" type="submit" value="Submit">
</div>
</form>
<% }
	}%>
<%

String select[] = request.getParameterValues("course"); 
if (select != null && select.length != 0) {
out.println("You have selected: ");
for (int i = 0; i < select.length; i++) {
out.println(select[i]); 
}
}
%>
</body>
</html>