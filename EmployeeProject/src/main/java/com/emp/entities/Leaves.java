package com.emp.entities;


public class Leaves {

	    @Override
	public String toString() {
		return "Leaves [leaveId=" + leaveId + ", employeeID=" + employeeID + ", leaveType=" + leaveType + ", fromDate="
				+ fromDate + ", toDate=" + toDate + ", leaveStatus=" + leaveStatus + ", appliedDate=" + appliedDate
				+ ", approvedDate=" + approvedDate + ", approvedBy=" + approvedBy + ", appliedReason=" + appliedReason
				+ ", rejectReason=" + rejectReason + ", totalDays=" + totalDays + ", fname=" + fname + ", lname="
				+ lname + ", ApprovedByFname=" + ApprovedByFname + ", ApprovedByLname=" + ApprovedByLname + "]";
	}

		private int leaveId;
	    private int employeeID;
	    private String leaveType;
	    private String fromDate;
	    private String toDate;
	    private String leaveStatus;
	    private String appliedDate;
	    private String approvedDate;
	    private int approvedBy;
	    private String appliedReason;
	    private String rejectReason;
	    private int totalDays;
	    
	    private  String fname;
	    private String lname;
	    private String ApprovedByFname;
	    private String ApprovedByLname;
	    
	    

	    public String getApprovedByFname() {
			return ApprovedByFname;
		}

		public void setApprovedByFname(String approvedByFname) {
			ApprovedByFname = approvedByFname;
		}

		public String getApprovedByLname() {
			return ApprovedByLname;
		}

		public void setApprovedByLname(String approvedByLname) {
			ApprovedByLname = approvedByLname;
		}

		public String getFname() {
			return fname;
		}

		public void setFname(String fname) {
			this.fname = fname;
		}

		public String getLname() {
			return lname;
		}

		public void setLname(String lname) {
			this.lname = lname;
		}

		// Getters and Setters
	    public int getLeaveId() {
	        return leaveId;
	    }

	    public void setLeaveId(int leaveId) {
	        this.leaveId = leaveId;
	    }

	    public int getEmployeeID() {
	        return employeeID;
	    }

	    public void setEmployeeID(int employeeID) {
	        this.employeeID = employeeID;
	    }

	    public String getLeaveType() {
	        return leaveType;
	    }

	    public void setLeaveType(String leaveType) {
	        this.leaveType = leaveType;
	    }

	    public String getFromDate() {
	        return fromDate;
	    }

	    public void setFromDate(String fromDate) {
	        this.fromDate = fromDate;
	    }

	    public String getToDate() {
	        return toDate;
	    }

	    public void setToDate(String toDate) {
	        this.toDate = toDate;
	    }

	    public String getLeaveStatus() {
	        return leaveStatus;
	    }

	    public void setLeaveStatus(String leaveStatus) {
	        this.leaveStatus = leaveStatus;
	    }

	    public String getAppliedDate() {
	        return appliedDate;
	    }

	    public void setAppliedDate(String appliedDate) {
	        this.appliedDate = appliedDate;
	    }

	    public String getApprovedDate() {
	        return approvedDate;
	    }

	    public void setApprovedDate(String approvedDate) {
	        this.approvedDate = approvedDate;
	    }

	    public int getApprovedBy() {
	        return approvedBy;
	    }

	    public void setApprovedBy(int approvedBy) {
	        this.approvedBy = approvedBy;
	    }

	    public String getAppliedReason() {
	        return appliedReason;
	    }

	    public void setAppliedReason(String appliedReason) {
	        this.appliedReason = appliedReason;
	    }

	    public String getRejectReason() {
	        return rejectReason;
	    }

	    public void setRejectReason(String rejectReason) {
	        this.rejectReason = rejectReason;
	    }

		public int getTotalDays() {
			return totalDays;
		}

		public void setTotalDays(int totalDays) {
			this.totalDays = totalDays;
		}
	    
}

