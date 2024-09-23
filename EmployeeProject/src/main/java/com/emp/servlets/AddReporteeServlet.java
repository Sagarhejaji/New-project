package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.entities.Manager;
import com.emp.jdbc.DBConnect;

@WebServlet("/addReportee")
public class AddReporteeServlet extends HttpServlet{

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			Manager m=new Manager();
			m.setManager(req.getParameter("Manager"));
			m.setEmployee(req.getParameter("employees"));
			
			if(empDao.addReportee(m)) {
				req.setAttribute("msg","Success");
				req.getRequestDispatcher("reportTo.jsp").forward(req, resp);
			}
			else
			{
				req.setAttribute("msg","Error");
				req.getRequestDispatcher("reportTo.jsp").forward(req, resp);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
}

