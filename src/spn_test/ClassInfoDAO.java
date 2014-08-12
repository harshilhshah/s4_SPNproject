package spn_test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ClassInfoDAO {
	
	static Connection conn = null;
	static ResultSet rs = null;
	ArrayList<ClassInfo> classList;
	
	public ArrayList<ClassInfo> getClassesByProf(String pname){

		classList = new ArrayList<ClassInfo>();
		conn = ConnectionManager.getConnection();
		String newsql = "select * from class, course , professor, teaching "
					+ "where p_name = '" + pname + "' and class.c_id = course.c_id and teaching.p_id = professor.p_id "
					+ "and teaching.c_id = class.c_id;";
		String sql = "select * from class, course where course.c_id = class.c_id and exists "
				+ "(select c_id from professor, teaching where p_name = '" + pname + "')";
		
		try{
			PreparedStatement ps = conn.prepareStatement(newsql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				ClassInfo cInfo = new ClassInfo();
				cInfo.setCid(rs.getString("c_id"));
				cInfo.setBuilding(rs.getString("building"));
				cInfo.setCapacity(Integer.parseInt(rs.getString("capacity")));
				cInfo.setDeptid(rs.getString("dept_id"));
				cInfo.setEnd(rs.getString("end_time"));
				cInfo.setStart(rs.getString("start_time"));
				cInfo.setProfName(pname);
				cInfo.setSem(Long.parseLong(rs.getString("semester")));
				cInfo.setRoomNum(Integer.parseInt(rs.getString("room_num")));
				cInfo.setCourseName(rs.getString("c_name"));;
				classList.add(cInfo);
			}
		}
		catch (Exception ex){
			System.out.println(ex);
		}

		return classList;
	}
	
	public void findPrereqs(ClassInfo ci){
		conn = ConnectionManager.getConnection();
		String sql_prereq = "select * from prereq where c_id = " + ci.getCid();
		
		try{
			PreparedStatement ps2 = conn.prepareStatement(sql_prereq);
			ResultSet rs2 = ps2.executeQuery();
			while(rs2.next()){
				ci.addPrereq(rs2.getString("prereq_id"));
			}
		}catch (Exception ex){
			System.out.println(ex);
		}
	}
	
	public boolean createNewSPN(int howMany, ClassInfo info) throws SQLException{
		
		if(classList == null){
			return false;
		}
		conn = ConnectionManager.getConnection();
		String sql_prof = "";
		
		for(int h = 0; h < howMany; h++){
			
			sql_prof = "Select * from professor where p_name = \"" + info.getProfName() + "\"";
			PreparedStatement ps3 = conn.prepareStatement(sql_prof);
			ResultSet rs3 = ps3.executeQuery();
			String p_id = "";
			if(rs3.next()){ p_id = rs3.getString("p_id");}
			long num = info.generateSPN();
			while (!info.isNew(num)){
				num = info.generateSPN();
			}
			String sql_ins = "INSERT INTO `permission` "
					+ "(`c_id`, `dept_id`, `semester`, `p_id`, `spn`, `status`) "
					+ "VALUES ('" + info.getCid() +"', '" + info.getDeptid() + "', '" + info.getSem() 
					+ "', '" + p_id + "', '" + num + "', '0');";
			ps3 = conn.prepareStatement(sql_ins);
			int rs4 = ps3.executeUpdate();
			
		}
		return true;
	}
}
