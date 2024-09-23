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
<title>Leave</title>

<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="show.css">
<script src="script.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<style>
/* table css starts*/
.table-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	padding: 20px;
	max-width: 1200px;
	margin: 0 auto;
	margin-top: 12%;
	margin-left: 20px;
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

.cancel-btn {
	background-color: #fff3e0;
	color: #ff9800;
	border: none;
	padding: 6px 12px;
	border-radius: 20px;
	cursor: pointer;
	font-weight: bold;
}

@media ( max-width : 768px) {
	.leave-table {
		font-size: 14px;
	}
	.leave-table th, .leave-table td {
		padding: 10px 8px;
	}
	.cancel-btn {
		padding: 4px 8px;
		font-size: 12px;
	}
}
/* table css ends*/
.filter {
	align-items: center;
	margin: 10px;
	padding: 10px;
}

form {
	display: flex;
	width: 100%;
	justify-content: start;
	align-items: center;
}

form .form-container {
	display: 1;
	align-items: center;
	margin-right: 15px;
	gap: 10px;
}

.filter label {
	white-space: nowrap;
}

.filter input[type="text"], .filter select {
	width: 120px;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
}

form .form-button {
	margin-left: 50%;
}

.apply-btn {
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


/* css for success and error messages*/
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

.quick-launch-icon:hover {
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
</style>

<script>
	function toggleMonthDropdown() {
		var yearInput = document.getElementById('year');
		var monthDropdown = document.getElementById('month');
		monthDropdown.disabled = yearInput.value.trim() === "";
	}
	window.onload = function() {
		toggleMonthDropdown(); // Initial check
	}
	
	
	
	//to highlight the active tabs(anchor tag links) 

	document.addEventListener("DOMContentLoaded", function() {
		    var currentPage = window.location.pathname.split("/").pop();
		    var targetPage = "myLeaves.jsp";
		    
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
			}else if (currentPage === "filterLeave" || currentPage === "filterLeaveBy") {
			    targetPage = "myLeaves.jsp";
			    document.querySelector(".activeLeave").classList.add("active");
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
	Employees emp = (Employees) sess.getAttribute("employee");
	String role = (String) sess.getAttribute("role");

	List<Leaves> leaves = (List<Leaves>) request.getAttribute("filteredLeaves");
	
	String selectedEmpIdStr = request.getParameter("empid");
    int selectedEmpId = (selectedEmpIdStr != null && !selectedEmpIdStr.isEmpty()) ? Integer.parseInt(selectedEmpIdStr) : -1;

	//List<Leaves> leaves = null;
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
			<h1>Leave / Employees Leaves</h1>
			<div class="user-profile">
				<div class="user-dropdown">
					<button class="dropbtn" id="userDropdown">
						<%=emp.getFname() + " " + emp.getLname()%>
						<i class="fas fa-caret-down"></i>
					</button>
					<div class="dropdown-content" id="userDropdownContent">
						<a href="changePassword.jsp">Change Password</a> <a
							href="logoutServlet">Logout</a>
					</div>
				</div>
			</div>
		</header>
		<div class="leaveLinks">
			<a href="applyLeave.jsp">Apply Leave</a> <a href="myLeaves.jsp">My
				Leaves</a> <a href="holidays.jsp">Holidays</a>
			<%
			if ("HR".equals(role) || "Manager".equals(role)) {
			%>
			<a href="applyLeaveFor.jsp">Apply Leave For</a> <a
				href="leaveRequests.jsp">Leave Requests</a>
			<%
			}
			if ("HR".equals(role)) {
			%>
			<a href="assignLeave.jsp">Assign Leaves</a> <a
				href="employeeLeaves.jsp">Employees Leaves </a>
			<%
			}
			if ("Manager".equals(role)) {
			%>
			<a href="employeeLeaves.jsp">Reportees Leaves</a>
			<%
			}
			%>


		</div>

		<div class="table-container">
			<h2>Employees Leaves</h2>

			<hr>

			<div class="filter">
				<form action="filterLeaveBy" method="post">
					<div class="form-container">
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


					<div class="form-container">
						<label for="year">Year *</label> <input type="text" id="year"
							name="year" onkeyup="toggleMonthDropdown()"
							value="<%=request.getParameter("year") != null ? request.getParameter("year") : ""%>" required>
					</div>

					<div class="form-container">
						<label for="month">Month </label> <select id="month" name="month">
							<option value=""
								<%="".equals(request.getParameter("month")) ? "selected" : ""%>>Select
								Month</option>
							<option value="01"
								<%="01".equals(request.getParameter("month")) ? "selected" : ""%>>January</option>
							<option value="02"
								<%="02".equals(request.getParameter("month")) ? "selected" : ""%>>February</option>
							<option value="03"
								<%="03".equals(request.getParameter("month")) ? "selected" : ""%>>March</option>
							<option value="04"
								<%="04".equals(request.getParameter("month")) ? "selected" : ""%>>April</option>
							<option value="05"
								<%="05".equals(request.getParameter("month")) ? "selected" : ""%>>May</option>
							<option value="06"
								<%="06".equals(request.getParameter("month")) ? "selected" : ""%>>June</option>
							<option value="07"
								<%="07".equals(request.getParameter("month")) ? "selected" : ""%>>July</option>
							<option value="08"
								<%="08".equals(request.getParameter("month")) ? "selected" : ""%>>August</option>
							<option value="09"
								<%="09".equals(request.getParameter("month")) ? "selected" : ""%>>September</option>
							<option value="10"
								<%="10".equals(request.getParameter("month")) ? "selected" : ""%>>October</option>
							<option value="11"
								<%="11".equals(request.getParameter("month")) ? "selected" : ""%>>November</option>
							<option value="12"
								<%="12".equals(request.getParameter("month")) ? "selected" : ""%>>December</option>
						</select>
					</div>

					<div class="form-container">
						<button type="submit" class="apply-btn">Filter</button>
					</div>
				</form>
			</div>


			<table class="leave-table">
			<%if(leaves!=null) {%>
				<thead>
					<tr>
						<th>From Date</th>
						<th>To Date</th>
						<th>Total Days</th>
						<th>Leave Type</th>
						<th>Status</th>
						<th>Actions</th>
						<th></th>
					</tr>
				</thead>
				
				<tbody>
					<%

					for (Leaves lev : leaves) {
					%>
					<tr>
						<td><%=lev.getFromDate()%></td>
						<td><%=lev.getToDate()%></td>
						<td><%=lev.getTotalDays()%></td>
						<td><%=lev.getLeaveType()%></td>
						<td><%=lev.getLeaveStatus()%></td>
						<td>
							<%
							if ("Approved".equals(lev.getLeaveStatus())) {
							%> <a href="cancelLeave?id=<%=lev.getLeaveId()%>" class="cancel-btn">Cancel</a>
							<%
							}
							%>
						</td>
					<td>    
                    <div class="quick-launch-button" onclick="toggleDetails(<%= lev.getLeaveId() %>)">
                        <div class="quick-launch-icon">
                            <i class="fas fa-ellipsis-v"></i>
                        </div>
                    </div>
                </td>
                
            </tr>
            <tr class="leave-details-row" id="details-<%= lev.getLeaveId() %>" style="display: none;">
                <td colspan="7">
                    <!-- Additional details go here -->
                    
                    <p><b>Applied on:</b> <%= lev.getAppliedDate() %></p>
                    <%if(lev.getLeaveStatus().equals("Approved")) { %>
                   	<p><b>Approved by:</b> <%= lev.getApprovedByFname() +" "+ lev.getApprovedByLname()  %></p>
                   	<%} else if (lev.getLeaveStatus().equals("Rejected")) { %>
                   	<p><b>Rejected by:</b> <%= lev.getApprovedByFname() +" "+ lev.getApprovedByLname()  %></p>
                   	<p><b>Reject Reason:</b> <%= lev.getRejectReason() %></p>
                   	<%} %>

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
	</div>
	
	<script>
	
	//Displaying messages for different scenarios

	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% } 
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Success")){%> 
	showMessage('success', 'Approved Leave has been cancelled !!!');
	<%}%>}
	
	/*new js function to display messages*/
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

	function toggleDetails(leaveId) {
	    var detailsRow = document.getElementById('details-' + leaveId);
	    if (detailsRow.style.display === 'none' || detailsRow.style.display === '') {
	        detailsRow.style.display = 'table-row';
	    } else {
	        detailsRow.style.display = 'none';
	    }
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