<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="java.sql.*,java.util.ArrayList, spn_test.ConnectionManager, spn_test.LoginBean, spn_test.ClassInfoDAO, spn_test.ClassInfo, spn_test.StudentInfo, spn_test.StudentInfoDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Professor Main</title>
</head>
<body bgcolor = "f6f1f0">
	<div style="position: absolute; top: 100px; left: 25px; width: 100px; border-radius: 15px;
		height: 300px; border: 1px solid red; background-color:white; overflow: scroll">
		<h3 style = "text-align: center; margin: 4px">Classes</h3>
		<form action="ProfessorServlet" method="GET">
		
			<%
				ClassInfoDAO dao = new ClassInfoDAO();
				LoginBean sesUser = (LoginBean)session.getAttribute("currentSessionUser");
				request.setAttribute("User", sesUser.getUsername());
				ArrayList<ClassInfo> clist = dao.getClassesByProf(sesUser.getUsername());
				if (clist != null) {
					int len = clist.size();
					for (int count = 0; count < len; count++) {
			%>

			<input style="height: 40px; width: 100px; font-size: 14px; border: 0; 
			outline: #00FF00 solid 4px;" type="submit"
			name="<%=clist.get(count).getDeptid()%> : <%=clist.get(count).getCid()%>"
			value="<%=clist.get(count).getDeptid()%> : <%=clist.get(count).getCid()%>" >
			
			<%
					}
				}
			%>
			
		</form>
	</div>
		
	<div style="height: 500px; margin: 20px 50px 100px 65px; 
	border: 1px solid red; background-color: #f4f4ef">
	
	<%
		ClassInfo selec = (ClassInfo) request.getAttribute("Sel");
		if (selec != null) {
	%>
		<table border=1 width=100%>
		<tr>
		<th>Student Information</th>
		<th>NETID</th>
		<th>Name</th>
		<th>Major</th>
		<th>GPA</th>
		<th>Credits</th>
		<th>Permission Number</th>
		</tr>
		<%
				boolean prereq = request.getAttribute( "prereq" ) != null;
				boolean gpa = request.getAttribute( "gpa" ) != null;
				boolean credits = request.getAttribute( "credits" ) != null;
				String cid = String.valueOf(selec.getCid());
				StudentInfoDAO sdao = new StudentInfoDAO();
				ArrayList<StudentInfo> sinfo = sdao.getStudents(sesUser.getUsername(), prereq, gpa, credits, cid);
				if (sinfo != null) {
					int slen = sinfo.size();
					for (int scount = 0; scount < slen; scount++) {
		%>
		<tr>
		<td></td>
		<td><%=sinfo.get(scount).getNetid() %></td>
		<td><%=sinfo.get(scount).getName() %></td>
		<td><%=sinfo.get(scount).getMajor() %></td>
		<td><%=sinfo.get(scount).getGpa() %></td>
		<td><%=sinfo.get(scount).getCredits() %></td>
		<td><%=sinfo.get(scount).getSPN() %>
		</tr>
		<%
		
					}
					}
				}
		%>
		</table>
		</div>
<form action="ProfessorServlet" method="GET">
<table>
<tr><td><label><input type="checkbox" name="prereq">Prerequisites Complete</label>
<label><input type="checkbox" name="gpa">GPA</label>
<label><input type="checkbox" name="credits">Credits</label></td></tr>
<tr><td><input type="submit" name="submitrequery" value="Requery"/></td></tr>
</table>
</form>
<form action=UpdateServlet method="POST">
<table>
<td><tr>
<label><input type="text" name="updateNums"/>List Special Permission Numbers to Update (Separated by comma).</label>
<input type="submit" name="submit" value="Accept"/>
<input type="submit" name="submit" value="Decline"/>
<%
Connection conn = ConnectionManager.getConnection();
String button = request.getParameter("submit");
String status;
if (button != null && button.equals("Accept")) {
	status = "1";
	String spn = request.getParameter("updateNums");
	String sql = "UPDATE permission SET status = '" + status + "' "
				+ "WHERE spn IN (" + spn + ")";
	PreparedStatement ps = conn.prepareStatement(sql);
	int retval = ps.executeUpdate();
} else {
	status = "-1";
	String spn = request.getParameter("updateNums");
	String sql = "UPDATE permission SET status = '" + status + "' "
				+ "WHERE spn IN (" + spn + ")";
	PreparedStatement ps = conn.prepareStatement(sql);
	int retval = ps.executeUpdate();
}

%>
</td></tr>
<td><a href="ClassInfoPage.jsp">Class Information</a></td>
</table>
</form>
<table>
<tr><td><a href="Professor_login.jsp">Back</a></td></tr>
<tr><td><a href="Main.jsp">Logout</a></td></tr>
</table>
</body>
</html>