<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="java.util.ArrayList, spn_test.LoginBean, spn_test.ClassInfoDAO, spn_test.ClassInfo, spn_test.StudentInfo, spn_test.StudentInfoDAO"%>
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
		<th>NETID</th>
		<th>Name</th>
		<th>Major</th>
		<th>Credits</th>
		<th>GPA</th>
		</tr>
		<tr>
		<%
				int prereq = (Integer) request.getAttribute("prereq");
				int gpa = (Integer) request.getAttribute("gpa");
				int credits = (Integer) request.getAttribute("credits");
				String cid = String.valueOf(selec.getCid());
				StudentInfoDAO sdao = new StudentInfoDAO();
				ArrayList<StudentInfo> sinfo = sdao.getStudents(sesUser.getUsername(), prereq, gpa, credits, cid);
				if (sinfo != null) {
					int slen = sinfo.size();
					for (int scount = 0; scount < slen; scount++) {
		%>
		<td><%=sinfo.get(scount).getNetid() %></td>
		<td><%=sinfo.get(scount).getName() %></td>
		<td><%=sinfo.get(scount).getMajor() %></td>
		<td><%=sinfo.get(scount).getGpa() %></td>
		<td><%=sinfo.get(scount).getCredits() %></td>
		</tr>
		</table>
		<%
		
					}
					}
				}
		%>
<table>
<tr><td><label><input type="checkbox" name="prereq">Prerequisites Complete</label></td>
<td><label><input type="checkbox" name="gpa">GPA</label></td>
<td><label><input type="checkbox" name="credits">Credits</label></td></tr>
<tr><td><input type="submit" value="Requery"></td></tr>
</table>
<a href="/CS336_S4/class_information.jsp">Class Information</a>
</body>
</html>