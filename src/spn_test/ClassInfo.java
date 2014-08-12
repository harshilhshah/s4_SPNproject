package spn_test;

import java.util.ArrayList;
import java.util.Random;

public class ClassInfo {
	
	private int capacity;
	private int room_num = 0;
	private long semester = 0;
	private String start_time = "";
	private String end_time = "";
	private String profName = "";
	private String building = "";
	private String cid = "";
	private String did = "";
	private String courseName = "";
	private long[] spn;
	private int counter = 0;
	private ArrayList<Integer> prereqs = new ArrayList<Integer>();

	public int getCid(){
		return Integer.parseInt(this.cid);
	}
	
	public String getStringCid(){
		return this.cid;
	}
	
	public String getProfName(){
		return this.profName;
	}
	
	public int getDeptid(){
		return Integer.parseInt(this.did);
	}
	
	public String getStringDeptid(){
		return this.did;
	}
	
	public int getCapacity(){
		return this.capacity;
	}
	
	public int getRoomNum(){
		return this.room_num;
	}
	
	public long getSem(){
		return this.semester;
	}
	
	public String getBuilding(){
		return this.building;
	}
	
	public String getStart(){
		return this.start_time;
	}
	
	public String getEnd(){
		return this.end_time;
	}
	
	public String getCoursename(){
		return this.courseName;
	}
	
	public void setCid(String c){
		this.cid = c;
	}
	
	public void setDeptid(String d){
		this.did = d;
	}
	
	public void setCapacity(int cap){
		this.capacity = cap;
		this.spn = new long[this.capacity];
	}
	
	public void setRoomNum(int room){
		this.room_num = room;
	}
	
	public void setSem(long sem){
		this.semester = sem;
	}
	
	public void setBuilding(String build){
		this.building = build;
	}
	
	public void setStart(String strt){
		this.start_time = strt;
	}
	
	public void setEnd(String en){
		this.end_time = en;
	}
	
	public void setProfName(String name){
		this.profName = name;
	}
	
	public void setCourseName(String cname){
		this.courseName = cname;
	}
	
	public long generateSPN(){
		Random r = new Random();
		return 10000 + r.nextInt(80000);
	}
	
	public boolean isNew(long num){
		int len = this.spn.length;
		for(int x = 0; x < len; x++){
			if(this.spn[x] == num)
				return false;
		}
		this.spn[this.counter] = num;
		this.counter++;
		return true;
	}
	
	public int getCounter(){
		return this.counter;
	}
	
	public void addPrereq(String sr){
		this.prereqs.add(Integer.parseInt(sr));
	}
	
	public ArrayList<Integer> getPrereqs(){
		return this.prereqs;
	}
			
}
