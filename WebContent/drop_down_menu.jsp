<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="spn_test.ConnectionManager, spn_test.LoginBean, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List SPN Courses</title>
</head>
<body bgcolor = "f6f1f0">
<% String formAction = (String)request.getAttribute("formAction"); %>
<div style = "background: #f6F1e0; width: 220px;
    padding-top: 10px; padding-left: 25px; height:250px;
    border: 1px solid red; margin:10px; font-size:0.8em"> &#x25BE; Find Courses
	<form action="FormServlet" method = "POST">
		<%
			Connection conn = ConnectionManager.getConnection();
			String sql = "SELECT * FROM department order by d_name";
			PreparedStatement ps = conn.prepareStatement(sql);
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
		if (formAction != null && formAction.equals("getCourses")) {
			dept_selec_str = request.getParameter("item");
			dept_selec_id = Integer.parseInt(dept_selec_str);
			session.setAttribute("dept", dept_selec_str);
			if (dept_selec_id != 0) {
				sql = "select * from course where dept_id = "
						+ dept_selec_str + " order by c_name;";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
	%>
	<form action="drop_down_menu.jsp">
		<div
			style="position: absolute; top: 10px; left: 264px; right: 10px; max-height: 250px; border: 1px solid red; overflow: scroll">
			<%
				while (rs.next()) {
							String courseName = rs.getString("c_name");
							String cID = rs.getString("c_id");
			%>

			<input style="margin: 20px" type="checkbox" name="course"
				value="<%=cID%>">
			<%=courseName%>
			<br>
			<%
				}
			%>
		</div>
		<div style="position: absolute; top: 200px; left: 85px">
			<input
				style="border-radius: 20px; height: 30px; width: 100px; font-size: 14px; border: 0;"
				type="submit" value="Submit">
		</div>
	</form>
	<%
			}
		}

		String select[] = request.getParameterValues("course");
		if (select != null && select.length != 0) {
			for (int i = 0; i < select.length; i++) {
				LoginBean bUser = (LoginBean)session.getAttribute("currentSessionUser");
				sql = "select *	from course where course.c_id = \"" + select[i] + 
						"\" and course.c_id in (select permission.c_id from permission where netid = " 
				+ bUser.getUsername() + " )";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				if(!rs.next()){ 
						String countSql = "select count(*) from permission where netid = 0 and c_id = " 
				+ select[i] + " and dept_id = " + (String)session.getAttribute("dept");
						ps = conn.prepareStatement(countSql);
							rs = ps.executeQuery();
							rs.next();
							int count = Integer.parseInt(rs.getString("count(*)"));
							if(count>0){
								sql = "select spn from permission where netid = 0 and c_id = " 
										+ select[i] + " and dept_id = " + (String)session.getAttribute("dept");
								ps = conn.prepareStatement(sql);
								ResultSet rss = ps.executeQuery();
								rss.next(); 
								String spn = rss.getString("spn");
								sql = "UPDATE `permission` SET `netid`='" + bUser.getUsername() + "' WHERE `spn`='" + spn + "'";
								ps = conn.prepareStatement(sql);
								int rss3 = ps.executeUpdate();
								
								if (rss3 == 1) {
									%><p> Success! SPN Request for <%=select[i]%> has been sent to the professor.</p>
									<%
								} else {
									%><p> Unable to request spn for <%=select[i]%> because none exist for this class</p>
									<%
								}
							}

				%>
					<p> Success! SPN Request for <%=select[i]%> has been sent to the professor.</p>
				<% }
				else{  %>
					<p> Unable to request spn for <%=select[i]%> because you have already requested for this class</p>
				<%}
				session.setAttribute("course_selection", select[i] + "|");
			}
		}
	%>
<table>
<tr><td><a href="StudentMain.jsp">Back</a></td></tr>
<tr><td><a href="Main.jsp">Logout</a></td></tr>
</table>
</body>
</html>