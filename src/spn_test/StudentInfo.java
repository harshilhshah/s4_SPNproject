package spn_test;

public class StudentInfo {

	private String netid;
	private int credits = 0;
	private float gpa = 0;
	private String student_name = "";
	private String major = "";
	private String spn = "";

	public int getNetid(){
		return Integer.parseInt(netid);
	}

	public String getStringNetid(){
		return netid;
	}

	public int getCredits(){
		return credits;
	}

	public float getGpa(){
		return gpa;
	}

	public String getName(){
		return student_name;
	}

	public String getMajor(){
		return major;
	}
	public String getSPN(){
		return spn;
	}

	public void setNetid(String n){
		this.netid = n;
	}

	public void setStudentName(String s){
		this.student_name = s;
	}

	public void setCredits(int c){
		this.credits = c;
	}
	
	public void setGpa(float g){
		this.gpa = g;
	}
	
	public void setMajor(String m){
		this.major = m;
	}
	
	public void setSPN(String sp){
		this.spn = sp;
	}
}
