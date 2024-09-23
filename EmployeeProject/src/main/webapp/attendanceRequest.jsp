<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.entities.Leaves"%>
<%@ page import="com.emp.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.emp.dao.EmpDao"%>

<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.Duration"%>

<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Attendance</title>

<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="show.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="script.js" defer></script>
</head>
<style>

/* table css starts*/
.table-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	max-width: 100%;
	margin-top: 12%;
	margin-left: 2%;
	transition: width 0.3s ease, margin-left 0.3s ease;
}

.leave-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 15px;
}

.leave-table th {
	text-align: left;
	padding: 10px 15px;
	color: black;
	font-weight: normal;
	border-bottom: 1px solid #e0e0e0;
	background-color: #c0c0c0;
	font-weight: bold;
}

.leave-table td {
	padding: 15px;
	background-color: #f5f5f5;
}

.leave-table tbody tr {
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
	border-radius: 20px;
}

.leave-table tbody tr td:first-child {
	border-top-left-radius: 20px;
	border-bottom-left-radius: 20px;
}

.leave-table tbody tr td:last-child {
	border-top-right-radius: 20px;
	border-bottom-right-radius: 20px;
}

input[type="submit"]
{
background-color: #28a745;
	color: white;
	border: none;
	padding: 10px 30px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
	width: 100%;
}

/*==============================table css ends=================================================*/

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

<script>


//to highlight the active tabs(anchor tag links) 

document.addEventListener("DOMContentLoaded", function() {
	    var currentPage = window.location.pathname.split("/").pop();
	    var targetPage = "attendance.jsp";
	    
	    var leavePages = ["applyLeave.jsp","applyLeaveFor.jsp","assignLeave.jsp","employeeLeaves.jsp","holidays.jsp","leaveRequests.jsp","myLeaves.jsp"];
	    var timePages = ["attendance.jsp", "attendanceRequest.jsp"];
		var peoplePages = ["employees.jsp","addEmployee.jsp"];
		var profilePage = ["profile.jsp"];
	    
	    if (leavePages.includes(currentPage)) {
	        document.querySelector(".activeLeave").classList.add("active");
	    } else if (timePages.includes(currentPage)) {
	        document.querySelector(".activeAttendance").classList.add("active");
	    } else if (peoplePages.includes(currentPage)) {
		    document.querySelector(".activePeople").classList.add("active");
		} else if (profilePage.includes(currentPage)) {
		    document.querySelector(".activeProfile").classList.add("active");
		}else if (currentPage === "filterAttendance" || currentPage === "AttendanceUpdate") {
		    targetPage = "attendance.jsp";
		    document.querySelector(".activeAttendance").classList.add("active");
		}
	    else{
			document.querySelector(".activeDashboard").classList.add("active");
	    }
	});

</script>

<body>
	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
        
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
        
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    	List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("filteredAttendance");
    	String empName = emp.getFname() + " " + emp.getLname();
        
    %>

	<div class="sidebar" id="sidebar">
		<div class="logo"></div>
		<ul class="sidebar-menu">
			<li class="activeDashboard"><a href="dashboard.jsp"
				id="dashboard-link"><i class="fas fa-tachometer-alt"></i><span
					class="menu-text"> Dashboard</span></a></li>

			<%if(role.equals("HR") || role.equals("Manager")) { %>
			<li class="activePeople"><a href="employees.jsp" id="pim-link"><i
					class="fas fa-users"></i><span class="menu-text"> People</span></a></li>
			<%}%>

			<li class="activeLeave"><a href="applyLeave.jsp" id="leave-link"><i
					class="fas fa-calendar-alt"></i><span class="menu-text">
						Leave</span></a></li>
			<li class="activeAttendance"><a href="attendance.jsp"
				id="time-link"><i class="fas fa-clock"></i><span
					class="menu-text"> Time Logs</span></a></li>
			<li class="activeProfile"><a href="profile.jsp" id="myinfo-link"><i
					class="fas fa-user"></i><span class="menu-text"> My Info</span></a></li>
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
			<h1>Time Logs / Attendance Requests</h1>
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

		<div class="attendLinks">
			<a href="attendance.jsp">Attendance Records List</a>
			<%if("HR".equals(role)){ %>
			<a href="attendanceRequest.jsp">Attendance Update Requests</a>
			<a href="employeesAttendance.jsp">Employees Attendance</a>
			<%}else if("Manager".equals(role)){ %>
			<a href="attendanceRequest.jsp">Attendance Update Requests</a>
			<a href="employeesAttendance.jsp">Reportees Attendance</a>
			<%} %>
		</div>

		<div class="table-container">
		<h2>Attendance Requests</h2>
		<hr>
			<table class="leave-table">
				<thead>
					<tr>
						<th>Name</th>
						<th>Date</th>
						<th>Old CheckIn Time</th>
						<th>New CheckIn Time</th>
						<th>Old CheckOut Time</th>
						<th>New CheckOut Time</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>

					<% 
            EmpDao er = new EmpDao(DBConnect.getConnection());
            List<Attendance> list2=null;
            
            if(role.equals("Manager"))
            		list2=er.ManagerAttendance(emp.getEmpId());
            else
            	list2=er.HRAttendance();

            for (Attendance e : list2) {
            %>
					<tr>
						<td><%= e.getName() %></td>
						<td><%= e.getDate()%></td>
						<td><%= e.getCheckin()%></td>
						<td><%= e.getNewcheckin()%></td>
						<td><%= e.getCheckout()%></td>
						<td><%= e.getNewcheckout()%></td>
						<td>
							<form action="AttendanceUpdate" method="get">
								<input type="hidden" name="id" value="<%=e.getAttendId() %>">
								<input type="hidden" name="Date" value="<%=e.getDate() %>">
								<input type="hidden" name="CIT" value="<%=e.getNewcheckin() %>">
								<input type="hidden" name="COT" value="<%=e.getNewcheckout() %>">
								<input type="submit" value="Approve">
							</form>
						</td>

					</tr>
					<% } %>

				</tbody>
			</table>



		</div>
	</div>
	<script>
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
	
	
	
	
	//Displaying messages for different scenarios

	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% } 
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Success")){%> 
	showMessage('success', 'Request Approved...');
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