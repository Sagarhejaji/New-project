<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Holidays"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.entities.EmployeeFullDetails"%>
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
<title>Profile</title>

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

/* Main form*/
.formContainer {
    display: flex;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-top: 6%;
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
            border: 1px solid #ddd;
            border-radius: 10px;
            box-sizing: border-box;
            background-color:#f0f0f0;
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
h5
{
margin-top:-5%;
}

</style>

<body>

	<%
        Connection con = DBConnect.getConnection();
        EmpDao empDao = new EmpDao(con);
        
        List<Holidays> holidays = empDao.getHolidays();
        List<Roles> JobTitle=empDao.getRoles();
        
        HttpSession sess = request.getSession();
        Employees emp = (Employees)sess.getAttribute("employee");
        String role = (String)sess.getAttribute("role");
        EmployeeFullDetails ea = null;
        
        if((EmployeeFullDetails)request.getAttribute("ea") != null){
        ea = (EmployeeFullDetails)request.getAttribute("ea");
        }else
        ea = empDao.getEmpFullDetails(emp.getEmpId());
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
			<h1>Profile</h1>
			<div class="user-profile">
				<div class="user-dropdown">
					<button class="dropbtn" id="userDropdown">
						<%= emp.getFname() + " " + emp.getLname()%>
						<i class="fas fa-caret-down"></i>
					</button>
					<div class="dropdown-content" id="userDropdownContent">
						<a href="changePassword.jsp">Change Password</a> <a
							href="logoutServlet">Logout</a>
					</div>
				</div>
			</div>
		</header>
		
		
		<form class="formContainer" action="updateEmployee" method="post">
		
    <div class="formMenu">
    <h2><%= ea.getEmployee().getFname() + " " + ea.getEmployee().getLname() %></h2>
    <h5><%= " ( "+ea.getEmployee().getEmpNo()+" ) "  %></h5>
        <ul>
            <li onclick="showDiv('PD')">Personal Details</li>
            <li onclick="showDiv('CD')">Contact Details</li>
            <li onclick="showDiv('J')">Employment Details</li>
           
            
            
        </ul>
        
        
        
    </div>
    
    <div class="formMain">
        <div class="content PD">
            <!-- Personal Details content -->
            <h2>Personal Details</h2>
            <hr>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="FirstName">First Name*</label>
                    <input type="text" id="FirstName" name="FirstName" value="<%= ea.getEmployee().getFname()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="LastName">Last Name*</label>
                    <input type="text" id="LastName" name="LastName" value="<%= ea.getEmployee().getLname()%>" disabled>
                </div>
            </div>
            
            
            
            <div class="form-row">
                <div class="form-group">
                    <label for="DateOfBirth">Date Of Birth*</label>
                    <input type="Date" id="DateOfBirth" name="DateOfBirth" value="<%= ea.getEmployee().getDateofBirth()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="Gender">Gender*</label>
                    <select id="Gender" name="Gender" disabled>
                    <option value="">Select Gender</option>
        <option value="Male" <%= "Male".equals(ea.getEmployee().getGender()) ? "selected" : "" %>>Male</option>
        <option value="Female" <%= "Female".equals(ea.getEmployee().getGender()) ? "selected" : "" %>>Female</option>
        <option value="Other" <%= "Other".equals(ea.getEmployee().getGender()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="Nationality">Nationality*</label>
					<input type="text" id="Nationality" name="Nationality" value="<%= ea.getEmployee().getNationality()%>" disabled>
				
                </div>
                <div class="form-group">
                    <label for="MaritalStatus">Marital Status*</label>
                    <select id="MaritalStatus" name="MaritalStatus" required disabled>
                    <option value="">Select Marital Status</option>
        <option value="Married" <%= "Married".equals(ea.getEmployee().getMaritalStatus()) ? "selected" : "" %>>Married</option>
        <option value="Single" <%= "Single".equals(ea.getEmployee().getMaritalStatus()) ? "selected" : "" %>>Single</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                
                <div class="form-group">
                    <label for="BloodGroup">Blood Group*</label>
                    <select id="BloodGroup" name="BloodGroup" required disabled>
                     <option value="">Select Blood Group</option>
    <option value="O -ve" <%= "O -ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>O -ve</option>
    <option value="O +ve" <%= "O +ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>O +ve</option>
    <option value="A -ve" <%= "A -ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>A -ve</option>
    <option value="A +ve" <%= "A +ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>A +ve</option>
    <option value="B -ve" <%= "B -ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>B -ve</option>
    <option value="B +ve" <%= "B +ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>B +ve</option>
    <option value="AB -ve" <%= "AB -ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>AB -ve</option>
    <option value="AB +ve" <%= "AB +ve".equals(ea.getEmployee().getBloodGroup()) ? "selected" : "" %>>AB +ve</option>
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
                    <input type="text" id="PermanentStreet1" name="PermanentStreet1" value="<%= ea.getAddress().getLine1()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="PermanentStreet2">Address Line 2</label>
                    <input type="text" id="PermanentStreet2" name="PermanentStreet2" value="<%= ea.getAddress().getLine2()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="PermanentCity">City*</label>
                    <input type="text" id="PermanentCity" name="PermanentCity" value="<%= ea.getAddress().getCity()%>" disabled>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="PermanentState">State*</label>
                    <input type="text" id="PermanentState" name="PermanentState" value="<%= ea.getAddress().getState()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="PermanentPostalCode">Postal Code*</label>
                    <input type="text" id="PermanentPostalCode" name="PermanentPostalCode" value="<%= ea.getAddress().getPostalCode()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="PermanentCity">Country*</label>
                    <input type="text" id="PermanentCountry" name="PermanentCountry" value="<%= ea.getAddress().getCountry()%>" disabled>
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
                    <input type="text" id="TemporaryStreet1" name="TemporaryStreet1" value="<%= ea.getAddress().getTempLine1()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="TemporaryStreet2">Address Line 2</label>
                    <input type="text" id="TemporaryStreet2" name="TemporaryStreet2" value="<%= ea.getAddress().getTempLine2()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="TemporaryCity">City</label>
                    <input type="text" id="TemporaryCity" name="TemporaryCity" value="<%= ea.getAddress().getTempCity()%>" disabled>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="TemporaryState">State</label>
                    <input type="text" id="TemporaryState" name="TemporaryState" value="<%= ea.getAddress().getTempState()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="TemporaryPostalCode">Postal Code</label>
                    <input type="text" id="TemporaryPostalCode" name="TemporaryPostalCode" value="<%= ea.getAddress().getTempPostalCode()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="TemporaryCity">Country</label>
                    <input type="text" id="TemporaryCountry" name="TemporaryCountry" value="<%= ea.getAddress().getTempCountry()%>" disabled>
                </div>
            </div>
            
            <hr>
            
            <h3>Contact Number</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="Mobile">Mobile*</label>
                    <input type="text" id="Mobile" name="Mobile" value="<%= ea.getEmployee().getPersonalMobile()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="Home">Home*</label>
                    <input type="text" id="Home" name="Home" value="<%= ea.getEmployee().getPersonalHome()%>" disabled>
                </div>
            </div>
            
            <h3>Emergency Contact</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="EmergencyName">Emergency Contact Name*</label>
                    <input type="text" id="EmergencyName" name="EmergencyName" value="<%= ea.getEmployee().getEmergencyName()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="Relation">Relation*</label>
                    <input type="text" id="Relation" name="Relation" value="<%= ea.getEmployee().getEmergencyRelatoin()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="EmergencyMobile">Mobile*</label>
                    <input type="text" id="EmergencyMobile" name="EmergencyMobile" value="<%= ea.getEmployee().getEmergencyMobile()%>" disabled>
                </div>
            </div>
            
            <hr> 
            
            <h3>Email</h3>
            <div class="form-row">
                <div class="form-group">
                    <label for="PersonalEmail">Personal Email*</label>
                    <input type="email" id="PersonalEmail" name="PersonalEmail" value="<%= ea.getEmployee().getPersonalEmail()%>" disabled>
                </div>
                <div class="form-group">
                    <label for="WorkEmail">Work Email*</label>
                    <input type="email" id="WorkEmail" name="WorkEmail" value="<%= ea.getEmployee().getWorkEmail()%>" disabled>
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
                    <input type="Date" id="JoinedDate" name="JoinedDate" value="<%= ea.getEmployee().getHireDate()%>" disabled>
                </div>
                <div class="form-group">     
                    <label for="JobTitle">Job Title*</label> 
                    <select id="JobTitle" name="JobTitle" disabled>
                             <option value="">Select Job Title</option>
            <% 
                int currentRoleId = ea.getEmployee().getRoleId(); 
                for (Roles r : JobTitle) { 
            %>
                <option value="<%= r.getRoleId() %>" <%= r.getRoleId() == currentRoleId ? "selected" : "" %>><%= r.getRoleName() %></option>
            <% 
                } 
            %>
                        </select>
                        
                </div>
            </div>
            <div class=form-row>
            <div class="form-group">
            <label for="Location">Location</label>
            <input type="text" id="Location" name="Location" value="<%= ea.getEmployee().getJobLocation()%>" disabled>
            </div>
            <div class="form-group">
				
            </div>
            </div>
            
        </div>
        
        
        
        

    </div>
    </form>
</div>

	
	
	
	
	<script>
	
	document.addEventListener("DOMContentLoaded", function() {
	    var currentPage = window.location.pathname.split("/").pop();
	    
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
		}else if (currentPage === "EmployeeFilter" || currentPage === "deleteEmployee" || currentPage === "updateEmployee" || currentPage === "viewEmployee" ) {
		    targetPage = "employees.jsp";
		    document.querySelector(".activePeople").classList.add("active");
		} else{
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
	    	        temporaryField.disabled = true;
	    	      } else {
	    	        temporaryField.value = '';
	    	        temporaryField.disabled = false;
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
		%>}
	    
	    
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