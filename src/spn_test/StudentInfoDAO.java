package spn_test;

import java.sql.*;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class StudentInfoDAO {
	static Connection conn = null;
	static ResultSet rs = null;
	
	public ArrayList<StudentInfo> getStudents(String pname, int prereq, int gpa, int creditstaken, String cid){

		ArrayList<StudentInfo> studentlist = new ArrayList<StudentInfo>();
		conn = (Connection) ConnectionManager.getConnection();
		String sql = "SELECT netid, s_name, credits, gpa, major FROM student "
				+ "WHERE netid IN (SELECT netid FROM permission WHERE c_id = '" + cid + "' AND p_id = "
				+ "(SELECT DISTINCT p_id FROM professor WHERE p_name = '" + pname + "'))";
		if (prereq == 1) {
			// prereq SQL
			sql += " AND ";
		}
		if (gpa == 1 && creditstaken == 1) {
			sql += " ORDER BY gpa DESC, credits DESC";
		} else if (gpa == 1) {
			sql += " ORDER BY gpa DESC";
		} else if (creditstaken == 1) {
			sql += " ORDER BY credits DESC";
		}
		sql += ";";
		try{
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentInfo sInfo = new StudentInfo();
				sInfo.setCredits(Integer.parseInt(rs.getString("credits")));
				sInfo.setGpa(Float.parseFloat(rs.getString("gpa")));
				sInfo.setMajor(rs.getString("major"));
				sInfo.setNetid(rs.getString("netid"));
				sInfo.setStudentName(rs.getString("s_name"));
				studentlist.add(sInfo);
			}
		}
		catch (Exception ex){
			System.out.println(ex);
		}

		return studentlist;
	}
}
