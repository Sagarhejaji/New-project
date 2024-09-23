<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Leaves"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.emp.dao.EmpDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Leave Request</title>

<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="show.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<script src="script.js"></script>

</head>
<style>

/*form-container css starts*/
h2 {
	color: #333;
	margin-bottom: 2%;
}

.apply-btn {
	background-color: #8bc34a;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 1em;
}

.apply-btn:hover {
	background-color: #7cb342;
}

/*form container css ends*/

/* table css starts*/
.table-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	max-width: 100%;
	margin-top: 12%;
	margin-left: 3%;
	transition: width 0.3s ease, margin-left 0.3s ease;
}

.leave-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 10px;
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
	border-top-left-radius: 2%;
	border-bottom-left-radius: 2%;
}

.leave-table tbody tr td:last-child {
	border-top-right-radius: 2%;
	border-bottom-right-radius: 2%;
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

.filter {
	align-items: center;
	margin: 1%;
	padding: 1%;
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
	margin-right: 3%;
	gap: 1%;
}

.filter label {
	white-space: nowrap;
}

.filter input[type="text"], .filter select {
	width: 12%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
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

.form-button {
	margin-left: 50%;
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
.strikethrough {
	text-decoration: line-through;
	color: black;
}
.popup {
	display: none;
	position: fixed;
	z-index: 9;
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
.popup-content {
    margin: auto;
    padding: 20px;
    width: 80%;
    max-width: 700px;
    text-align: center;
}

.close-bttn {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close-bttn:hover,
.close-bttn:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

h2 {
    margin-top: 0;
    color: #333;
}

form {
    display: flex;
    flex-direction: column;
    align-items: center;
}

textarea {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    resize: none;
    font-size: 16px;
    margin-bottom: 20px;
}

.sub {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.sub:hover {
    background-color: #45a049;
}

.leave-table button {
	padding: 10px 20px;
	background-color: #FF0000;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
	width: 75%;
	margin-left:13%;
}

button:hover {
	background-color: #8B0000;
}

.app {
	background-color: #8bc34a;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
	width: 75%;
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


<script>

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
		}else if (currentPage === "filterLeave" || currentPage === "filterLeaveBy" || currentPage ==="updaterejectreason") {
		    targetPage = "myLeaves.jsp";
		    document.querySelector(".activeLeave").classList.add("active");
		}
	    else{
			document.querySelector(".activeDashboard").classList.add("active");
	    }
	});


//to enable month input field after selecting year
function toggleMonthDropdown() {
    var yearInput = document.getElementById('year');
    var monthDropdown = document.getElementById('month');
    monthDropdown.disabled = yearInput.value.trim() === "";
}
window.onload = function() {
    toggleMonthDropdown(); // Initial check
}


function openPopup(leaveid) {
    document.getElementById("popupLeaveId").value = leaveid;
    document.getElementById("myPopup").style.display = "block";
}

function closePopup() {
    document.getElementById("myPopup").style.display = "none";
}

</script>

<body>

	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
       
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
        
        List<Leaves> list=null;
        if(sess.getAttribute("role").equals("HR"))
        {
         list = empDao.getPendingLeaves();
        }else if(sess.getAttribute("role").equals("Manager"))
        {
        list = empDao.getMgrPendingLeaves(emp.getEmpId());
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
			<h1>Leave / Leave Requests</h1>
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

		<div class="leaveLinks">
			<a href="applyLeave.jsp">Apply Leave</a> <a href="myLeaves.jsp">My
				Leaves</a> <a href="holidays.jsp">Holidays</a>
			<%if("HR".equals(role) || "Manager".equals(role)){ %>
			<a href="applyLeaveFor.jsp">Apply Leave For</a> <a
				href="leaveRequests.jsp">Leave Requests</a>
			<%} if("HR".equals(role)) {%>
			<a href="assignLeave.jsp">Assign Leaves</a> <a
				href="employeeLeaves.jsp">Employees Leaves </a>
			<%}  if("Manager".equals(role)) {%>
			<a href="employeeLeaves.jsp">Reportees Leaves</a>
			<%}%>


		</div>

		<div class="table-container">
			<h2>Leave Requests</h2>

			<hr>


			<table class="leave-table">
				<thead>
					<tr>
						<th>Full Name</th>
						<th>From Date</th>
						<th>To Date</th>
						<th>Total Days</th>
						<th>Leave Type</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<% 
        
        for (Leaves lev : list) { %>
					<tr>
						<td><%= lev.getFname()+" "+lev.getLname() %></td>
						<td><%= lev.getFromDate() %></td>
						<td><%= lev.getToDate() %></td>
						<td><%= lev.getTotalDays() %></td>
						<td><%= lev.getLeaveType() %></td>
						<td><%= lev.getLeaveStatus() %></td>
						<td>
							<form action="updaterejectreason" method="post">
								<input type="hidden" name="eid" value="<%= emp.getEmpId() %>">
								<input type="hidden" name="leaveid" id="leaveid"
									value="<%= lev.getLeaveId() %>"> <input type="submit"
									value="Approve" class="app">
							</form>
							<br>
							<button onclick="openPopup(<%= lev.getLeaveId() %>)">Reject</button>
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>

			<div id="myPopup" class="popup">
				<div class="popup-content">
					<span class="close-bttn" onclick="closePopup()">&times;</span>
					<h2>Reject Reason</h2>
					<form action="updaterejectreason" method="post">
						<textarea rows="5" name="rejectreason" required></textarea>
						<input type="hidden" name="eid" value="<%= emp.getEmpId() %>">
						<input type="hidden" name="leaveid" id="popupLeaveId"> <input
							type="submit" value="Reject" class="sub">
					</form>
				</div>
			</div>



		</div>
	</div>


<script>


//Displaying messages for different scenarios

	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% } 
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Success")){%> 
	showMessage('success', 'Leave Updated...');
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