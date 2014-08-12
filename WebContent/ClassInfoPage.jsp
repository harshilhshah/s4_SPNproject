<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="java.util.ArrayList, spn_test.LoginBean, spn_test.ClassInfoDAO, spn_test.ClassInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Class Info Page</title>
</head>
<body bgcolor = "f6f1f0">
	<div style="position: absolute; top: 100px; left: 25px; width: 100px; border-radius: 15px;
		height: 300px; border: 1px solid red; background-color:white; overflow: scroll">
		<h3 style = "text-align: center; margin: 4px">Classes</h3>
		<form action="ClassInfoServlet" method="POST">
		
			<%
				ClassInfoDAO dao = new ClassInfoDAO();
				session.setAttribute("dao", dao);
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
		
		ClassInfo selec = (ClassInfo) session.getAttribute("Sel");
		if (selec != null) {
	%>
		<h1 style="text-align: center;">
			<%=selec.getCoursename()%></h1>
		<h2 style="text-align: center; margin: 0">
			01:<%=selec.getDeptid()%>:<%=selec.getCid()%></h2>
		<div style="height: 250px; margin: 25px 50px 100px 100px">
			<p>
				<strong>Prerequisites: </strong>
				<%dao.findPrereqs(selec); 
				ArrayList<Integer> a = selec.getPrereqs();
					for(Integer b: a){%> <em>
					<%= b.toString()%>
					</em>
					 <% } %>
			</p>
			<p>
				<strong>Building:  </strong>
				<%=selec.getBuilding()%></p>
			<p>
				<strong>Room Number:  </strong>
				<%=selec.getRoomNum() %></p>
			<p>
				<strong>Room Capacity:  </strong>
				<%=selec.getCapacity()%></p>
			<p>
				<strong>Class Timing:  </strong>
				<%=selec.getStart()%> - <%=selec.getEnd() %>
			</p>
			
			<form action="ClassInfoLoad.jsp" >
			Generate Special Permission Numbers:
			<input style = "width: 75px" type="number" name="quantity" min="1" max="5">
			</form>
			
			<% 
			}%>
		</div>
	</div>
<table>
<tr><td><a href="ProfessorMain.jsp">Back</a></td></tr>
<tr><td><a href="Main.jsp">Logout</a></td></tr>
</table>
</body>
</html>