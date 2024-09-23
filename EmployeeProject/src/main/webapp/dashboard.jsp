<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.entities.Leaves"%>
<%@ page import="com.emp.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.emp.dao.EmpDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="script.js" defer></script>
<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="show.css">
<link rel="stylesheet" href="message.css">
</head>
<style>
.dashboard-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(15%, 1fr));
	gap: 2%;
	margin-top: 5%;
	padding:20px;
}

.dashboard-item {
	background-color: #fff;
	border-radius: 30px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	padding: 15px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.dashboard-item:hover {
    transform: scale(1.05);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}


.time-at-work {
	padding: 20px;
}

.punch-status {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

.time-today {
	background-color: #f0f0f0;
	padding: 10px;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
}

.time-today .hours {
	font-weight: bold;
}



.weekly-chart h4 {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.chart-container {
	height: 150px;
	display: flex;
	align-items: flex-end;
	justify-content: space-between;
	margin-bottom: 10px;
}

.chart-bar-wrapper {
    
    
}

.chart-bar {
	width: 12%;
	background: linear-gradient(to left,#FF9671 ,#FFC75F );
	transition: height 0.3s ease;
	border-radius:15px 15px 0 0;
	position: relative;
	display: flex;
    justify-content: center;
    align-items: flex-end;
    padding-bottom: 5px;

}

.hour-value {
    color: white;
    font-size: 0.8em;
    font-weight: bold;

    
}

.chart-labels {
	display: flex;
	justify-content: space-between;
	font-size: 0.8em;
	color: #666;
}

/* below css for My Leaves card  */
.leave-entry {
	background-color: #f0f0f0;
	border-radius: 6px;
	padding: 15px;
	margin-bottom: 10px;
}

.leave-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 5px;
}

.leave-label {
	font-weight: bold;
	color: #333;
}

.leave-value {
	text-align: right;
	color: #666;
}

.status-approved {
	color: #4caf50;
}

.status-rejected {
	color: #f44336;
}
/*CSS for Quick Launch*/

.quick-launch-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 2%;
}

.quick-launch-button {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-color: #f5f5f5;
    border-radius: 8px;
    padding: 15px;
    text-align: center;
    transition: background-color 0.3s ease;
}

.quick-launch-button:hover {
    background-color: #e0e0e0;
}

.quick-launch-icon {
    width: 40px;
    height: 40px;
    background-color: #ddd;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 8px;
}

.quick-launch-icon i {
    color: #666;
    font-size: 120%;
}

.quick-launch-text {
    font-size: 12px;
    color: #333;
}

.notification {
  background-color: #f8f8f8;
  border-left: 4px solid #4a90e2;
  padding: 12px 15px;
  margin-bottom: 10px;
  border-radius: 0 10px 10px 0;
  transition: background-color 0.2s ease;
}

.notification:hover {
  background-color: #f0f0f0;
}

.notifrow a {
  text-decoration: none;
  color: #333;
  font-size: 0.9rem;
  display: block;
}

.notifvalue {
  font-weight: bold;
  color: #4a90e2;
}
.logInOut
{
display:flex;
justify-content:space-around;
}
.btn
{
background-color:#f0f0f0;
padding:2px;
border-radius:10px;
}
input[type="submit"]
{
padding:10px;
background-color:white;
border:none;
border-radius:10px;
cursor:pointer;
}
input[type="submit"]:hover
{
	color:#ff8c00;
	background-color: #fff9f0;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transform: translateX-2px);
	font-weight:bold;
}

/* css for success and error messages */
.message-container {
    position: fixed;
    top: -200px; /* Move completely out of view */
    left: 50%;
    transform: translateX(-50%);
    padding: 15px 30px;
    border-radius: 12px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
    text-align: center;
    transition: all 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
    z-index: 1002;
    max-width: 90%;
    backdrop-filter: blur(10px); /* Stronger blur effect */
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
}

.message-container.show {
    top: 30px;
    animation: shake 0.82s cubic-bezier(.36, .07, .19, .97) both;
}

.message-container.success {
    background-color: rgba(144, 238, 144, 0.8);
}

.message-container.error {
    background-color: rgba(220, 53, 69, 0.8);
}

.message-container p {
    font-weight: bold;
    margin: 8px 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    /* More modern font */
}

.message-container p:first-child {
    font-weight: bold;
    font-size: 20px;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.message-container i {
    font-size: 24px;
    margin-right: 10px;
    vertical-align: middle;
}



</style>
<body>

	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
        
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
        //String msg = (String)request.getAttribute("msg");
        
        
        // list of records to display pending leaves to HR and Manager
        List<Leaves> list2=null;
        if(sess.getAttribute("role").equals("HR"))
        {
         list2 = empDao.getPendingLeaves();
        }else if(sess.getAttribute("role").equals("Manager"))
        {
        list2 = empDao.getMgrPendingLeaves(emp.getEmpId());
        }
        
        
        // list of records to display attendance requests to HR and Manager
        List<Attendance> list4=null;
        if(role.equals("Manager")){
    		list4=empDao.ManagerAttendance(emp.getEmpId());
        }else{
    	list4=empDao.HRAttendance();
        }
        
    %>

	<div class="sidebar" id="sidebar">
    <div class="logo">
        
    </div>
    <ul class="sidebar-menu">
        <li class="activeDashboard"><a href="dashboard.jsp" id="dashboard-link"><i class="fas fa-tachometer-alt"></i><span class="menu-text"> Dashboard</span></a></li>
        
		<%if(role.equals("HR") || role.equals("Manager")) { %>
        <li class="activePeople"><a href="employees.jsp" id="pim-link"><i class="fas fa-users"></i><span class="menu-text"> People</span></a></li>
        <%}%>          
        <li class="activeLeave"><a href="applyLeave.jsp" id="leave-link"><i class="fas fa-calendar-alt"></i><span class="menu-text"> Leave</span></a></li>
        <li class="activeAttendance"><a href="attendance.jsp" id="time-link"><i class="fas fa-clock"></i><span class="menu-text"> Time Logs</span></a></li>
        <li class="activeProfile"><a href="profile.jsp" id="myinfo-link"><i class="fas fa-user"></i><span class="menu-text"> My Info</span></a></li>
        <%if(role.equals("HR")) { %>
        <li class="activeContact"><a href="contacts.jsp" id="pim-link"><i class="fas fa-address-book"></i><span class="menu-text"> Contacts</span></a></li>
        <%}%> 
    </ul>

</div>


	<button id="toggleSidebar" class="toggle-btn">
		<i class="fas fa-chevron-left show"></i> <i
			class="fas fa-chevron-right"></i>
	</button>

	<div class="main-content">
		<header class="header">
			<h1>Dashboard</h1>
			<div class="user-profile">
				<div class="user-dropdown">
					<button class="dropbtn" id="userDropdown">
						<%= emp.getFname() + " " + emp.getLname() %>
						<i class="fas fa-caret-down"></i>
					</button>
					<div class="dropdown-content" id="userDropdownContent">
						<a href="changePassword.jsp">Change Password</a> <a
							href="logoutServlet">Logout</a>
					</div>
				</div>
			</div>
		</header>

		<div class="dashboard-grid">
			<div class="dashboard-item time-at-work">
				<h3>
					<i class="fas fa-clock"></i> Time Logs
				</h3>
				<hr>
				<div class="logInOut">
				
					<div class="btn">
						<form action="insertLogin" method="post">
						<input type="submit" value="Check In" name="login">
						</form>
					</div>
				
					<div class="btn">
						<form action="updateLogout" method="post">
						<input type="submit" value="Check Out" name="logout">
						</form>
					</div>
				
				</div>
				
				
				<hr>
				
			<h4>Today</h4>
				<div class="time-today">
					
					<%
                    Attendance att = empDao.getCheckInCheckOutTime(emp.getEmpId()); 
                    if(att.getCheckin()!=null)
                    { %>
                    	<div class="leave-row">
                    	<span class="leave-label">Check In Time: </span>
                    	<span class="leave-value"><%= att.getCheckin() %></span>
                    	</div>
                    	
                    	<%if(att.getCheckout()!=null){ %>
                    	<div class="leave-row">
                    	<span class="leave-label">Check Out Time: </span>
                    	<span class="leave-value"><%= att.getCheckout() %></span>
                    	</div>
                    <%}
                    }else
                    {%>
                    Not Logged in today !!!
                    	<%} %>
                    
				</div>
				<div class="weekly-chart">
					<h4>This Week</h4>

					<%
                    List<Attendance> weekLogs = (List<Attendance>)sess.getAttribute("weekLogs");
                    %>
					<div class="chart-container" id="weeklyChartContainer">
						<% for(Attendance hours : weekLogs) {
                            double hr = Double.parseDouble(hours.getDuration());
                        %>
						
            <div class="chart-bar" style="height: <%= hr * 10 %>%;">
                <span class="hour-value"><%= String.format("%.1f", hr) %></span>
            </div>
        
						<% } %>
					</div>
					<div class="chart-labels">
						<span>Mon</span> <span>Tue</span> <span>Wed</span> <span>Thu</span>
						<span>Fri</span> <span>Sat</span> <span>Sun</span>
					</div>
				</div>
			</div>
			
			<div class="dashboard-item">
				<h3>
					<i class="fas fa-calendar-alt"></i> My Leaves
				</h3>
				<hr>
				<%
				List<Leaves> list = empDao.getCurrMonthLeaves(emp.getEmpId());
				//out.print("leaves : "+list);
				for(Leaves leave:list){
				
				%>
				<div class="leave-entry">
					<div class="leave-row">
						<span class="leave-label">From</span> <span class="leave-value"><%= leave.getFromDate() %></span>
					</div>
					<div class="leave-row">
						<span class="leave-label">To</span> <span class="leave-value"><%= leave.getToDate()%></span>
					</div>
					<div class="leave-row">
						<span class="leave-label">Status</span> <span
							class="leave-value status-approved"><%= leave.getLeaveStatus()%></span>
					</div>
				</div>
				<%} %>
			</div>
			
			<div class="dashboard-item">
    <h3><i class="fa fa-bolt" aria-hidden="true"></i> Quick Launch</h3>
    <hr>
    <div class="quick-launch-grid">
      
     <a href="applyLeave.jsp"> <div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-paper-plane"></i>
            </div>
            <span class="quick-launch-text">Apply Leave</span>
        </div></a>
        
       <a href="myLeaves.jsp"><div class="quick-launch-button">
            <div class="quick-launch-icon">
              <i class="fas fa-list"></i>
                
            </div>
            <span class="quick-launch-text">My Leave</span>
        </div></a> 
        
        <a href="attendance.jsp"><div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-stopwatch"></i>
            </div>
            <span class="quick-launch-text">My Time Logs</span>
        </div></a>
        
        
        <a href="holidays.jsp"><div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-calendar-alt"></i>
            </div>
            <span class="quick-launch-text">Holidays</span>
        </div></a>
        

        
    </div>
   
    <% if("HR".equals(role)) {%>
     <hr>
    <div class="quick-launch-grid">
      
    <a href="assignLeave.jsp"><div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
            <span class="quick-launch-text">Assign Leave</span>
        </div></a>
        
        <a href="holidays.jsp"><div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-calendar-plus"></i>
            </div>
            <span class="quick-launch-text">Add Holiday</span>
        </div></a>
        
        <a href="addEmployee.jsp"><div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <span class="quick-launch-text">Add Employee</span>
        </div></a>
        
    </div><%}%>
    
</div>

		<% if("HR".equals(role) || "Manager".equals(role)) {%>

			<div class="dashboard-item">
				<h3>
					<i class="fa fa-bell" aria-hidden="true"></i> Notifications
				</h3>
				<hr>
				<h4>Leaves</h4>
				<%
				for(Leaves lev:list2){
				%>
				<div class="notification">
					<div class="notifrow">
						<a href="leaveRequests.jsp"><span class="notifvalue"><%= lev.getFname()+" "+lev.getLname()%></span> : has applied leave.</a> 
					</div>
				</div>
				<%} %>
				<h4>Attendance</h4>
				
				<%
				for(Attendance attend:list4){
				%>
				
				<div class="notification">
					<div class="notifrow">
						<a href="attendanceRequest.jsp"><span class="notifvalue"><%= attend.getName()%></span> : has requested attendance update.</a> 
					</div>
				</div>
				<%} %>
			</div>
			<%} %>
			
			
		</div>
	</div>
	<script type="text/javascript">
	
	document.addEventListener("DOMContentLoaded", function() {
        var currentPage = window.location.pathname.split("/").pop();
        
        var leavePages = ["applyLeave.jsp","applyLeaveFor.jsp","assignLeave.jsp","employeeLeaves.jsp","holidays.jsp","leaveRequests.jsp","myLeaves.jsp"];
        var timePages = ["attendance.jsp", "attendanceRequest.jsp"];
        
        if (leavePages.includes(currentPage)) {
            document.querySelector(".activeLeave").classList.add("active");
        } else if (timePages.includes(currentPage)) {
            document.querySelector(".activeAttendance").classList.add("active");
        }
        else{
                document.querySelector(".activeDashboard").classList.add("active");
        }
    });
	
	// Get the current page name from the URL (assuming filenames match)
	var currentPage = window.location.pathname.split("/").pop();

	// Remove the ".jsp" extension if present
	currentPage = currentPage.replace(".jsp", "");

	// Get all the menu links
	var menuLinks = document.querySelectorAll(".sidebar-menu li a");

	// Loop through each link and add/remove active class
	for (var i = 0; i < menuLinks.length; i++) {
	  var link = menuLinks[i];
	  var linkHref = link.getAttribute("href");
	  
	  if (linkHref === currentPage || linkHref.endsWith("/" + currentPage)) {
	    link.parentNode.classList.add("active");
	  } else {
	    link.parentNode.classList.remove("active");
	  }
	}
	
	
	// Displaying messages for different scenarios

	// this if conditions for login scenarios
	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% } 
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Login")){%> 
	showMessage('success', 'Logged in!!!...');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("onLeave")){%> 
	showMessage('error', 'You are on leave today !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Holiday")){%> 
	showMessage('error', 'Today is holiday or weekend !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("alreadyLoggedIn")){%> 
	showMessage('error', 'Already logged in !!!');
	<%}
	// this if conditions for logout scenarios
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("AlreadyLoggedOut")){%> 
	showMessage('error', 'Already logged out !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("NotLoggedIn")){%> 
	showMessage('error', 'Not logged in yet !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("logout")){%> 
	showMessage('success', 'logged out !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("pwdSaved")){%> 
	showMessage('success', 'Password changed successfully.... !!!');
	<%}%>}
	
	
	// new js function to display messages
	function showMessage(type, message) {
	    const messageContainer = document.getElementById('message-container');
	    const messageText = document.getElementById('message-text');
	    const messageIcon = document.getElementById('message-icon');

	    messageContainer.classList.remove('success', 'error', 'show');
	    messageContainer.classList.add(type);
	    messageText.textContent = message;
	    messageIcon.className = type === 'success' ? 'fas fa-check-circle' : 'fas fa-exclamation-triangle';

	    messageContainer.classList.add('show');
	    setTimeout(() => {
	        messageContainer.classList.remove('show');
	    }, 4000);
	}

	// Usage examples:
	// showMessage('success', 'Leave Applied Successfully...');
	// showMessage('error', 'Something Went Wrong!');
		
	</script>
	
	<div id="message-container" class="message-container">
    <span id="message-icon"></span>
    <p id="message-text"></p>
</div>
</body>
</html>