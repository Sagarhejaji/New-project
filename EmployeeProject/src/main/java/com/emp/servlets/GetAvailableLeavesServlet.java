package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.jdbc.DBConnect;

@WebServlet("/getAvailableLeaves")
public class GetAvailableLeavesServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		int empid = Integer.parseInt(req.getParameter("empid"));
		try {
			
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			int availableLeaves = empDao.getAvailableLeaves(empid);
			System.out.println("availableLeaves : "+availableLeaves);
//			resp.setContentType("application/json");
//	        resp.setCharacterEncoding("UTF-8");
//	        resp.getWriter().write("{\"availableLeaves\":" + availableLeaves + "}");
			resp.setContentType("application/json");
	        resp.setCharacterEncoding("UTF-8");
	        resp.getWriter().write("{\"availableLeaves\":" + availableLeaves + "}");
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
