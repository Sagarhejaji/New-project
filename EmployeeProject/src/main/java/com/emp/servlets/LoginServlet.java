package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.dao.EmpDao;
import com.emp.entities.Attendance;
import com.emp.entities.Employees;
import com.emp.jdbc.DBConnect;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uname = req.getParameter("username");
	     String pwd = req.getParameter("password");

	     try (Connection con = DBConnect.getConnection()) {
	         EmpDao eDao = new EmpDao(con);
	         
	         // Info returns fetched role otherwise error..
	         boolean flag = eDao.validateLogin(uname, pwd);
	         if(flag) {
	         // employee object storing one employee record.
	         Employees employee = eDao.getEmpData(uname);
	         String role = eDao.getRoleByLogin(uname, pwd);
	         System.out.println("role : "+role);
	         HttpSession session = req.getSession();
	         //Setting employee object and role into session after logging in.
	         session.setAttribute("employee", employee);
	         session.setAttribute("username",uname);
	         session.setAttribute("role", role);
	         
	         List<Attendance> weekLogs = eDao.getAttendanceForDashBoard(employee.getEmpId());
	         session.setAttribute("weekLogs", weekLogs);
	         req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
	         }else
	         {
	        	 req.setAttribute("loginError",true);
	             req.getRequestDispatcher("login.jsp").forward(req, resp);
//	        	 resp.sendRedirect("login.jsp?message= Invalid username or password.!!!");
	         }
	         
	     } catch (Exception e) {
	         e.printStackTrace();
	         
	         req.setAttribute("loginError",true);
             req.getRequestDispatcher("login.jsp").forward(req, resp);
//	         resp.sendRedirect("login.jsp?message=input correct username.!!! ");
	     }
	}

	
	 
 
}
