package spn_test;

import java.sql.*;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class StudentInfoDAO {
	static Connection conn = null;
	static ResultSet rs = null;
	
	public ArrayList<StudentInfo> getStudents(String pname, boolean prereq, boolean gpa, boolean creditstaken, String cid){

		ArrayList<StudentInfo> studentlist = new ArrayList<StudentInfo>();
		conn = (Connection) ConnectionManager.getConnection();
		String sql = "SELECT s.netid, s.s_name, s.credits, s.gpa, s.major, p.spn FROM student s, permission p "
				+ "WHERE s.netid = p.netid AND s.netid IN (SELECT DISTINCT netid FROM permission WHERE status = 0 AND c_id = '" + cid + "' AND p_id = "
				+ "(SELECT DISTINCT p_id FROM professor WHERE p_name = '" + pname + "'))";
		if (prereq == true) {
			// prereq SQL
			sql += " AND netid IN ("
					+ "SELECT DISTINCT netid FROM student s, class c"
					+ "WHERE c_id IN (SELECT DISTINCT c_id FROM taken WHERE netid = s.netid))";
		}
		if (gpa == true && creditstaken == true) {
			sql += " ORDER BY gpa DESC, credits DESC";
		} else if (gpa == true) {
			sql += " ORDER BY gpa ASC";
		} else if (creditstaken == true) {
			sql += " ORDER BY credits ASC";
		}
		sql += ";";
		try{
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentInfo sInfo = new StudentInfo();
				sInfo.setCredits(Integer.parseInt(rs.getString("s.credits")));
				sInfo.setGpa(Float.parseFloat(rs.getString("s.gpa")));
				sInfo.setMajor(rs.getString("s.major"));
				sInfo.setNetid(rs.getString("s.netid"));
				sInfo.setStudentName(rs.getString("s.s_name"));
				sInfo.setSPN(rs.getString("p.spn"));
				studentlist.add(sInfo);
			}
		}
		catch (Exception ex){
			System.out.println(ex);
		}

		return studentlist;
	}
}
