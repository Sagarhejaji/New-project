package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import com.emp.jdbc.DBConnect;


@WebServlet("/updateLogout")
public class UpdateLogoutTimeServlet extends HttpServlet{

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		Employees emp = (Employees) session.getAttribute("employee");

		if (emp != null) {
		    int eid = emp.getEmpId();
		    try (Connection con = DBConnect.getConnection()) {
		        EmpDao eDao = new EmpDao(con);
		        String msg = eDao.getLogout(eid);
		        System.out.println(msg);
		        if(msg.equals("AlreadyLoggedOut")) {
		        req.setAttribute("msg", "AlreadyLoggedOut");
		        }else if(msg.equals("NotLoggedIn")){
		        	req.setAttribute("msg", "NotLoggedIn");
		        }else if(msg.equals("LoggedOut")){
		        	req.setAttribute("msg", "logout");
		        }
		        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
		    } catch(Exception e) {
		        e.printStackTrace();
		    }
		} else {
		    // Handle case where employee is not in session
		    req.setAttribute("msg", "Error");
		    req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
		}

	}
}
