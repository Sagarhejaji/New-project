package com.emp.entities;

public class Attendance {

	private int attendId;
	private int empId;
	private String date;
	private String checkin;
	private String checkout;
	private String newcheckin;
	private String newcheckout;
	private String remarks;
	private int isButtonClicked;
	private String name;
	private String duration;
	private String AttendanceStatus;
	
	
	
	public String getAttendanceStatus() {
		return AttendanceStatus;
	}
	public void setAttendanceStatus(String attendanceStatus) {
		AttendanceStatus = attendanceStatus;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getNewcheckin() {
		return newcheckin;
	}
	public void setNewcheckin(String newcheckin) {
		this.newcheckin = newcheckin;
	}
	public String getNewcheckout() {
		return newcheckout;
	}
	public void setNewcheckout(String newcheckout) {
		this.newcheckout = newcheckout;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int isButtonClicked() {
		return isButtonClicked;
	}
	public void setButtonClicked(int isButtonClicked) {
		this.isButtonClicked = isButtonClicked;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getAttendId() {
		return attendId;
	}
	public void setAttendId(int attendId) {
		this.attendId = attendId;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	@Override
	public String toString() {
		return "duration="
				+ duration + "]";
	}
	
	
	
	
}
