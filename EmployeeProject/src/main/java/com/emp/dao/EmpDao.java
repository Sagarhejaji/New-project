package com.emp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import com.emp.entities.Address;
import com.emp.entities.Attendance;
import com.emp.entities.EmployeeFullDetails;
import com.emp.entities.Employees;
import com.emp.entities.Holidays;
import com.emp.entities.Leaves;
import com.emp.entities.Manager;
import com.emp.entities.Roles;
import com.emp.entities.UserCredentials;

public class EmpDao {

	private Connection con;

	public EmpDao(Connection con) {
		this.con = con;
	}


	// Checking username and password
	public boolean validateLogin(String uname,String pwd)throws SQLException
	{
		String query = "SELECT * FROM User_credentials WHERE binary username = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, uname);

		ResultSet rs = ps.executeQuery();
		rs.next();

		String pswd= rs.getString("password");

		if(BCrypt.checkpw(pwd, pswd)) {
			//			System.out.println("validateLogin returned true");
			return true;
		}
		//		System.out.println("validateLogin returned false");
		return  false;
	}



	/// Getting employee Details based on username
	public Employees getEmpData(String uname) throws SQLException
	{
		Employees e1=new Employees();
		String qry ="select * from Employees where EmployeeID = (select EmployeeID from User_credentials where username =?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, uname);
		try {
			ResultSet rs = ps.executeQuery();
			rs.next();
			e1.setEmpId(rs.getInt("EmployeeID"));
			e1.setFname(rs.getString("FirstName"));
			e1.setLname(rs.getString("LastName"));
			e1.setRoleId(rs.getInt("RoleID"));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return e1;
	}


	//Getting difference of check-in and check-out of weekly attendance based on employee id..
	public List<Attendance> getAttendanceForDashBoard(int empid) throws SQLException
	{
		List<Attendance> list = new ArrayList<>();
		String qry="WITH RECURSIVE date_series AS ("
				+ "SELECT DATE(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(CURDATE()) DAY)) AS date "
				+ "UNION ALL "
				+ "SELECT DATE_ADD(date, INTERVAL 1 DAY) "
				+ "FROM date_series "
				+ "WHERE date < DATE_ADD(DATE(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(CURDATE()) DAY)), INTERVAL 6 DAY) "
				+ ") "
				+ "SELECT "
				+ "COALESCE(IFNULL(TIME_TO_SEC(TIMEDIFF(a.CheckOutTime, a.CheckInTime)) / 3600.0, 0), 0) AS duration "
				+ "FROM "
				+ "date_series d "
				+ "LEFT JOIN "
				+ "attendance a ON d.date = a.Date AND a.employeeid = ? "
				+ "ORDER BY "
				+ "d.date";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, empid);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Attendance att = new Attendance();
			if(rs.getString("duration") == null) {
				att.setDuration("0.0");
			}else
			{
				att.setDuration(rs.getString("duration"));
			}

			list.add(att);
		}
		return list;
	}


	/// Getting current week's time logs..
	public Attendance getCheckInCheckOutTime(int empid) throws SQLException
	{
		Attendance att = new Attendance();
		String qry = "SELECT CheckInTime, CheckOutTime "
				+ "FROM Attendance "
				+ "WHERE EmployeeId = ? "
				+ "AND Date = CURDATE()";

		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, empid);
		ResultSet rs = ps.executeQuery();

		while(rs.next())
		{
			att.setCheckin(rs.getString("checkintime"));
			att.setCheckout(rs.getString("checkouttime"));
			return att;
		}

		return att;
	}


	///  validating user password
	public boolean validateUserPassword(String uname,String pwd)throws SQLException
	{
		String query = "SELECT Password FROM User_credentials where username = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, uname);

		try {
			ResultSet rs = ps.executeQuery();
			rs.next();

			String pswd= rs.getString("password"); 
			//	         int id = rs.getInt("EmployeeID");

			if(BCrypt.checkpw(pwd, pswd)) {
				return true;
			}


		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return  false;
	}



	/// updating user's password with session id
	public void updatePwd(int id,String pwd)
	{

		try {
			String qry="update user_credentials set password=? where employeeid =?";
			PreparedStatement ps=con.prepareStatement(qry);
			ps.setString(1,pwd);
			ps.setInt(2, id);

			int i=ps.executeUpdate();
			if(i>0)
			{
				System.out.println("password updated!!!");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}

	//Getting current month leaves based on employee id
	public List<Leaves> getCurrMonthLeaves(int empid) throws SQLException
	{
		List<Leaves> list = new ArrayList<>();
		String qry = "SELECT startdate,enddate,leavestatus "
				+ "FROM leaves "
				+ "WHERE MONTH(StartDate) = MONTH(CURRENT_DATE()) "
				+ "AND YEAR(StartDate) = YEAR(CURRENT_DATE()) "
				+ "AND EmployeeID = ? order by leaveid desc";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, empid);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Leaves leave = new Leaves();
			leave.setFromDate(rs.getString("startdate"));
			leave.setToDate(rs.getString("enddate"));
			leave.setLeaveStatus(rs.getString("leavestatus"));
			list.add(leave);
		}
//		System.out.println("current month leaves : "+list);
		return list;
	}

	//Storing all holidays into a list
	public List<Holidays> getHolidays() throws SQLException
	{
		List<Holidays> list = new ArrayList<>();
		String qry = "select holidaydate from holidays";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(qry);
		while(rs.next())
		{
			Holidays holi = new Holidays();
			holi.setDate(rs.getString("holidaydate"));
			list.add(holi);
		}
		return list;
	}

	//To get available leaves based employee id
	public int getAvailableLeaves(int eid) throws SQLException
	{
		String qry="select availableLeaves from LeavesStock where employeeid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			int n =rs.getInt("AvailableLeaves");
			return n;
		}
		return 0;
	}


	public int validateLeaves(String date,String date2) throws SQLException
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate fromdate = LocalDate.parse(date,formatter);
		LocalDate todate = LocalDate.parse(date2,formatter);
		int cnt =0;
		for(LocalDate d=fromdate;!d.isAfter(todate);d=d.plusDays(1))
		{
			DayOfWeek dw = d.getDayOfWeek();

			if(checkHoliday(d.format(formatter)))
			{
				if(dw != DayOfWeek.SATURDAY && dw != DayOfWeek.SUNDAY)
				{
					cnt++;	
				}
			}

		}
		return cnt;

	}



	public boolean checkHoliday(String date) throws SQLException
	{	
//		System.out.println("Checking Holiday");
		String qry="select holidayDate from holidays where holidayDate = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, date);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			return false;
		}

		return true;
	}


	// Method to insert leaves into table
	public int insertLeave(Leaves leave)
	{
		int leaveid =0;
		String query = "INSERT INTO Leaves (EmployeeID, LeaveType, StartDate, EndDate, LeaveStatus, reason,TotalDays,AppliedDate) VALUES (?, ?, ?, ?, ?, ?, ?,curdate())";
		String qry2="SELECT LeaveId FROM Leaves ORDER BY LeaveId DESC LIMIT 1";

		try (PreparedStatement pst = con.prepareStatement(query)) {
			pst.setInt(1, leave.getEmployeeID());
			pst.setString(2, leave.getLeaveType());
			pst.setString(3, leave.getFromDate());
			pst.setString(4, leave.getToDate());
			pst.setString(5, leave.getLeaveStatus());
			pst.setString(6, leave.getAppliedReason());
			pst.setInt(7, leave.getTotalDays());

			int rowCount = pst.executeUpdate();
			if (rowCount > 0) {
				ResultSet rs= con.prepareStatement(qry2).executeQuery();
				rs.next();
				leaveid=rs.getInt("LeaveId");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return leaveid;
	}

	public int applyLeaveFor(Leaves leave)
	{
		int leaveid =0;
		String query = "INSERT INTO Leaves (EmployeeID, LeaveType, StartDate, EndDate, LeaveStatus, reason,TotalDays,ApprovedBy,AppliedDate,ApprovedDate) VALUES (?, ?, ?, ?, ?, ?, ?,?,curdate(),curdate())";
		String qry2="SELECT LeaveId FROM Leaves ORDER BY LeaveId DESC LIMIT 1";

		try (PreparedStatement pst = con.prepareStatement(query)) {
			pst.setInt(1, leave.getEmployeeID());
			pst.setString(2, leave.getLeaveType());
			pst.setString(3, leave.getFromDate());
			pst.setString(4, leave.getToDate());
			pst.setString(5, leave.getLeaveStatus());
			pst.setString(6, leave.getAppliedReason());
			pst.setInt(7, leave.getTotalDays());
			pst.setInt(8, leave.getApprovedBy());

			int rowCount = pst.executeUpdate();
			if (rowCount > 0) {
				ResultSet rs= con.prepareStatement(qry2).executeQuery();
				rs.next();
				leaveid=rs.getInt("LeaveId");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return leaveid;
	}
	

	// after inserting leaves updating the available leaves
	public boolean updateLeavestock(int leaveid) throws SQLException
	{
		boolean flag=false;
		String qry="select employeeid,leavestatus,totaldays from leaves where leaveid=?";
		String qry1="update leavesStock set availableleaves = availableleaves - ?,consumedleaves = consumedleaves + ? where employeeid=?";
		String qry2="update leavesStock set availableleaves = availableleaves + ?,consumedleaves = consumedleaves - ? where employeeid=?";
		PreparedStatement ps=con.prepareStatement(qry);
		ps.setInt(1, leaveid);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int empid = rs.getInt("employeeid");
		String status = rs.getString("leavestatus");
		int totaldays = rs.getInt("totaldays");

		if(status.equals("Pending")||status.equals("Approved"))
		{
			PreparedStatement ps1=con.prepareStatement(qry1);
			ps1.setInt(1, totaldays);
			ps1.setInt(2, totaldays);
			ps1.setInt(3, empid);
			ps1.executeUpdate();
			flag = true;
		}
		else
		{
			PreparedStatement ps2=con.prepareStatement(qry2);
			ps2.setInt(1, totaldays);
			ps2.setInt(2, totaldays);
			ps2.setInt(3, empid);
			ps2.executeUpdate();
			flag = true;
		}


		return flag;
	}	
	
	public boolean updateLeavestock2(int leaveid, int levbal) throws SQLException
	{
		boolean flag=false;
		String qry="select employeeid,leavestatus,totaldays from leaves where leaveid=?";
		String qry1="update leavesStock set availableleaves = availableleaves - ?,consumedleaves = consumedleaves + ? where employeeid=?";

		PreparedStatement ps=con.prepareStatement(qry);
		ps.setInt(1, leaveid);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int empid = rs.getInt("employeeid");
		String status = rs.getString("leavestatus");
		int totaldays = rs.getInt("totaldays");

		if(status.equals("Pending")||status.equals("Approved"))
		{
			PreparedStatement ps1=con.prepareStatement(qry1);
			ps1.setInt(1, levbal);
			ps1.setInt(2, totaldays);
			ps1.setInt(3, empid);
			ps1.executeUpdate();
			flag = true;
		}


		return flag;
	}


	/// Getting all employees records 
	public List<Employees> getEmployees() throws Exception {
		List<Employees> list = new ArrayList<>();
		String qry = "SELECT EmployeeID, FirstName, LastName " +
				"FROM Employees";
		PreparedStatement ps = con.prepareStatement(qry);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Employees r = new Employees();
			r.setEmpId(rs.getInt("EmployeeId"));
			r.setFname(rs.getString("FirstName"));
			r.setLname(rs.getString("LastName"));
			list.add(r);
		}
		return list;
	}


	public List<Leaves> getEmployeeLeaves(int empid) throws SQLException
	{
		List<Leaves> list = new ArrayList<>();

		String qry="Select l.*,e.firstname,e.lastname from leaves l left join employees e on l.approvedby=e.employeeid where l.employeeid=? order by leaveid desc";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, empid);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Leaves lev = new Leaves();
			lev.setLeaveId(rs.getInt("leaveid"));
			lev.setEmployeeID(rs.getInt("employeeid"));
			lev.setAppliedDate(rs.getString("AppliedDate"));
			lev.setFromDate(rs.getString("startdate"));
			lev.setToDate(rs.getString("enddate"));
			lev.setTotalDays(rs.getInt("totaldays"));
			lev.setLeaveType(rs.getString("leavetype"));
			lev.setAppliedReason(rs.getString("Reason"));
			lev.setLeaveStatus(rs.getString("leavestatus"));
			lev.setApprovedByFname(rs.getString("firstname"));
			lev.setApprovedByLname(rs.getString("lastname"));
			lev.setApprovedDate(rs.getString("ApprovedDate"));
			lev.setRejectReason(rs.getString("RejectReason"));
			
			list.add(lev);
		}
		return list;

	}


	//Method to get holiday records
	public List<Holidays> getAllHolidays () throws SQLException
	{
		List<Holidays> list = new ArrayList<>();
		String query = "SELECT * FROM holidays WHERE Year(holidayDate) = Year(CURRENT_DATE()) order by HolidayDate";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {

			Holidays ad = new Holidays();

			ad.setId(rs.getInt("holidayid"));
			ad.setDate(rs.getString("holidayDate"));
			ad.setName(rs.getString("holidayName"));

			list.add(ad);

		}
		return list;
	}

	//Method to insert Holidays
	public boolean insertHoliday(String date,String name) throws SQLException
	{
		String qry = "insert into holidays(holidaydate,holidayname) values (?,?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, date);
		ps.setString(2, name);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}else
		{
			return false;
		}

	}

	//Method to delete holiday
	public boolean deleteHolidayRecord(int lid) throws SQLException
	{
		String qry="delete from holidays where holidayid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, lid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}else
		{
			return false;
		}
	}


	//Method to add leaves to employees
	public boolean addLeavesStock(int n) throws SQLException
	{
		String qry="update leavesStock set availableLeaves = availableLeaves+? ";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1,n);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}else
		{
			return false;
		}
	}

	//Method to delete leave record (Cancel Leave)
	public boolean deleteLeaveRecord(int lid) throws SQLException
	{

		String qry="UPDATE leavesStock ls "
				+ "JOIN Leaves l ON ls.employeeid = l.employeeid "
				+ "SET ls.availableleaves = ls.availableleaves + l.TotalDays, "
				+ "ls.consumedleaves = ls.consumedleaves - l.TotalDays "
				+ "WHERE l.leaveid = ?;";

		String qry2="delete from leaves where leaveid=?";

		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, lid);
		ps.executeUpdate();

		PreparedStatement ps2=con.prepareStatement(qry2);
		ps2.setInt(1, lid);

		int i =ps2.executeUpdate();
		if(i>0)
		{
			return true;
		}else
		{
			return false;
		}
	}

	//Method to get the current user's role
	public String getRoleByLogin(String uname,String pwd)throws SQLException
	{
		String query = "SELECT u.EmployeeID, u.Password, e.RoleID, r.RoleName FROM User_credentials u JOIN Employees e ON u.EmployeeID = e.EmployeeID JOIN Roles r ON e.RoleID = r.RoleID WHERE binary u.Username = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, uname);

		try {
			ResultSet rs = ps.executeQuery();
			rs.next();

			String pswd= rs.getString("password");
			String role = rs.getString("RoleName"); 
			//	         int id = rs.getInt("EmployeeID");

			if(BCrypt.checkpw(pwd, pswd)) {
				return role;
			}


		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return  "error";
	}

	//Method to get the reportees of a manager
	public List<Employees> getReportees(int mId) throws SQLException
	{
		List<Employees> l1 = new ArrayList<>();

		String qry=" SELECT e.EmployeeId, e.FirstName,e.LastName FROM Employees e JOIN Manager m ON e.EmployeeId = m.employee WHERE m.Manager = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, mId);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Employees e1  = new Employees();
			e1.setEmpId(rs.getInt("EmployeeID"));
			e1.setFname(rs.getString("FirstName"));
			e1.setLname(rs.getString("LastName"));

			l1.add(e1);
		}
		return l1;
	}


	//Method to filter leaves based on year and month
	public List<Leaves> getLeaveByYearMonth(int eid, String year, String month) {
		List<Leaves> list = new ArrayList<>();
		try {
			String query = "Select l.*,e.firstname,e.lastname from leaves l left join employees e on l.approvedby=e.employeeid where l.employeeid=? AND YEAR(l.StartDate) = ? AND MONTH(l.StartDate) = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ps.setString(3, month);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leaves lev = new Leaves();
				lev.setLeaveId(rs.getInt("leaveid"));
				lev.setEmployeeID(rs.getInt("employeeid"));
				lev.setAppliedDate(rs.getString("AppliedDate"));
				lev.setFromDate(rs.getString("startdate"));
				lev.setToDate(rs.getString("enddate"));
				lev.setTotalDays(rs.getInt("totaldays"));
				lev.setLeaveType(rs.getString("leavetype"));
				lev.setAppliedReason(rs.getString("Reason"));
				lev.setLeaveStatus(rs.getString("leavestatus"));
				lev.setApprovedByFname(rs.getString("firstname"));
				lev.setApprovedByLname(rs.getString("lastname"));
				lev.setApprovedDate(rs.getString("ApprovedDate"));
				lev.setRejectReason(rs.getString("RejectReason"));
			
			list.add(lev);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//Method to filter leaves based on month
	public List<Leaves> getLeaveByYear(int eid, String year) {
		List<Leaves> list = new ArrayList<>();
		try {
			String query = "SELECT l.*,e.firstname,e.lastname FROM leaves l left join employees e on l.approvedby=e.employeeid WHERE l.EmployeeID = ? AND YEAR(l.StartDate) = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leaves lev = new Leaves();
				lev.setLeaveId(rs.getInt("leaveid"));
				lev.setEmployeeID(rs.getInt("employeeid"));
				lev.setAppliedDate(rs.getString("AppliedDate"));
				lev.setFromDate(rs.getString("startdate"));
				lev.setToDate(rs.getString("enddate"));
				lev.setTotalDays(rs.getInt("totaldays"));
				lev.setLeaveType(rs.getString("leavetype"));
				lev.setAppliedReason(rs.getString("Reason"));
				lev.setLeaveStatus(rs.getString("leavestatus"));
				lev.setApprovedByFname(rs.getString("firstname"));
				lev.setApprovedByLname(rs.getString("lastname"));
				lev.setApprovedDate(rs.getString("ApprovedDate"));
				lev.setRejectReason(rs.getString("RejectReason"));
				list.add(lev);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	//Method to check user name 
	public boolean validateEmail(String uname,String email) throws SQLException
	{
		String qry="select PersonalEmail from employees where employeeid =(select employeeid from user_credentials where username=?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, uname);
		ResultSet rs = ps.executeQuery();
		rs.next();
		if(email.equals(rs.getString("PersonalEmail")))
		{
			return true;

		}
		return false;
	}


	//Method to reset password through login page
	public boolean changePassword(String pwd, String uname) throws SQLException {
		String qry = "update user_credentials set password=? where username=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, pwd);
		ps.setString(2, uname);
		int i = ps.executeUpdate();
		if (i > 0) {
			return true;
		}
		return false;
	}


	// Method to get all employees pending leaves
	public List<Leaves> getPendingLeaves() throws SQLException
	{
		List<Leaves> list = new ArrayList<>();
		String qry="SELECT l.leaveid,l.startdate, l.enddate, l.totaldays, l.leavetype, l.reason,l.leavestatus, e.firstname, e.lastname FROM leaves l JOIN employees e ON l.employeeid = e.EmployeeID WHERE l.leaveStatus = 'pending'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(qry);
		while(rs.next())
		{
			Leaves l = new Leaves();
			l.setLeaveId(rs.getInt("leaveid"));
			l.setFromDate(rs.getString("startdate"));
			l.setToDate(rs.getString("enddate"));
			l.setTotalDays(rs.getInt("totaldays"));
			l.setLeaveType(rs.getString("leavetype"));
			l.setLeaveStatus(rs.getString("leavestatus"));
			l.setAppliedReason(rs.getString("reason"));
			l.setFname(rs.getString("firstname"));
			l.setLname(rs.getString("lastname"));
			list.add(l);
		}
		return list;
	}


	// Method to get all employee leaves reporting to their manager
	public List<Leaves> getMgrPendingLeaves(int mid) throws SQLException
	{
		List<Leaves> list = new ArrayList<>();
		String qry="SELECT l.leaveid,l.startdate,l.enddate,l.totaldays,l.leavetype,l.reason,l.leavestatus, e.firstname, e.lastname FROM Leaves l JOIN Manager m ON l.employeeid = m.employee JOIN Employees e ON l.employeeid = e.employeeid WHERE m.manager = ? AND l.leaveStatus = 'pending'";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, mid);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Leaves l = new Leaves();
			l.setLeaveId(rs.getInt("leaveid"));
			l.setFromDate(rs.getString("startdate"));
			l.setToDate(rs.getString("enddate"));
			l.setTotalDays(rs.getInt("totaldays"));
			l.setLeaveType(rs.getString("leavetype"));
			l.setLeaveStatus(rs.getString("leavestatus"));
			l.setAppliedReason(rs.getString("reason"));
			l.setFname(rs.getString("firstname"));
			l.setLname(rs.getString("lastname"));
			list.add(l);
		}
		return list;
	}


	// Method to get current date and time
	public String getCurrDateTime() {
		// Get current date and time in IST
		ZoneId istZone = ZoneId.of("Asia/Kolkata"); // Replace with "Asia/Calcutta" if needed
		ZonedDateTime nowIST = ZonedDateTime.now(istZone);

		// Format date and time with desired pattern
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss") ;


		String dateTime = nowIST.format(formatter);

		//		System.out.println("Current date" + dateTime);
		return dateTime;
	}


	// Method to update reject reason
	public boolean updaterejectreason(String rs,int eid,int leaveid,String status) throws SQLException
	{
		String[] str = getCurrDateTime().split(" ");
		String qry="update leaves set rejectreason =?,leavestatus=?,approveddate=?,approvedby=? where leaveid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1,rs);
		ps.setString(2, status);
		ps.setString(3, str[0]);
		ps.setInt(4, eid);
		ps.setInt(5, leaveid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}else
		{
			return false;
		}
	}

	//Method to get list of attendance records based on session id
	public List<Attendance> getAttRecordById(int eid) throws SQLException {
		List<Attendance> list = new ArrayList<>();
		String qry = "SELECT AttendanceId, Date, CheckInTime, CheckOutTime, Remarks, IsButtonClicked FROM attendance "
				+"WHERE employeeID = ? " 
				+"AND MONTH(Date) = MONTH(CURRENT_DATE()) "
				+"AND YEAR(Date) = YEAR(CURRENT_DATE()) "
				+"ORDER by date";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Attendance a = new Attendance();
			a.setAttendId(rs.getInt("AttendanceId"));
			a.setDate(rs.getString("Date"));
			a.setCheckin(rs.getString("CheckInTime"));
			a.setCheckout(rs.getString("CheckOutTime"));
			a.setRemarks(rs.getString("Remarks"));
			a.setButtonClicked(rs.getInt("IsButtonClicked"));
			list.add(a);
		}
		return list;
	}


	// Method to get attendance records list based on from and to date
	public List<Attendance> getAttendanceByDateRange(int eid, String fromDate, String toDate) {
		List<Attendance> list = new ArrayList<>();
		try {
			String query = "SELECT a.AttendanceId, a.Date, a.CheckInTime, a.CheckOutTime, a.Remarks, a.IsButtonClicked, "
					+ "CASE WHEN au.AttendanceId IS NULL THEN 0 ELSE 1 END AS UpdateRequested "
					+ "FROM attendance a "
					+ "LEFT JOIN AttendanceUpdate au ON a.AttendanceId = au.AttendanceId "
					+ "WHERE a.employeeid = ? AND a.date BETWEEN ? AND ? "
					+ "ORDER BY a.date";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, fromDate);
			ps.setString(3, toDate);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Attendance att = new Attendance();
				att.setAttendId(rs.getInt("AttendanceId"));
				att.setDate(rs.getString("date"));
				att.setCheckin(rs.getString("checkintime"));
				att.setCheckout(rs.getString("checkouttime"));
				att.setRemarks(rs.getString("Remarks"));
				att.setButtonClicked(rs.getInt("IsButtonClicked"));
				list.add(att);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	// Method to get attendance records list based on year and month
	public List<Attendance> getAttendanceByYearMonth(int eid, String year, String month) {
		List<Attendance> list = new ArrayList<>();
		try {
			String query = "SELECT a.AttendanceId, a.Date, a.CheckInTime, a.CheckOutTime, a.Remarks, a.IsButtonClicked, "
					+ "CASE WHEN au.AttendanceId IS NULL THEN 0 ELSE 1 END AS UpdateRequested "
					+ "FROM attendance a "
					+ "LEFT JOIN AttendanceUpdate au ON a.AttendanceId = au.AttendanceId "
					+ "WHERE a.employeeid = ? AND YEAR(a.date) = ? AND MONTH(a.date) = ? "
					+ "ORDER BY a.date";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ps.setString(3, month);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Attendance att = new Attendance();
				att.setAttendId(rs.getInt("AttendanceID"));
				att.setDate(rs.getString("date"));
				att.setCheckin(rs.getString("checkintime"));
				att.setCheckout(rs.getString("checkouttime"));
				att.setRemarks(rs.getString("Remarks"));
				att.setButtonClicked(rs.getInt("IsButtonClicked"));
				list.add(att);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	// Method to get attendance records list based on year
	public List<Attendance> getAttendanceByYear(int eid, String year) {
		List<Attendance> list = new ArrayList<>();
		try {
			String query = "SELECT a.AttendanceId, a.Date, a.CheckInTime, a.CheckOutTime, a.Remarks, a.IsButtonClicked, "
					+ "CASE WHEN au.AttendanceId IS NULL THEN 0 ELSE 1 END AS UpdateRequested "
					+ "FROM attendance a "
					+ "LEFT JOIN AttendanceUpdate au ON a.AttendanceId = au.AttendanceId "
					+ "WHERE a.employeeid = ? AND YEAR(a.date) = ? "
					+ "ORDER BY a.date";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Attendance att = new Attendance();
				att.setAttendId(rs.getInt("AttendanceId"));
				att.setDate(rs.getString("date"));
				att.setCheckin(rs.getString("checkintime"));
				att.setCheckout(rs.getString("checkouttime"));
				att.setRemarks(rs.getString("Remarks"));
				att.setButtonClicked(rs.getInt("IsButtonClicked"));
				list.add(att);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	// Method to update new check-in and check-out time
	public boolean UpdateAttendanceTable(int AID,String name,String Date, String CITime, String COTime, int eid) throws SQLException
	{
		String qry="Insert into AttendanceUpdate (AttendanceId,Name,Date, CheckInTime, CheckOutTime, EmployeeId) values (?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1,AID);
		ps.setString(2,name);
		ps.setString(3,Date);
		ps.setString(4,CITime);
		ps.setString(5,COTime);
		ps.setInt(6,eid);
		int i=ps.executeUpdate();

		String qry2="Update Attendance set IsButtonClicked=1 where AttendanceId=?";
		PreparedStatement ps2 = con.prepareStatement(qry2);
		ps2.setInt(1, AID);
		ps2.executeUpdate();

		if(i>0) return true;
		return false;
	}


	// Method to get attendanceRequest from reportees to there manager
	public List<Attendance> ManagerAttendance(int mid) throws SQLException
	{
		List<Attendance> list = new ArrayList<>();
		String qry="SELECT au.AttendanceId, au.Name, au.Date, au.CheckInTime as NewCheckInTime, au.CheckOutTime as NewCheckOutTime, att.CheckInTime as OldCheckInTime, att.CheckOutTime as OldCheckOutTime FROM AttendanceUpdate au JOIN Attendance att ON att.AttendanceId = au.AttendanceId WHERE au.EmployeeId IN (SELECT employee FROM Manager WHERE manager = ?)";

		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, mid);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Attendance a = new Attendance();
			a.setAttendId(rs.getInt("AttendanceId"));
			a.setName(rs.getString("Name"));
			a.setDate(rs.getString("Date"));
			a.setNewcheckin(rs.getString("NewCheckInTime"));
			a.setNewcheckout(rs.getString("NewCheckOutTime"));
			a.setCheckin(rs.getString("OldCheckInTime"));
			a.setCheckout(rs.getString("OldCheckOutTime"));
			list.add(a);
		}

		return list;
	}


	// Method to display all attendanceRequests to HR
	public List<Attendance> HRAttendance() throws SQLException
	{
		List<Attendance> list = new ArrayList<>();
		String qry="SELECT au.AttendanceId, au.Name, au.Date, au.CheckInTime as NewCheckInTime, au.CheckOutTime as NewCheckOutTime, att.CheckInTime as OldCheckInTime, att.CheckOutTime as OldCheckOutTime FROM AttendanceUpdate au JOIN Attendance att ON att.AttendanceId = au.AttendanceId";

		PreparedStatement ps = con.prepareStatement(qry);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Attendance a = new Attendance();
			a.setAttendId(rs.getInt("AttendanceId"));
			a.setName(rs.getString("Name"));
			a.setDate(rs.getString("Date"));
			a.setNewcheckin(rs.getString("NewCheckInTime"));
			a.setNewcheckout(rs.getString("NewCheckOutTime"));
			a.setCheckin(rs.getString("OldCheckInTime"));
			a.setCheckout(rs.getString("OldCheckOutTime"));
			list.add(a);
		}

		return list;
	}


	// Method to update attendanceRequest
	public boolean UpdateAttendance(int AID,String Date, String CITime, String COTime) throws SQLException
	{
		String qry="Update Attendance SET Date=?,CheckInTime=?, CheckOutTime=?, Remarks='-' where AttendanceId=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1,Date);
		ps.setString(2,CITime);
		ps.setString(3,COTime);
		ps.setInt(4,AID);
		int i=ps.executeUpdate();

		String qry2="Delete from AttendanceUpdate where AttendanceId=?";
		PreparedStatement ps2 = con.prepareStatement(qry2);
		ps2.setInt(1,AID);
		ps2.executeUpdate();

		if(i>0) return true;
		return false;
	}

	// Method to get all employees
	public List<Employees> getAllEmployees() throws SQLException
	{
		List<Employees> list = new ArrayList<>();

		String qry = "select * from employees";
		PreparedStatement ps = con.prepareStatement(qry);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Employees emp = new Employees();
			emp.setEmpId(rs.getInt("employeeid"));
			emp.setFname(rs.getString("firstname"));
			emp.setLname(rs.getString("lastname"));
			emp.setPersonalMobile(rs.getString("personalmobile"));
			emp.setWorkEmail(rs.getString("workemail"));
			emp.setEmpNo(rs.getString("empno"));

			list.add(emp);
		}
		return list;
	}


	// Method to validate current date
	public boolean getLogin(int id) throws SQLException {
		String str[] = getCurrDateTime().split(" ");
		String qry = "select * from attendance where date = ? and employeeid = ?";
		boolean f=false;

		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, str[0]);
		ps.setInt(2, id);

		try (ResultSet rs = ps.executeQuery()) {
			if (!rs.next()) {
				f= true;
			}
		}
		if(f)
		{
			return true;
		}
		return false;
	}
	
	
	// Method to check whether the check-in date is on leave or not.
	public boolean validateAttendance(int eid) throws SQLException
	{
		System.out.println("Checking Leave");
		String[] str = getCurrDateTime().split(" ");
		String qry="select * from leaves where employeeid=? and leavestatus='approved' and ? between startdate and enddate";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ps.setString(2, str[0]);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			System.out.println("On Leave");
			return true;
		}
		return false;	
	}
	
	
	// Method to check whether the date is holiday
	public boolean validateAttendanceHoliday() throws SQLException
	{
		
		String[] str = getCurrDateTime().split(" ");
		if(checkHoliday(str[0]))
		{
		// Method to check whether the date is weekend
			return checkWeekend(str[0]);
		}
		return false;
	}
	
	
	public boolean checkWeekend(String date)
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate date1 = LocalDate.parse(date,formatter);
		if(date1.getDayOfWeek() != DayOfWeek.SATURDAY && date1.getDayOfWeek() != DayOfWeek.SUNDAY) {
			System.out.println("Not weekend");
			return true;
		}
		return false;
	}
	
	
	// Method to insert login details
	public void insertLogin(int eid) throws SQLException
	{
		String str[] = getCurrDateTime().split(" ");
		String qry="insert into Attendance(EmployeeID,Date,CheckInTime)values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1,eid);
		ps.setString(2, str[0]);
		ps.setString(3, str[1]);


		int i = ps.executeUpdate();
	}
	
	
	// validating login time and then updating logout time
	public String getLogout(int id) throws SQLException {
		String str[] = getCurrDateTime().split(" ");
		String qry = "select * from attendance where date = ? and employeeid = ?";

		try (PreparedStatement ps = con.prepareStatement(qry)) {
			ps.setString(1, str[0]);
			ps.setInt(2, id);

			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
				String time = rs.getString("checkouttime");
				if (time == null) {
					updateLogout(id);
					return "LoggedOut";
				}
				}
				else return "NotLoggedIn";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e; // or handle it as per your application needs
		}

		return "AlreadyLoggedOut";
	}
	
	
	public void updateLogout(int eid) throws SQLException
	{
		String str[] = getCurrDateTime().split(" ");
		String qry="update attendance set checkouttime=? where employeeid =? and date = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1,str[1]);
		ps.setInt(2, eid);
		ps.setString(3, str[0]);

		int i = ps.executeUpdate();
	}

	
	
	public boolean CancelLeave(int leaveid,String status) throws SQLException
	{
		
		String qry="update leaves set leavestatus=? where leaveid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, status);
		ps.setInt(2, leaveid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}else
		{
			return false;
		}
	}
	
	public List<Roles> getRoles() throws SQLException
	{
		List<Roles> list = new ArrayList<>();
		
		String qry="Select * from Roles";
		PreparedStatement ps = con.prepareStatement(qry);
		ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			Roles r = new Roles();
			r.setRoleId(rs.getInt("RoleId"));
			r.setRoleName(rs.getString("RoleName"));
			
			list.add(r);
		}
		return list;
	}
	
	public List<Employees> getEmployeesByRole(int roleId) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM employees WHERE roleid=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, roleId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				emp.setRoleId(rs.getInt("roleId"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Employees> getReporteesByRole(int roleId,int mid) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT e.* FROM employees e JOIN Manager m on e.EmployeeId=m.employee WHERE e.roleid=? and m.Manager=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, roleId);
			pstmt.setInt(2, mid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				emp.setRoleId(rs.getInt("roleId"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Employees> getEmployeesByRoleAndName(int roleId, String name) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM employees WHERE roleid=? AND concat(firstName, ' ',lastName) LIKE ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, roleId);
			pstmt.setString(2,"%" +name+ "%");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Employees> getReporteesByRoleAndName(int roleId, String name,int mid) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT e.* FROM employees e JOIN Manager m on e.EmployeeId=m.employee WHERE e.roleid=? AND concat(e.firstName, ' ',e.lastName) LIKE ? and m.Manager=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, roleId);
			pstmt.setString(2,"%" +name+ "%");
			pstmt.setInt(3, mid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Employees> getEmployeesByName(String name) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM employees WHERE firstName LIKE ? OR lastName LIKE ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, "%" + name + "%");
			pstmt.setString(2, "%" + name + "%");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Employees> getReporteesByName(String name,int mid) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT e.* FROM employees e JOIN Manager m on e.EmployeeId=m.employee WHERE (firstName LIKE ? OR lastName LIKE ?) and m.Manager=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, "%" + name + "%");
			pstmt.setString(2, "%" + name + "%");
			pstmt.setInt(3, mid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean addEmployees(Employees e, UserCredentials uc, Address a) throws SQLException
	{
		boolean b=false;
		
		String qry="Insert into employees (FirstName,LastName,DateOfBirth,PersonalEmail,PersonalMobile,HireDate,RoleId,MaritalStatus,Gender,EmergencyMobile,EmergencyName,BloodGroup,Nationality,PersonalHome,EmergencyRelation,WorkEmail,JobLocation,empno) "
				+"values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		String qry2="SELECT employeeID FROM employees ORDER BY employeeID DESC LIMIT 1";
		
		try (PreparedStatement ps = con.prepareStatement(qry)) {
	        ps.setString(1, e.getFname());
	        ps.setString(2, e.getLname());
	        ps.setString(3, e.getDateofBirth());
	        ps.setString(4, e.getPersonalEmail());
	        ps.setString(5, e.getPersonalMobile());
	        ps.setString(6, e.getHireDate());
	        ps.setInt(7, e.getRoleId());
	        ps.setString(8, e.getMaritalStatus());
	        ps.setString(9, e.getGender());
	        ps.setString(10, e.getEmergencyMobile());
	        ps.setString(11, e.getEmergencyName());
	        ps.setString(12, e.getBloodGroup());
	        ps.setString(13, e.getNationality());
	        ps.setString(14, e.getPersonalHome());
	        ps.setString(15, e.getEmergencyRelatoin());
	        ps.setString(16, e.getWorkEmail());
	        ps.setString(17, e.getJobLocation());
	        ps.setString(18, e.getEmpNo());
	        
	        int i = ps.executeUpdate();
	        if (i > 0) {
	            try (ResultSet rs = con.prepareStatement(qry2).executeQuery()) {
	                if (rs.next()) {
	                    int id = rs.getInt("employeeID");
	                    b = addAddress(id, uc, a);
	                }
	            }
	        }
	    } catch (SQLIntegrityConstraintViolationException err) {
	        // Handle duplicate empno case
	        System.err.println("Error: Duplicate empno value. " + err.getMessage());
	    }
//	    System.out.println("flag : "+b);
	    return b;	
	}
	public boolean addAddress(int id,UserCredentials uc, Address a) throws SQLException
	{
		boolean b=false;
		String qry="insert into Address (EmployeeId,Line1,Line2,City,State,PostalCode,Country,TLine1,TLine2,TCity,TState,TPostalCode,TCountry) "
				+"values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement ps= con.prepareStatement(qry);
		ps.setInt(1, id);
		ps.setString(2, a.getLine1());
		ps.setString(3, a.getLine2());
		ps.setString(4, a.getCity());
		ps.setString(5, a.getState());
		ps.setString(6, a.getPostalCode());
		ps.setString(7, a.getCountry());
		ps.setString(8, a.getTempLine1());
		ps.setString(9, a.getTempLine2());
		ps.setString(10, a.getTempCity());
		ps.setString(11, a.getTempState());
		ps.setString(12, a.getTempPostalCode());
		ps.setString(13, a.getTempCountry());
		
		int i=ps.executeUpdate();
		if(i>0) {

			b=addUserCredentials(id,uc);
			
		}
				
		return b;
	}
	
	public boolean addUserCredentials(int id,UserCredentials uc) throws SQLException
	{

			String qry="insert into user_credentials values (?,?,?)";
			String qry1="insert into leavesStock(employeeid) values (?)";
			PreparedStatement ps=con.prepareStatement(qry);
			ps.setInt(1, id);
			ps.setString(2,uc.getUsername());
			ps.setString(3, uc.getPassword());

			ps.executeUpdate();
			
			
			
			PreparedStatement ps1=con.prepareStatement(qry1);
			ps1.setInt(1, id);
			
			int i=ps1.executeUpdate();
			if(i>0) {
				return true;
			}

		return false;

	}
	
	
	
	// method to get full details of a employee
	public EmployeeFullDetails getEmpFullDetails(int empid) throws SQLException
	{
		EmployeeFullDetails e1 = new EmployeeFullDetails();
		
		Employees emp = new Employees();
		Address adr = new Address();
		String qry = "SELECT e.*, a.* "
				+ "FROM employees e "
				+ "LEFT JOIN address a ON e.employeeid = a.employeeid "
				+ "WHERE e.employeeid = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, empid);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			emp.setEmpId(rs.getInt("employeeid"));
			emp.setFname(rs.getString("firstname"));
			emp.setLname(rs.getString("lastname"));
			emp.setDateofBirth(rs.getString("dateofbirth"));
			emp.setPersonalEmail(rs.getString("personalemail"));
			emp.setPersonalMobile(rs.getString("personalmobile"));
			emp.setHireDate(rs.getString("hiredate"));
			emp.setRoleId(rs.getInt("roleid"));
			emp.setMaritalStatus(rs.getString("maritalstatus"));
			emp.setGender(rs.getString("gender"));
			emp.setEmergencyMobile(rs.getString("emergencymobile"));
			emp.setEmergencyName(rs.getString("emergencyname"));
			emp.setBloodGroup(rs.getString("bloodgroup"));
			emp.setNationality(rs.getString("nationality"));
			emp.setPersonalHome(rs.getString("personalhome"));
			emp.setEmergencyRelatoin(rs.getString("emergencyrelation"));
			emp.setWorkEmail(rs.getString("workemail"));
			emp.setJobLocation(rs.getString("joblocation"));
			emp.setEmpNo(rs.getString("empno"));
			
			adr.setLine1(rs.getString("line1"));
			adr.setLine2(rs.getString("line2"));
			adr.setCity(rs.getString("city"));
			adr.setState(rs.getString("state"));
			adr.setPostalCode(rs.getString("postalcode"));
			adr.setCountry(rs.getString("country"));
			adr.setTempLine1(rs.getString("tline1"));
			adr.setTempLine2(rs.getString("tline2"));
			adr.setTempCity(rs.getString("tcity"));
			adr.setTempState(rs.getString("tstate"));
			adr.setTempPostalCode(rs.getString("tpostalcode"));
			adr.setTempCountry(rs.getString("tcountry"));
			e1 = new EmployeeFullDetails(emp,adr);
			
		}
		return e1;
	}
	
	
	
	// Method to update employee details
	public boolean updateEmployeeAndAddress(Employees emp, Address adr,int empid) throws SQLException {
        String updateEmployeeQuery = "UPDATE employees SET firstname = ?, lastname = ?, dateofbirth = ?, personalemail = ?, " +
                "personalmobile = ?, hiredate = ?, roleid = ?, maritalstatus = ?, gender = ?, emergencymobile = ?, " +
                "emergencyname = ?, bloodgroup = ?, nationality = ?, personalhome = ?, emergencyrelation = ?, " +
                "workemail = ?, joblocation = ? WHERE employeeid = ?";

        String updateAddressQuery = "UPDATE address SET line1 = ?, line2 = ?, city = ?, state = ?, postalcode = ?, " +
                "country = ?, tline1 = ?, tline2 = ?, tcity = ?, tstate = ?, tpostalcode = ?, tcountry = ? " +
                "WHERE employeeid = ?";

        try {
            con.setAutoCommit(false);

            try (PreparedStatement psEmp = con.prepareStatement(updateEmployeeQuery);
                 PreparedStatement psAdr = con.prepareStatement(updateAddressQuery)) {

                // Set parameters for employee update
                psEmp.setString(1, emp.getFname());
                psEmp.setString(2, emp.getLname());
                psEmp.setString(3, emp.getDateofBirth());
                psEmp.setString(4, emp.getPersonalEmail());
                psEmp.setString(5, emp.getPersonalMobile());
                psEmp.setString(6, emp.getHireDate());
                psEmp.setInt(7, emp.getRoleId());
                psEmp.setString(8, emp.getMaritalStatus());
                psEmp.setString(9, emp.getGender());
                psEmp.setString(10, emp.getEmergencyMobile());
                psEmp.setString(11, emp.getEmergencyName());
                psEmp.setString(12, emp.getBloodGroup());
                psEmp.setString(13, emp.getNationality());
                psEmp.setString(14, emp.getPersonalHome());
                psEmp.setString(15, emp.getEmergencyRelatoin());
                psEmp.setString(16, emp.getWorkEmail());
                psEmp.setString(17, emp.getJobLocation());
                psEmp.setInt(18, empid);

                // Execute employee update
                psEmp.executeUpdate();

                // Set parameters for address update
                psAdr.setString(1, adr.getLine1());
                psAdr.setString(2, adr.getLine2());
                psAdr.setString(3, adr.getCity());
                psAdr.setString(4, adr.getState());
                psAdr.setString(5, adr.getPostalCode());
                psAdr.setString(6, adr.getCountry());
                psAdr.setString(7, adr.getTempLine1());
                psAdr.setString(8, adr.getTempLine2());
                psAdr.setString(9, adr.getTempCity());
                psAdr.setString(10, adr.getTempState());
                psAdr.setString(11, adr.getTempPostalCode());
                psAdr.setString(12, adr.getTempCountry());
                psAdr.setInt(13, empid);

                // Execute address update
                psAdr.executeUpdate();

                // Commit transaction
                con.commit();
                return true;
            } catch (SQLException e) {
                con.rollback();
                throw e;
            }
        } finally {
            con.setAutoCommit(true);
        }
    }
	
	
	// Method to delete employee record
	public boolean deleteEmployee(int eid) throws SQLException
	{
		String qry="delete from employees where employeeid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}
		return false;
	}
	
	
	// Method to get all managers
	public List<Employees> getAllManagers() throws SQLException
	{
		String qry="select employeeid,firstname,lastname from employees where roleid=3;";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(qry);
		
		List<Employees> list = new ArrayList<>();
		while(rs.next())
		{
			Employees emp = new Employees();
			emp.setEmpId(rs.getInt("employeeid"));
			emp.setFname(rs.getString("firstname"));
			emp.setLname(rs.getString("lastname"));
			list.add(emp);
		}
		System.out.println(list);
		return list;
		
	}
	
	public List<Employees> getReportingEmployees() throws Exception {
	    List<Employees> list = new ArrayList<>();
	    String qry = "SELECT e.EmployeeID, e.FirstName, e.LastName " +
	                 "FROM Employees e " +
	                 "JOIN Roles r ON r.RoleId = e.RoleId " +
	                 "WHERE r.RoleName NOT IN ('HR', 'Manager') " +
	                 "AND e.EmployeeID NOT IN (SELECT employee FROM Manager)";
	    PreparedStatement ps = con.prepareStatement(qry);
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
	        Employees r = new Employees();
	        r.setEmpId(rs.getInt("EmployeeId"));
	        r.setFname(rs.getString("FirstName"));
	        r.setLname(rs.getString("LastName"));
	        list.add(r);
	    }
	    return list;
	}
	
	public boolean addReportee(Manager m) throws SQLException {
		
		String qry="Insert into Manager (manager,employee) values (?,?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, Integer.parseInt(m.getManager()));
		ps.setInt(2, Integer.parseInt(m.getEmployee()));
		
	    int i=ps.executeUpdate();
	    if(i>0) return true;
		
		return false;
	}
	
	public List<Manager> getReportingEmployee(int mid) throws SQLException {
		List<Manager> list=new ArrayList<>();
		String qry="select m.mgrId,concat(e.firstname,' ',e.lastname) as fullName from manager m join employees e on m.employee=e.EmployeeID where m.manager=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, mid);
		ResultSet rs=ps.executeQuery();
		
		while(rs.next())
		{
			Manager m=new Manager();
			m.setMgrID(rs.getInt("mgrId"));
			m.setFullName(rs.getString("fullName"));
			
			list.add(m);
		}
		
		return list;
	}
	
	public boolean removeReportee(int id) throws SQLException {
		
		String qry="delete from Manager where mgrId=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, id);
		int i=ps.executeUpdate();
		if(i>0) return true;
			
		return false;
	}
	
	// Method to add new role
	public boolean insertRole(String role) throws SQLException {
	    String insertQuery = "INSERT INTO roles (rolename) VALUES (?)";
	    String checkQuery = "SELECT COUNT(*) FROM roles WHERE rolename = ?";

	    // Check if the role already exists
	    try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
	        checkStmt.setString(1, role);
	        try (ResultSet rs = checkStmt.executeQuery()) {
	            if (rs.next() && rs.getInt(1) > 0) {
	                // Role already exists
	                return false;
	            }
	        }
	    }

	    // Insert the new role
	    try (PreparedStatement insertStmt = con.prepareStatement(insertQuery)) {
	        insertStmt.setString(1, role);
	        int i = insertStmt.executeUpdate();
	        if (i > 0) {
	            return true;
	        }
	    }
	    return false;
	}

	
	
	
	// Method to check leaves on current date
	public boolean getLeave(int empId,String fDate,String tDate) throws SQLException
	{
		String qry="SELECT COUNT(*) FROM leaves WHERE employeeid = ? AND (startdate >= ? AND enddate <= ?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, empId);
		ps.setString(2, fDate);
		ps.setString(3, tDate);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			return rs.getInt(1) > 0;
		}
		
		return false;
	}
	
	
	// Method to filter employees based on empno
	public List<Employees> getEmployeesByEmpNo(String empno) throws SQLException {
		List<Employees> list = new ArrayList<>();
			String query = "SELECT * FROM employees WHERE empno LIKE ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + empno + "%");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				emp.setEmpNo(rs.getString("empno"));
				emp.setPersonalMobile(rs.getString("personalmobile"));
				emp.setWorkEmail(rs.getString("workemail"));
				list.add(emp);
			}
		return list;
	}
	
	// Method to filter employees based on empno
		public List<Employees> getEmployeesByEmpName(String empName) throws SQLException {
			
			List<Employees> list = new ArrayList<>();
				String query = "SELECT * FROM employees WHERE firstName LIKE ? OR lastName LIKE ?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%" + empName + "%");
				pstmt.setString(2, "%" + empName + "%");
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					Employees emp = new Employees();
					emp.setEmpId(rs.getInt("employeeid"));
					emp.setFname(rs.getString("firstName"));
					emp.setLname(rs.getString("lastName"));
					emp.setEmpNo(rs.getString("empno"));
					emp.setPersonalMobile(rs.getString("personalmobile"));
					emp.setWorkEmail(rs.getString("workemail"));
					list.add(emp);
				}
			return list;
		}
		
		
		
		public List<Employees> getEmployeesByEmpNameAndNo(String empno,String empname) throws SQLException {
			List<Employees> list = new ArrayList<>();
				String query = "SELECT * FROM employees WHERE empno LIKE ? and firstname like ? and lastname like ?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%" + empno + "%");
				pstmt.setString(2, "%" + empname + "%");
				pstmt.setString(3, "%" + empname + "%");
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					Employees emp = new Employees();
					emp.setEmpId(rs.getInt("employeeid"));
					emp.setFname(rs.getString("firstName"));
					emp.setLname(rs.getString("lastName"));
					emp.setEmpNo(rs.getString("empno"));
					emp.setPersonalMobile(rs.getString("personalmobile"));
					emp.setWorkEmail(rs.getString("workemail"));
					list.add(emp);
				}
			return list;
		}
}
