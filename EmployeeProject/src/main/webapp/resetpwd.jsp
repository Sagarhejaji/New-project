<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
         @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #FF9671, #FFC75F, #FF9671);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            padding: 40px;
            
            backdrop-filter: blur(10px);
            transform: translateY(-20px);
            transition: all 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-25px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .input-group {
            position: relative;
            margin-bottom: 25px;
        }

        input, .login-btn {
            width: 100%;
            padding: 15px 20px;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input {
            background-color: #f0f0f0;
            transition: all 0.3s ease;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input:focus {
            outline: none;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1), 0 0 0 3px rgba(255, 150, 113, 0.3);
        }

        .toggle-password {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
        }
        .toggle-password2 {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
        }

        .login-btn {
            background-color: #ff7b1d;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .login-btn:hover {
            background-color: #ff9671;
        }

        .forgot-password {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #666;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .forgot-password:hover {
            color: #ff7b1d;
        }
        
        .orange-circle {
    position: absolute;
    top: -150px;
    right: -150px;
    width: 70%;
    height: 150%;
    background-color: #ff7b1d;
    
    border-radius: 50%;
    z-index: -1;
}
/*warning starts*/

 .warning-message, .error-message {
            position: fixed;
            top: -200px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(220, 53, 69, 0.8); /* More transparency */
            color: white;
            padding: 20px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2); /* Slightly stronger shadow for more depth */
            text-align: center;
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
            z-index: 1000;
            max-width: 60%;
            backdrop-filter: blur(10px); /* Stronger blur effect */
        }

		.warning-message::before, .error-message::before
		{
			 margin-top:-5%;
		}
        .warning-message p, .error-message p {
            margin: 3px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* More modern font */
        }

        .warning-message p:first-child,  .error-message p:first-child {
            font-weight: bold;
            font-size: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .warning-message i, .error-message i {
            font-size: 24px;
            margin-right: 10px;
            vertical-align: middle;
        }

        .warning-message.show, .error-message.show {
            top: 30px;
            animation: shake 0.82s cubic-bezier(.36,.07,.19,.97) both;
        }

        @keyframes shake {
            10%, 90% { transform: translate3d(-51%, 0, 0); }
            20%, 80% { transform: translate3d(-49%, 0, 0); }
            30%, 50%, 70% { transform: translate3d(-52%, 0, 0); }
            40%, 60% { transform: translate3d(-48%, 0, 0); }
        }

/*warning ends*/

    </style>
    
    <script>
    
    // toggle visibility
    
    
    function togglePasswordVisibility() {
            var passwordInput = document.getElementById('newPassword');
            var togglePassword = document.querySelector('.toggle-password');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                togglePassword.classList.remove('fa-eye');
                togglePassword.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                togglePassword.classList.remove('fa-eye-slash');
                togglePassword.classList.add('fa-eye');
            }
        }
        
    
    function togglePasswordVisibility2() {
        var passwordInput = document.getElementById('confirmPassword');
        var togglePassword = document.querySelector('.toggle-password2');
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            togglePassword.classList.remove('fa-eye');
            togglePassword.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            togglePassword.classList.remove('fa-eye-slash');
            togglePassword.classList.add('fa-eye');
        }
    }
        // warning message function
        function showWarningMessage() {
        const warningMessage = document.getElementById('warning-message');
        warningMessage.classList.add('show');
        
        setTimeout(() => {
            warningMessage.classList.remove('show');
        }, 4000);
    }
        
        function showErrorMessage() {
            const warningMessage = document.getElementById('error-message');
            warningMessage.classList.add('show');
            
            setTimeout(() => {
                warningMessage.classList.remove('show');
            }, 4000);
        }

    // Check for login error
    window.onload = function() {
        <% if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error")) { %>
    showWarningMessage();
<% }  if (request.getAttribute("msg")!=null && request.getAttribute("msg").equals("Error2")) { %>
showErrorMessage();
<% } %>
    }
        
    </script>
</head>
<body>
<%
HttpSession sess = request.getSession();
String uname = (String)sess.getAttribute("username");
%>

<div id="warning-message" class="warning-message">
    <i class="fas fa-exclamation-triangle"></i>
    <p>Password doesn't match!!!</p>
</div>

<div id="error-message" class="error-message">
    <i class="fas fa-exclamation-triangle"></i>
    <p>Something Went Wrong!!!</p>
</div>

    <div class="login-container">
        <h2>Reset Password</h2>
        <form action="ResetPasswordServlet" method="post">
            <div class="input-group">
                <input type="text" id="username" name="username" value="<%= uname %>" disabled>
            </div>
            <div class="input-group">
                <input type="password" id="newPassword" name="newPassword" placeholder="New Password" required>
                <span><i class="fas fa-eye toggle-password" onclick="togglePasswordVisibility()"></i></span>
            </div>
            
            <div class="input-group">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                <span><i class="fas fa-eye toggle-password2" onclick="togglePasswordVisibility2()"></i></span>
            </div>
            
            <button type="submit" class="login-btn">Reset</button>
        </form>
    </div>
    <div class="orange-circle"></div>
</body>
</html>