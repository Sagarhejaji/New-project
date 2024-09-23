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
<title>Employee Management</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="script.js" defer></script>
</head>
<style>


body {
	font-family: Arial, sans-serif;
	display: flex;
	transition: padding-left 0.3s ease;
	background-color: #f5f5f5;
	box-sizing: border-box;
}

.sidebar {
	width: 250px;
	background-color: white;
	height: 100vh;
	position: fixed;
	left: 0;
	top: 0;
	transition: all 0.3s ease;
	overflow-x: hidden;
	z-index: 1000;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
	border-radius: 0 20px 20px 0;
}

.sidebar.collapsed {
	width: 60px;
}

.logo {
	padding: 20px;
	border-bottom: 1px solid #e0e0e0;
}

.logo img {
	max-width: 100%;
	height: auto;
}

.sidebar-menu {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.sidebar-menu li {
	padding: 15px 20px;
	transition: all 0.3s ease;
	white-space: nowrap;
}

.sidebar-menu li:hover {
	background-color: #f0f0f0;
}

.sidebar-menu li.active {
	background-color: #ff8c00;
	color: white;
}

.sidebar-menu i {
	margin-right: 10px;
}

.sidebar.collapsed .menu-text {
	display: none;
}

.sidebar.collapsed .sidebar-menu li {
	text-align: center;
}

.toggle-btn {
	position: fixed;
	left: 230px;
	top: 10px;
	background: linear-gradient(to left,#FF9671 ,#FFC75F );
	
	border:none;
	border-radius: 30px;
	padding: 10px;
	cursor: pointer;
	transition: all 0.3s ease;
	z-index: 1001;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.toggle-btn i {
	display: none;
}

.toggle-btn i.show {
	display: inline;
}

.sidebar.collapsed+.toggle-btn {
	left: 40px;
}

.main-content {
	flex: 1;
	padding: 20px;
	margin-left: 250px;
	transition: margin-left 0.3s ease;
}

.header {
	
	background: linear-gradient(to left,#FF9671 ,#FFC75F );
	color: white;
	padding: 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;

}

.dashboard-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.dashboard-item {
	background-color: #fff;
	border-radius: 30px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	padding: 15px;
}

.user-profile {
	position: relative;
}

.user-dropdown {
	display: inline-block;
}


.dropbtn {
	background:linear-gradient(to left,#FFC75F ,#FF9671 );
	color: white;
	padding: 10px 15px;
	font-size: 16px;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.dropbtn:hover, .dropbtn:focus {
	background-color: #e67e00;
}

.dropdown-content {
	display: none;
	position: absolute;
	right: 0;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1001;
	border-radius: 5px;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
}

.show {
	display: block !important;
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

.chart-bar {
	width: 12%;
	background-color: #ff8c00;
	transition: height 0.3s ease;
	border-radius:15px;
}

.chart-labels {
	display: flex;
	justify-content: space-between;
	font-size: 0.8em;
	color: #666;
}

@media screen and (max-width: 768px) {
	body {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		height: auto;
	}
	.main-content {
		margin-left: 0;
	}
	.toggle-btn {
		display: none;
	}
}

@media screen and (max-width: 600px) {
	.user-dropdown {
		display: block;
		width: 100%;
	}
	.dropdown-content {
		width: 100%;
	}
}

body.sidebar-collapsed {
	padding-left: 60px;
}

body.sidebar-collapsed .main-content {
	margin-left: 60px;
}
a {
    text-decoration: none;
    color:black;
}

h1
{
margin:10px;
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


.sidebar-menu li.active {
  background-color: red; /* Adjust color as desired */
}

/*CSS for Quick Launch*/

.quick-launch-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
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
    font-size: 20px;
}

.quick-launch-text {
    font-size: 12px;
    color: #333;
}



</style>
<body>
	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
        
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
        
    %>

	<div class="sidebar" id="sidebar">
    <div class="logo">
        
    </div>
    <ul class="sidebar-menu">
        <li><a href="dashboard.jsp" id="dashboard-link"><i class="fas fa-tachometer-alt"></i><span class="menu-text"> Dashboard</span></a></li>
        <li><a href="admin.jsp" id="admin-link"><i class="fas fa-user-cog"></i><span class="menu-text"> Admin</span></a></li>
        <li><a href="pim.jsp" id="pim-link"><i class="fas fa-users"></i><span class="menu-text"> PIM</span></a></li>
        <li><a href="applyLeave.jsp" id="leave-link"><i class="fas fa-calendar-alt"></i><span class="menu-text"> Leave</span></a></li>
        <li><a href="time.jsp" id="time-link"><i class="fas fa-clock"></i><span class="menu-text"> Time</span></a></li>
        <li><a href="recruitment.jsp" id="recruitment-link"><i class="fas fa-user-plus"></i><span class="menu-text"> Recruitment</span></a></li>
        <li><a href="myinfo.jsp" id="myinfo-link"><i class="fas fa-id-badge"></i><span class="menu-text"> My Info</span></a></li>
    </ul>
</div>


	<button id="toggleSidebar" class="toggle-btn">
		<i class="fas fa-chevron-left show"></i> <i
			class="fas fa-chevron-right"></i>
	</button>

	<div class="main-content">
		<header class="header">
			<h1>Home</h1>
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
				<div class="punch-status">
					<div class="punch-info"></div>
				</div>
				<div class="time-today">
					<span class="hours">Today</span> <br><br>
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
                    {
                    	%>
                    	
                    	Not logged in today!
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
						<div class="chart-bar" style="height: <%= hr * 10 %>%;"></div>
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
    <h3>Quick Launch</h3>
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
        
        <div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-stopwatch"></i>
            </div>
            <span class="quick-launch-text">My Time Logs</span>
        </div>
        
        
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
        
        <div class="quick-launch-button">
            <div class="quick-launch-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <span class="quick-launch-text">Add Employee</span>
        </div>
        
    </div><%}%>
    
</div>
		</div>
	</div>
	<script type="text/javascript">
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
	</script>
</body>
</html>