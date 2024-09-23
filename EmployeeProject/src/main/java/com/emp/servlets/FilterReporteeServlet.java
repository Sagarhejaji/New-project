package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.entities.Manager;
import com.emp.jdbc.DBConnect;

@WebServlet("/filterReportee")
public class FilterReporteeServlet extends HttpServlet{

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			int mid=Integer.parseInt(req.getParameter("filterManager"));
			
			List<Manager> filteredreportee=null;
			
			filteredreportee=empDao.getReportingEmployee(mid);
			
			req.setAttribute("filteredreportee", filteredreportee);
	        req.getRequestDispatcher("reportTo.jsp").forward(req, resp);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
}

