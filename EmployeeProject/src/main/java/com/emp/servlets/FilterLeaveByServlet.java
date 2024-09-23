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
import com.emp.entities.Leaves;
import com.emp.jdbc.DBConnect;

@WebServlet("/filterLeaveBy")
public class FilterLeaveByServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String month = req.getParameter("month");
		String year = req.getParameter("year");
		int empid = Integer.parseInt(req.getParameter("empid"));
		
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			 List<Leaves> filteredLeaves = null;
			 
			 
			 if (year != null && !year.isEmpty() && month != null && !month.isEmpty()) {
				 filteredLeaves = empDao.getLeaveByYearMonth(empid, year, month);
	            } else if (year != null && !year.isEmpty()) {
	            	filteredLeaves = empDao.getLeaveByYear(empid, year);
	            }
			 
			 	System.out.println("something is setting : "+filteredLeaves);

			 	req.setAttribute("filteredLeaves", filteredLeaves);
		        req.getRequestDispatcher("employeeLeaves.jsp").forward(req, resp);
//		        resp.sendRedirect("employeeLeaves.jsp");
			 
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
