<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Holidays"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.entities.Roles"%>
<%@ page import="com.emp.entities.Manager"%>
<%@ page import="com.emp.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.emp.dao.EmpDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>People</title>

<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="show.css">
<script src="script.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link rel="stylesheet"
	href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
<script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
</head>
<style>

body.sidebar-collapsed .peopleLinks {
    left: 3%;
}
.peopleLinks {
	display: flex;
	background-color: white;
	padding: 1% 2%;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	margin-top:4.2%;
	position: fixed;
    top: 10px;
    right: 0;
    left: 15%;
    transition: left 0.3s ease;
    z-index: 999;
    flex-direction:row;
    justify-content:start;
}

.peopleLinks a {
	color: #6c757d;
	text-decoration: none;
	padding: 1% 1%;
	font-size:85%;
	transition: all 0.3s ease;
	
	margin-left:3%;
	border-radius: 10px;
	background-color: #f5f5f5;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.peopleLinks a:hover, .peopleLinks a:focus {
	color: #ff8c00;
	background-color: #fff9f0;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transform: translateY(-2px);
}
.sidebar-menu li.active {
    background: linear-gradient(to left,#FF9671 ,#FFC75F );
    border-radius:0 50px 50px 0;
    width:70%;
}

/*  table css =======================================*/

.ReportTo-container {
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 20px;
  max-width: 100%;
  
  margin-top: 12%;

  margin-left:20px;
  margin-bottom:10px;
  transition: width 0.3s ease, margin-left 0.3s ease;
}

.table-container {
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 20px;
  max-width: 100%;
  

  margin-left:20px;
  margin-bottom:10px;
  transition: width 0.3s ease, margin-left 0.3s ease;
}

.Reporting-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 15px;
}

.Reporting-table th {
	text-align: left;
	padding: 10px 15px;
	color: black;
	font-weight: normal;
	border-bottom: 1px solid #e0e0e0;
	background-color: #c0c0c0;
	font-weight: bold;
}

.Reporting-table td {
	padding: 15px;
	background-color: #f5f5f5;
}

.Reporting-table tbody tr {
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
	border-radius: 20px;
}

.Reporting-table tbody tr td:first-child {
	border-top-left-radius: 20px;
	border-bottom-left-radius: 20px;
}

