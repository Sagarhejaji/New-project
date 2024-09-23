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

<link rel="stylesheet"
	href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
<script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
</head>
<style>

/*====================================table starts========================================*/
@media ( max-width : 768px) {
	.leave-table {
		font-size: 14px;
	}
	.leave-table th, .leave-table td {
		padding: 2px 2px;
	}
}

/* table css starts*/
.table-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	max-width: 100%;
	margin-top: 10%;
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

.leave-table button {
	background-color: #ff8a65;
	color: white;
	border: none;
	padding: 10px 10px;
	font-size: 16px;
	border-radius: 5px;
	cursor: pointer;
	width: 90%;
}

/*==============================table css ends=================================================*/

/*========================================poup css starts==================================*/
.popup {
	display: none;
	position: fixed;
	z-index: 1002;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid #888;
	border-radius: 8px;
	background-color: #fefefe;
	padding: 20px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	width: 400px;
	text-align: center;
}

.close-btn {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close-btn:hover, .close-btn:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.popup h2 {
	color: #333;
	margin: 10px;
}

.popup textarea {
	width: 95%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.popup input.sub {
	width: 50%;
	padding: 10px;
	margin-top: 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

.popup input.sub:hover {
	background-color: #0056b3;
}

.warning {
	margin: 10px;
}

.msg {
	margin: 15px;
}

/* Styling for form container */
.PopupForm {
	max-width: 400px;
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Styling for form labels */
.PopupForm label {
	display: block;
	margin-bottom: 5px;
	color: #333333;
	font-weight: bold;
}

/* Styling for form inputs */
.PopupForm input[type="text"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #cccccc;
	border-radius: 4px;
	font-size: 14px;
}

/* Styling for submit button */
.PopupForm input[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: #ffcc80;
	color: #ffffff;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.PopupForm input[type="submit"]:hover {
	background-color: #ff8a65;
}

.filter-form {
	display:flex;
	margin: 10px;
	padding: 10px;
}
.filter-group
{
padding:5px;
margin-right:10px;
}

.filter-group input[type="text"],
.filter-group select {
    width: 120px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}
.filter-group button
{
margin-left:50%;
}
.apply-btn{
    background-color: #8bc34a;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1em;
    white-space: nowrap;
}

.apply-btn:hover {
    background-color: #7cb342;
}
/* =============================================popup css ends======================================*/

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

document.addEventListener("DOMContentLoaded", function() {
    flatpickr("#fromDate", {
    });
    flatpickr("#toDate", {
    });
});

window.onload = function() {
	toggleMonthDropdown(); // Initial check
<%Boolean f = (Boolean) request.getAttribute("flag");
if (f != null && f) {%>
document.getElementById("myPopup").style.display = "block";
<%}%>
}


//to highlight the active tabs(anchor tag links) 

document.addEventListener("DOMContentLoaded", function() {
	    var currentPage = window.location.pathname.split("/").pop();
	    var targetPage = "attendance.jsp";
	    
	    var leavePages = ["applyLeave.jsp","applyLeaveFor.jsp","assignLeave.jsp","employeeLeaves.jsp","holidays.jsp","leaveRequests.jsp","myLeaves.jsp"];
	    var timePages = ["attendance.jsp", "attendanceRequest.jsp","employeesAttendance.jsp"];
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
		}else if (currentPage === "filterAttendanceBy" || currentPage === "requestUpdate") {
		    targetPage = "attendance.jsp";
		    document.querySelector(".activeAttendance").classList.add("active");
		}
	    else{
			document.querySelector(".activeDashboard").classList.add("active");
	    }
	});


function openPopup() {
	document.getElementById("myPopup").style.display = "block";
}

function openPopup2(AttenId, Date, CITime, COTime) {
	document.getElementById("attenId").value = AttenId;
	document.getElementById("date").value = Date;
	document.getElementById("cit").value = CITime;
	document.getElementById("cot").value = COTime;
	document.getElementById("myPopup2").style.display = "block";
}

function closePopup(popupId) {
	document.getElementById(popupId).style.display = "none";
}

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
    	
       // if(sess.getAttribute("role").equals("HR"))
       // {
       //  list2 = empDao.getPendingLeaves();
       // }else if(sess.getAttribute("role").equals("Manager"))
       // {
       // list2 = empDao.getMgrPendingLeaves(emp.getEmpId());
       // }
       	String selectedEmpIdStr = request.getParameter("empid");

           int selectedEmpId = (selectedEmpIdStr != null && !selectedEmpIdStr.isEmpty()) ? Integer.parseInt(selectedEmpIdStr) : -1;

       
       List<Employees> employees = null;
	Employees emp2 = (Employees)sess.getAttribute("employee");

	int mid = emp2.getEmpId();
	
	if ("HR".equals(role)) {
		employees = empDao.getEmployees();
	}
	if ("Manager".equals(role)) {
		employees = empDao.getReportees(mid);
	}
        
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
			<h1>Time Logs / Employees Attendance Records</h1>
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
		Hello guru!
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
			<h2>Attendance Records</h2>
			<hr>

			<div class="filter">
				<form action="filterAttendanceBy" method="post" class="filter-form">
					<input type="hidden" name="id" value="<%=emp.getEmpId()%>">
					<input type="hidden" name="origin" value="attendance"> 
					
					<div class="filter-group">
						<label for="employeeid">Employee Name *</label> <select id="empid"
							name="empid" required>
							<option value="">Select Employee</option>
							<%
							for (Employees r : employees) {
							%>
							<option value="<%=r.getEmpId()%>"
								<%=(r.getEmpId() == selectedEmpId) ? "selected" : ""%>>
								<%=r.getFname() + " " + r.getLname()%>
							</option>
							<%
							}
							%>
						</select>
					</div>
					
					
					<div class="filter-group">
					<label for="year">Year *</label> 
					<input type="text" id="year" name="year" onkeyup="toggleMonthDropdown()" value="<%=request.getParameter("year") != null ? request.getParameter("year") : ""%>" required>
					</div>
					
					<div class="filter-group">
					<label for="month">Month </label> <select id="month" name="month">
						<option value=""
							<%= "".equals(request.getParameter("month")) ? "selected" : "" %>>Select
							Month</option>
						<option value="01"
							<%= "01".equals(request.getParameter("month")) ? "selected" : "" %>>January</option>
						<option value="02"
							<%= "02".equals(request.getParameter("month")) ? "selected" : "" %>>February</option>
						<option value="03"
							<%= "03".equals(request.getParameter("month")) ? "selected" : "" %>>March</option>
						<option value="04"
							<%= "04".equals(request.getParameter("month")) ? "selected" : "" %>>April</option>
						<option value="05"
							<%= "05".equals(request.getParameter("month")) ? "selected" : "" %>>May</option>
						<option value="06"
							<%= "06".equals(request.getParameter("month")) ? "selected" : "" %>>June</option>
						<option value="07"
							<%= "07".equals(request.getParameter("month")) ? "selected" : "" %>>July</option>
						<option value="08"
							<%= "08".equals(request.getParameter("month")) ? "selected" : "" %>>August</option>
						<option value="09"
							<%= "09".equals(request.getParameter("month")) ? "selected" : "" %>>September</option>
						<option value="10"
							<%= "10".equals(request.getParameter("month")) ? "selected" : "" %>>October</option>
						<option value="11"
							<%= "11".equals(request.getParameter("month")) ? "selected" : "" %>>November</option>
						<option value="12"
							<%= "12".equals(request.getParameter("month")) ? "selected" : "" %>>December</option>
					</select>
					</div>
					
					<div class="filter-group">
					<label for="fromDate">FromDate </label>
            		<input type="text" id="fromDate" name="fromDate" value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">
					</div>
					
					<div class="filter-group">
					<label for="toDate">ToDate </label>
          		    <input type="text" id="toDate" name="toDate" value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">
					</div>
					
					<div class="filter-group">
					<button type="submit" class="apply-btn">Filter</button>
					</div>
					
					
				</form>
			</div>
			<table class="leave-table">
				<%if(attendanceList!=null) {%>
				<thead>
					<tr>
						<th>Date</th>
						<th>Check In Time</th>
						<th>Check Out Time</th>
						<th>Total Hours</th>
						<th>Remarks</th>
						<th>Request Update</th>
					</tr>
				</thead>
				<tbody>
					<%
							for (Attendance attendance : attendanceList) {
								boolean highlightRow = (attendance.getCheckin() != null && attendance.getCheckout() == null)
								&& (LocalDate.now().isAfter(LocalDate.parse(attendance.getDate(), formatter)));
							%>
					<tr <%=highlightRow ? "style='background-color: #949494;'" : ""%>>
						<td><%=attendance.getDate()%></td>
						<td><%=attendance.getCheckin()%></td>
						<td><%=attendance.getCheckout()%></td>
						<td>
							<%
									if (attendance.getCheckin() != null && attendance.getCheckout() != null) {
										try {
											LocalTime st = LocalTime.parse(attendance.getCheckin());
											LocalTime et = LocalTime.parse(attendance.getCheckout());
											Duration difference = Duration.between(st, et);
											long hours = difference.toHours();
											long minutes = difference.toMinutes() % 60;
											out.print(hours + "h : " + minutes + "m");
										} catch (Exception ex) {
											out.print("Invalid time format");
										}
									} else if (attendance.getCheckin() != null && attendance.getCheckout() == null
											&& LocalDate.now().isAfter(LocalDate.parse(attendance.getDate(), formatter))) {
										out.print("Checkout is missing");
									} else {
										out.print("-");
									}
									%>
						</td>
						<td>
							<%
									if (attendance.getRemarks() == null)
										out.print("-");
									else
										out.print(attendance.getRemarks());
									%>
						</td>

						<td>
							<%
									if (attendance.isButtonClicked() == 0 && 
								    !("Weekend".equals(attendance.getRemarks()) || 
								      "Holiday".equals(attendance.getRemarks()) || 
								      "Leave".equals(attendance.getRemarks()))) {
									%>
							<button
								onclick="openPopup2('<%=attendance.getAttendId()%>', '<%=attendance.getDate()%>', '<%=attendance.getCheckin()%>', '<%=attendance.getCheckout()%>')">Request
								Update</button> <% } else {
											 out.print("-");
										 }
										 %>

						</td>
					</tr>
					<%
							}
							%>
				</tbody>
				<%} else { %>
				<thead>
					<tr>
						<th>Table Actions</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td><%="Select employee from dropdown to view Data !!!"%></td>
					</tr>
					
				</tbody>
				<%} %>
			</table>
		</div>


		<!-- Attendance Update Popup -->
		<div id="myPopup2" class="popup">
			<span class="close-btn" onclick="closePopup('myPopup2')">&times;</span>
			<h2>Update Attendance</h2>
			<form action="requestUpdate" method="get" class="PopupForm">
				<label for="attenId"></label> <input type="hidden" id="attenId"
					name="attenId"> <input type="hidden" name="empName"
					value="<%=empName%>"> <label for="date">Date:</label> <input
					type="text" id="date" name="date" readonly> <label
					for="cit">Check In Time:</label> <input type="text" id="cit"
					name="cit" placeholder="HH:MM:SS (24hr)"> <label for="cot">Check
					Out Time:</label> <input type="text" id="cot" name="cot"
					placeholder="HH:MM:SS (24hr)"> <input type="submit"
					value="Request">
			</form>
		</div>

		<!-- General Notification Popup -->
		<div id="myPopup" class="popup">
			<span class="close-btn" onclick="closePopup('myPopup')">&times;</span>
			<h2>Warning!</h2>
			<form action="insertYES" method="post">
				<input type="hidden" name="eid" value="<%= emp.getEmpId()%>">
				<input type="hidden" name="leaveid" id="leaveid">
				<div class="warning">
					<h5>Today it's not a working day (Holiday!)</h5>
				</div>
				<div class="msg">Are you sure you want to login?</div>
				<div>
					<input type="submit" value="Proceed to login" name="yes">
				</div>
			</form>
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
	
	
	//Displaying messages for different scenarios

	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% } 
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Success")){%> 
	showMessage('success', 'Request Sent...');
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