package com.emp.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String generatedOTP = (String) session.getAttribute("otp");

        if (otp.equals(generatedOTP)) {
        	request.getRequestDispatcher("resetpwd.jsp").forward(request, response);
//            response.sendRedirect("resetpwd.jsp");
        } else {
        	request.setAttribute("msg", "Error");
        	request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
//            response.sendRedirect("verifyotp.jsp?message=Invalid OTP");
        }
    }
}

