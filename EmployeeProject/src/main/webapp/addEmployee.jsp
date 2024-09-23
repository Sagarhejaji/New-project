<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Holidays"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.entities.Roles"%>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

/* Main form*/
.formContainer {
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

.formContainer {
    display: flex;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-top: 12%;
    margin-left: 20px;
    margin-bottom: 10px;
    transition: width 0.3s ease, margin-left 0.3s ease;
}

.formMenu {
    width: 200px;
    padding: 20px;
    border-right: 1px solid #e0e0e0;
    display: flex;
    flex-direction: column;
    
}

.formMenu ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.formMenu li {
    padding: 10px 15px;
    cursor: pointer;
    transition: background-color 0.3s;
    border-radius: 5px;
}

.formMenu li:hover {
    background-color: #f5f5f5;
}

.formMenu li.active {
    background-color: #e6f7ff;
    color: #1890ff;
}

.formMain {
    flex-grow: 1;
    padding: 20px;
}

.content {
    display: none;
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
   
  .form-row.checkbox-row {
    align-items: center;
}

.checkbox-label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.checkbox-label input[type="checkbox"] {
    margin-right: 8px;
    width: 18px;
    height: 18px;
}

.checkbox-label span {
    font-size: 16px;
    line-height: 18px;
}
		input:disabled {
  background-color: #f0f0f0;
  cursor: not-allowed;
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


.popup2 {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	border:1px solid red;
}
.popup-content {
	background-color: white;
	margin: 15% auto;
	padding: 30px;
	border: 1px solid #888;
	width: 300px;
	position: relative;
	border-radius: 10px;
}

.close-btn {
	position: absolute;
	top: 2px;
	right: 2px;
	color: #aaa;
	font-size: 30px;
	font-weight: bold;
	cursor: pointer;
}

.popup-form-group {
	margin-bottom: 15px;
}

.popup-form-group label {
	display: block;
	margin-bottom: 5px;
}

.popup-form-group input {
	width: 100%;
	padding: 8px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.popup-content button {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 15px;
	cursor: pointer;
	border-radius: 5px;
}

.popup-content button:hover {
	background-color: #0056b3;
}

.add-role-icon {
	margin-left: 10px;
	color: #007bff;
	cursor: pointer;
	font-weight: bold; /* Bold font */
	font-size: 1.2em; /* Increase size */
}
.popup-content .add-btn{
background-color:#8bc34a;
padding:5px;
margin-left:25%;
width:50%;
border:1px solid #f0f0f0;
border-radius:10px;
font-weight:500;

}
.popup-content .add-btn:hover{
background-color: #7cb342;
}



</style>

<script>

document.addEventListener("DOMContentLoaded", function() {
	flatpickr("#DateOfBirth", {
        dateFormat: "Y-m-d",
        maxDate: "today", // Restricts future dates
    });

    flatpickr("#JoinedDate", {
        dateFormat: "Y-m-d",
        maxDate: "today", // Restricts future dates
    });
});



function openPopup() {
    document.getElementById("rolePopup").style.display = "block";
}

function closePopup() {
    document.getElementById("rolePopup").style.display = "none";
}

</script>

<body>

	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
        
        List<Holidays> holidays = empDao.getHolidays();
        List<Roles> JobTitle=empDao.getRoles();
        
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
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
			<h1>People / Add Employee</h1>
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
		
		
		<form class="formContainer" action="AddEmployee" method="post" onsubmit="return validatePasswords() && validateForm()">
		
    <div class="formMenu">
    <h2>Add Employee</h2>
        <ul>
            <li onclick="showDiv('PD')">Personal Details</li>
            <li onclick="showDiv('CD')">Contact Details</li>
            <li onclick="showDiv('J')">Employment Details</li>
            <li onclick="showDiv('UC')">User Credentials</li>
            
        </ul>
        <div class="button-container">
 
        <button type="submit" class="apply-btn" id="saveButton" style="display: none;">Save</button>

        </div>
        
    </div>
    
    <div class="formMain">
        <div class="content PD">
            <!-- Personal Details content -->
            <h2>Personal Details</h2>
            <hr>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="FirstName">First Name*</label>
                    <input type="text" id="FirstName" name="FirstName" required>
                </div>
                <div class="form-group">
                    <label for="LastName">Last Name*</label>
                    <input type="text" id="LastName" name="LastName" required>
                </div>
            </div>
            
            
            
            <div class="form-row">
                <div class="form-group">
                    <label for="DateOfBirth">Date Of Birth*</label>
                    <input type="Date" id="DateOfBirth" name="DateOfBirth" required>
                </div>
                <div class="form-group">
                    <label for="Gender">Gender*</label>
                    <select id="Gender" name="Gender" required>
                    <option value="">Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="Nationality">Nationality*</label>
					<input type="text" id="Nationality" name="Nationality" required>
				
                </div>
                <div class="form-group">
                    <label for="MaritalStatus">Marital Status*</label>
                    <select id="MaritalStatus" name="MaritalStatus" required>
                    <option value="">Select Marital Status</option>
                    <option value="Married">Married</option>
                    <option value="Single">Single</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                
                <div class="form-group">
                    <label for="BloodGroup">Blood Group*</label>
                    <select id="BloodGroup" name="BloodGroup" required>
                    <option value="">Select Blood Group</option>
                    <option value="O -ve">O -ve</option>
                    <option value="O +ve">O +ve</option>
                    <option value="A -ve">A -ve</option>
                    <option value="A +ve">A +ve</option>
                    <option value="B -ve">B -ve</option>
                    <option value="B +ve">B +ve</option>
                    <option value="AB -ve">AB -ve</option>
                    <option value="AB +ve">AB +ve</option>
                    </select>
                </div>
                <div class="form-group">

                </div>
            </div>
            
            
        </div>
        <div class="content CD">
            <!-- Contact Details content -->
            <h2>Contact Details</h2>
            <hr>
            <h3>Permanent Address</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="PermanentStreet1">Address Line 1*</label>
                    <input type="text" id="PermanentStreet1" name="PermanentStreet1" required>
                </div>
                <div class="form-group">
                    <label for="PermanentStreet2">Address Line 2</label>
                    <input type="text" id="PermanentStreet2" name="PermanentStreet2">
                </div>
                <div class="form-group">
                    <label for="PermanentCity">City*</label>
                    <input type="text" id="PermanentCity" name="PermanentCity" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="PermanentState">State*</label>
                    <input type="text" id="PermanentState" name="PermanentState" required>
                </div>
                <div class="form-group">
                    <label for="PermanentPostalCode">Postal Code*</label>
                    <input type="text" id="PermanentPostalCode" name="PermanentPostalCode" required>
                </div>
                <div class="form-group">
                    <label for="PermanentCity">Country*</label>
                    <input type="text" id="PermanentCountry" name="PermanentCountry" required>
                </div>
            </div>
            
            <h3>Temporary Address</h3>
<div class="form-row checkbox-row">
    <label for="sameAsPermanent" class="checkbox-label">
    <span>Same as Permanent Address</span>
        <input type="checkbox" id="sameAsPermanent" name="sameAsPermanent">
        
    </label>
</div>
            
  
            <div class="form-row">
            	
                <div class="form-group">
                    <label for="TemporaryStreet1">Address Line 1</label>
                    <input type="text" id="TemporaryStreet1" name="TemporaryStreet1">
                </div>
                <div class="form-group">
                    <label for="TemporaryStreet2">Address Line 2</label>
                    <input type="text" id="TemporaryStreet2" name="TemporaryStreet2">
                </div>
                <div class="form-group">
                    <label for="TemporaryCity">City</label>
                    <input type="text" id="TemporaryCity" name="TemporaryCity">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="TemporaryState">State</label>
                    <input type="text" id="TemporaryState" name="TemporaryState">
                </div>
                <div class="form-group">
                    <label for="TemporaryPostalCode">Postal Code</label>
                    <input type="text" id="TemporaryPostalCode" name="TemporaryPostalCode">
                </div>
                <div class="form-group">
                    <label for="TemporaryCity">Country</label>
                    <input type="text" id="TemporaryCountry" name="TemporaryCountry">
                </div>
            </div>
            
            <hr>
            
            <h3>Contact Number</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="Mobile">Mobile*</label>
                    <input type="text" id="Mobile" name="Mobile" required>
                </div>
                <div class="form-group">
                    <label for="Home">Home</label>
                    <input type="text" id="Home" name="Home">
                </div>
            </div>
            
            <h3>Emergency Contact</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="EmergencyName">Emergency Contact Name*</label>
                    <input type="text" id="EmergencyName" name="EmergencyName" required>
                </div>
                <div class="form-group">
                    <label for="Relation">Relation*</label>
                    <input type="text" id="Relation" name="Relation" required>
                </div>
                <div class="form-group">
                    <label for="EmergencyMobile">Mobile*</label>
                    <input type="text" id="EmergencyMobile" name="EmergencyMobile" required>
                </div>
            </div>
            
            <hr> 
            
            <h3>Email</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="PersonalEmail">Personal Email*</label>
                    <input type="text" id="PersonalEmail" name="PersonalEmail" required >
                </div>
                <div class="form-group">
                    <label for="WorkEmail">Work Email*</label>
                    <input type="text" id="WorkEmail" name="WorkEmail" required >
                </div>
            </div>
            
        </div>
        <div class="content J">
            <!-- Job content -->
            <h2>Employment Detail</h2>
            <hr>
            <div class="form-row">
                <div class="form-group">
                    <label for="JoinedDate">Joined Date*</label>
                    <input type="Date" id="JoinedDate" name="JoinedDate" required>
                </div>
                <div class="form-group">     
                   <label for="JobTitle">Job Title</label>  
        <select id="JobTitle" name="JobTitle">
            <option value="">Select Job Title</option>
            <% for (Roles r : JobTitle) { %>
                <option value="<%= r.getRoleId() %>"><%= r.getRoleName() %></option>
            <% } %>
        </select>
                        
                </div>
                <div class="form-group">
                <label for="role">Add Role <i class="fas fa-plus add-role-icon" onclick="openPopup()"></i></label>
                </div>
            </div>
            <div class=form-row>
            <div class="form-group">
            <label for="Location">Location</label>
            <input type="text" id="Location" name="Location">
            </div>
            <div class="form-group">
				<label for="Location">Employee ID:</label>
            <input type="text" id="empno" name="empno" required>
            </div>
            </div>
            
        </div>
        
        <div class="content UC">
            
            <h2>User Credentials</h2>
            <hr>
            <div class="form-row">
                <div class="form-group">
                    <label for="Username">Username*</label>
                    <input type="text" id="Username" name="Username" required>
                </div>
                <div class="form-group">
                
                </div>
            </div>
            <div class="form-row">
            
            <div class="form-group">
                    <label for="Password">Password*</label>
                    <input type="password" id="Password" name="Password" required>
                </div>
                <div class="form-group">
                    <label for="ConfirmPassword">Confirm Password*</label>
                    <input type="password" id="ConfirmPassword" name="ConfirmPassword" required>
                </div>
            </div>
                            
        </div>

    </div>
    </form>
    
    
    <div id="rolePopup" class="popup2">
			<div class="popup-content">
				<form action="AddRoleServlet" method="post">
					<span class="close-btn" onclick="closePopup()">&times;</span>
					
					<div class="popup-form-group">
						<label for="newRole">Role Name*</label> <input type="text"
							id="newRole" name="newRole">
					</div>
				<input type="submit" value="Add" class="add-btn">
				</form>
			</div>
		</div>
		

</div>

	
	
	
	
	<script>
	
	document.addEventListener('DOMContentLoaded', function() {
		  const saveButton = document.getElementById('saveButton');
		  const requiredInputs = document.querySelectorAll('input[required], select[required]');
		  
		  function checkInputs() {
		    let allFilled = true;
		    requiredInputs.forEach(input => {
		      if (!input.value.trim()) {
		        allFilled = false;
		      }
		    });
		    saveButton.style.display = allFilled ? 'block' : 'none';
		  }

		  requiredInputs.forEach(input => {
		    input.addEventListener('input', checkInputs);
		    input.addEventListener('change', checkInputs);
		  });

		  // Initial check
		  checkInputs();
		});
	
	//to highlight the active tabs(anchor tag links) 

	document.addEventListener("DOMContentLoaded", function() {
		    var currentPage = window.location.pathname.split("/").pop();
		    var targetPage = "employees.jsp";
		    
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
			}else if (currentPage === "EmployeeFilter" || currentPage === "deleteEmployee" || currentPage === "updateEmployee" || currentPage === "AddEmployee") {
			    targetPage = "employees.jsp";
			    document.querySelector(".activePeople").classList.add("active");
			}
		    else{
				document.querySelector(".activeDashboard").classList.add("active");
		    }
		});
	
	
	function showDiv(divClass) {
	      const allDivs = document.querySelectorAll('.content');
	      allDivs.forEach(div => div.style.display = 'none');
	      
	      const selectedDiv = document.querySelector(`.${divClass}`);
	      if (selectedDiv) {
	        selectedDiv.style.display = 'block';
	      }
	    }

	    // Initial state: Show AAA content
	    document.addEventListener('DOMContentLoaded', () => {
	      showDiv('PD');
	    });

	    
	    document.addEventListener('DOMContentLoaded', function() {
	        const sameAsPermanentCheckbox = document.getElementById('sameAsPermanent');
	        const permanentFields = ['Street1', 'Street2', 'City', 'State', 'PostalCode', 'Country'];

	        sameAsPermanentCheckbox.addEventListener('change', function() {
	            permanentFields.forEach(field => {
	                const permanentField = document.getElementById('Permanent' + field);
	                const temporaryField = document.getElementById('Temporary' + field);
	                
	                if (this.checked) {
	                    temporaryField.value = permanentField.value;
	                    temporaryField.readOnly = true; // Change this from disabled to readOnly
	                } else {
	                    temporaryField.value = '';
	                    temporaryField.readOnly = false; // Change this from disabled to readOnly
	                }
	            });
	        });

	        // Add this part to update temporary fields when permanent fields change
	        permanentFields.forEach(field => {
	            const permanentField = document.getElementById('Permanent' + field);
	            permanentField.addEventListener('input', function() {
	                if (sameAsPermanentCheckbox.checked) {
	                    const temporaryField = document.getElementById('Temporary' + field);
	                    temporaryField.value = this.value;
	                }
	            });
	        });
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
		showMessage('error', 'Employee not added - enter unique empno !!!');
		<%}
		else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error3")){%> 
		showMessage('error', 'Username Already exists !!!');
		<%}
		else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("empUpdated")){%> 
		showMessage('success', 'Employee Updated !!!');
		<%}
		else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("roleAdded")){%> 
		showMessage('success', 'Role Added !!!');
		<%}
		else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("DuplicateName")){%> 
		showMessage('error', 'Duplicate role name !!!');
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


		// function to restrict numbers and special chars
		
		$(document).ready(function() {
            function restrictToAlphabets(event) {
                var key = event.which || event.keyCode;
                if (!((key >= 65 && key <= 90) || (key >= 97 && key <= 122) || key === 8 || key === 32)) {
                    event.preventDefault();
                    alert("Only alphabets are allowed..!");
                }
            }
            
            function restrictToIntegers(event) {
                var key = event.which || event.keyCode;
                if (!(key >= 48 && key <= 57) && key !== 8) { // 48-57 are the ASCII codes for digits 0-9, 8 is for backspace
                    event.preventDefault();
                    alert("Only integer values are allowed.");
                }
            }
            
            function validateMobileLength() {  // to check the length of the mobile number
                var mobile = $("#Mobile").val();
                if (mobile.length == 10) {
                    alert("Mobile number must be exactly 10 digits.");
                    return false;
                }
                return true;
            }
            function validateMobileLength1() {  // to check the length of the mobile number
                var mobile1 = $("#EmergencyMobile").val();
                if (mobile1.length == 10) {
                    alert("Mobile number must be exactly 10 digits.");
                    return false;
                }
                return true;
            }

            $("#FirstName").on('keypress', restrictToAlphabets);
            $("#LastName").on('keypress', restrictToAlphabets);
            $("#Nationality").on('keypress', restrictToAlphabets);
            $("#PermanentCity").on('keypress', restrictToAlphabets);
            $("#PermanentState").on('keypress', restrictToAlphabets);
            $("#PermanentCountry").on('keypress', restrictToAlphabets);
            $("#Relation").on('keypress', restrictToAlphabets);
            $("#Location").on('keypress', restrictToAlphabets);
            $("#EmergencyName").on('keypress', restrictToAlphabets);
            $("#Username").on('keypress', restrictToAlphabets);
            
            $("#PermanentPostalCode").on('keypress', restrictToIntegers);
            $("#Mobile").on('keypress', restrictToIntegers);
            $("#Mobile").on('keypress', validateMobileLength);
            
            $("#EmergencyMobile").on('keypress', restrictToIntegers);
            $("#EmergencyMobile").on('keypress', validateMobileLength1);
        });
		
		// function to validate password and confirm password
		
		function validatePasswords() {
            var password = document.getElementById("Password").value;
            var confirmPassword = document.getElementById("ConfirmPassword").value;

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }
            return true;
        }
		
		
		// function to validate email pattern
		
		function validateEmail(email) {
            // Regular expression pattern for email validation
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return emailPattern.test(email);
        }

        function validateForm() {
            var personalEmail = document.getElementById("PersonalEmail").value;
            var workEmail = document.getElementById("WorkEmail").value;

            if (!validateEmail(personalEmail)) {
                alert("Please enter a valid Personal Email.");
                return false;
            }

            if (!validateEmail(workEmail)) {
                alert("Please enter a valid Work Email.");
                return false;
            }

            return true;
        }
			
			
		</script>
		<div id="message-container" class="message-container">
		    <span id="message-icon"></span>
		    <p id="message-text"></p>
		</div>

</body>
</html>