.Reporting-table tbody tr td:last-child {
	border-top-right-radius: 20px;
	border-bottom-right-radius: 20px;
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

.form-container label {
	white-space: nowrap;
}

.form-container input[type="text"],select {
	width: 40%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
}

.formButton{
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

.edit-btn i {
  font-size:25px;
  color: #ffcc80;
  cursor: pointer;
  font-weight: bold;
  border:1px solid white;
  border-radius:10px;
  padding:5px;
  left:50%;
}
.delete-btn i{
 font-size:27px;
  color: #ff8a65;
  cursor: pointer;
  font-weight: bold;
  border:1px solid white;
  border-radius:10px;
  padding:5px;
}

.view-btn i{
 font-size:27px;
  color: #ff8a65;
  cursor: pointer;
  font-weight: bold;
  border:1px solid white;
  border-radius:10px;
  padding:5px;
}

.edit-btn i:hover, .delete-btn i:hover, .view-btn i:hover
{
background-color:white;
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

.actions-column {
    text-align: right;
}

.actions-cell {
    text-align: right;
}

.actions-cell a {
    display: inline-block;
    margin-left: 10px; /* Adjust spacing between icons */
}

.form-row {
            display: flex;
            margin-bottom: 3%;
        }
        .form-group {
            flex: 1;
            margin-right: 5%;
        }
        .form-group:last-child {
            margin-right: 0;
        }
        label {
            display: block;
            margin-bottom: 2%;
            color: #666;
        }
        input[type="text"], input[type="email"],input[type="Date"],input[type="password"], select {
            width: 100%;
            padding: 8px;
            border: 1.5px solid #ddd;
            border-radius: 10px;
            box-sizing: border-box;
        }

.button-container {
    margin-top: 20px;
}

.apply-btn {
    width: 100%;
    background-color: #8bc34a;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s;
}

.actions-column {
    text-align: right;
}

.actions-cell {
    text-align: right;
}

.actions-cell button {
    display: inline-block;
    margin-left: 10px; /* Adjust spacing between icons */
}

</style>

<body>

	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
        
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
        
        List<Employees> managers=empDao.getAllManagers();
        List<Employees> employees=empDao.getReportingEmployees();
        List<Manager> reportee = (List<Manager>) request.getAttribute("filteredreportee");
        
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
			<h1>People / Report-To</h1>
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
		<div class="peopleLinks">
			 
			<% if(role.equals("Manager")) { %>
			<a href="employees.jsp">Reportees</a>
			<%}else{%>
			<a href="employees.jsp">Employees</a>
			<a href="addEmployee.jsp">Add Employee</a>
			<a href="reportTo.jsp">Report-To</a>
			<%} %>
		</div>
		
		
		
		<div class="ReportTo-container">
		
		<h2>Report-To</h2>
		<hr>
		
		
		<form class="form-row" action="addReportee" method="post">
                <div class="form-group">     
                    <label for="employees">Employee Name*</label> 
                    <select id="employees" name="employees">
                            <option value="">Select Employee</option>
                            <% for (Employees e : employees) { %>
                            <option value="<%= e.getEmpId() %>"><%= e.getFname() +" "+ e.getLname() %></option>
                            <% } %>
                        </select>
                        
                </div>
                <div class="form-group">     
                    <label for="Manager">Report-To (Managers)*</label> 
                    <select id="Manager" name="Manager">
                            <option value="">Select Manager</option>
                            <% for (Employees e : managers) { %>
                            <option value="<%= e.getEmpId() %>"><%= e.getFname() +" "+ e.getLname() %></option>
                            <% } %>
                        </select>
                        
                </div>
                <div class="button-container">
        			<button type="submit" class="apply-btn" id="saveButton">Save</button>
        		</div>
        		</form>
            </div>
		
		
		<div class="table-container">
		
		<h2>Reporting Employees</h2>
		<hr>
		
		<form class="form-row" action="filterReportee" method="post">
		<div class="form-group">     
                    <label for="filterManager">Managers*</label> 
                    <select id="filterManager" name="filterManager">
                            <option value="">Select Manager</option>
                            <% for (Employees e : managers) { %>
                            <option value="<%= e.getEmpId() %>"><%= e.getFname() +" "+ e.getLname() %></option>
                            <% } %>
                        </select>
                        
                </div>
         <div class="form-group">
         
         </div>
         <div class="button-container">
        			<button type="submit" class="apply-btn" id="filterButton">Filter</button>
        		</div>
         </form>
         
		<table class="Reporting-table">
		<thead>
		<tr>
		<th> Reportee Name</th>
		<th class="actions-column"> Action</th>
		</tr>
		</thead>
		<% if(reportee!=null){ %>
		<tbody>
		<% for (Manager m : reportee) { %>
		<tr>
		<td> <%= m.getFullName() %></td>
		<td class="actions-cell">
		<form action="removeReportee" method="post">
		<input type="hidden" id="removeId" name="removeId" value= <%=m.getMgrID() %>>
		<div class="">
        	<button type="submit" class="apply-btn" id="removeButton">Remove</button>
        </div>
		</form>
		</td>
		</tr>
		<% } }%>
		</tbody>
		
		</table>
		

	</div>
	
	<script>
	
	//to highlight the active tabs(anchor tag links) 

	document.addEventListener("DOMContentLoaded", function() {
		    var currentPage = window.location.pathname.split("/").pop();
		    var targetPage = "employees.jsp";
		    
		    var leavePages = ["applyLeave.jsp","applyLeaveFor.jsp","assignLeave.jsp","employeeLeaves.jsp","holidays.jsp","leaveRequests.jsp","myLeaves.jsp"];
		    var timePages = ["attendance.jsp", "attendanceRequest.jsp"];
			var peoplePages = ["employees.jsp","addEmployee.jsp","reportTo.jsp"];
			var profilePage = ["profile.jsp"];
		    
		    if (leavePages.includes(currentPage)) {
		        document.querySelector(".activeLeave").classList.add("active");
		    } else if (timePages.includes(currentPage)) {
		        document.querySelector(".activeAttendance").classList.add("active");
		    } else if (peoplePages.includes(currentPage)) {
			    document.querySelector(".activePeople").classList.add("active");
			} else if (profilePage.includes(currentPage)) {
			    document.querySelector(".activeProfile").classList.add("active");
			}else if (currentPage === "EmployeeFilter" || currentPage === "deleteEmployee" || currentPage === "updateEmployee" || currentPage === "AddEmployee") {
			    targetPage = "employees.jsp";
			    document.querySelector(".activePeople").classList.add("active");
			}
		    else{
				document.querySelector(".activeDashboard").classList.add("active");
		    }
		});
	
	
	//Displaying messages for different scenarios

	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% }
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("empInserted")){%> 
	showMessage('success', 'New Employee Inserted !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error2")){%> 
	showMessage('error', 'Employee not added - Ensure the details entered are correct !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error3")){%> 
	showMessage('error', 'Username Already exists !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("empUpdated")){%> 
	showMessage('success', 'Employee Updated !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("empDeleted")){%> 
	showMessage('error', 'Employee Deleted !!!');
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