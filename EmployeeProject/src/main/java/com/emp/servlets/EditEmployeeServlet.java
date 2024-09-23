package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.entities.EmployeeFullDetails;
import com.emp.jdbc.DBConnect;

@WebServlet("/editEmployee")
public class EditEmployeeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int empid = Integer.parseInt(req.getParameter("id"));
		
		
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			EmployeeFullDetails ea = empDao.getEmpFullDetails(empid);
			req.setAttribute("ea", ea);
			req.setAttribute("empid", empid);
			req.getRequestDispatcher("editEmployee.jsp").forward(req, resp);
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		 
	}

}
