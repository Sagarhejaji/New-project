<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emp.entities.Attendance"%>
<%@ page import="com.emp.entities.Employees"%>
<%@ page import="com.emp.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.emp.dao.EmpDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="script.js" defer></script>
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="show.css">
</head>
<style>

.form-container {
    background-color: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 94%;
    margin-top:6%;
    margin-left:1%;
}

h2 {
    margin-top: 0;
    margin-bottom: 20px;
    color: #333;
}

.form-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.form-group {
    flex: 0 0 48%;
}

label {
    display: block;
    margin-bottom: 5px;
    color: #666;
}

input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

.password-hint {
    font-size: 12px;
    color: #666;
    margin-bottom: 20px;
}

.form-actions {
    display: flex;
    justify-content: flex-end;
}

button {
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
}

.btn-cancel {
    background-color: #f0f0f0;
    color: #333;
    margin-right: 10px;
}

.btn-save {
    background-color: #8bc34a;
    color: white;
}

@media (max-width: 600px) {
    .form-container {
        padding: 20px;
    }
    
    .form-row {
        flex-direction: column;
    }
    
    .form-group {
        flex: 0 0 100%;
        margin-bottom: 20px;
    }
}
a {
    text-decoration: none;
    color:black;
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
        String uname = (String)sess.getAttribute("username");
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
        <i class="fas fa-chevron-left show"></i>
        <i class="fas fa-chevron-right"></i>
    </button>
    
    <div class="main-content">
        <header class="header">
            <h1>Change Password</h1>
            <div class="user-profile">
                <div class="user-dropdown">
                    <button class="dropbtn" id="userDropdown">
                        <%= emp.getFname() + " " + emp.getLname() %>
                        <i class="fas fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content" id="userDropdownContent">
                        <a href="changePassword.jsp">Change Password</a>
                        <a href="login.jsp">Logout</a>
                    </div>
                </div>
            </div>
        </header>
        
        <div class="dashboard-grid">
        
        <div class="form-container">
        <h2>Update Password</h2>
        <form action="changePassword" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="<%= uname %>" readonly>
                </div>
                <div class="form-group">
                    <label for="current-password">Current Password*</label>
                    <input type="password" id="current-password" name="currentPassword" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="new-password">Password*</label>
                    <input type="password" id="new-password" name="newPassword" required>
                </div>
                <div class="form-group">
                    <label for="confirm-password">Confirm Password*</label>
                    <input type="password" id="confirm-password" name="confirmPassword" required>
                </div>
            </div>
            <p class="password-hint">For a strong password, please use a hard to guess combination of text with upper and lower case characters, symbols and numbers</p>
            <div class="form-actions">
                <button type="button" onclick="redirectToDash()" class="btn-cancel">Cancel</button>
                <button type="submit" class="btn-save">Save</button>
            </div>
        </form>
    </div>
        
        
        </div>
    </div>
    
    <script>
    
    function redirectToDash(){
    	window.location.href = "dashboard.jsp"; 
    }
    
    
 // Displaying messages for different scenarios

	window.onload = function() {
	<% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %> 
	showMessage('error', 'Something Went Wrong!');
	<% } 
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("pwdSaved")){%> 
	showMessage('success', 'password changed successfully...!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("pwdMisMatch")){%> 
	showMessage('error', 'password does not matched !!!');
	<%}
	else if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("oldPwdMisMatch")){%> 
	showMessage('error', 'current password does not matched !!!');
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