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

@WebServlet("/assignLeave")
public class AssignLeaveServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int NoOfDays = Integer.parseInt(req.getParameter("nod"));
		
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			boolean flag = empDao.addLeavesStock(NoOfDays);
			if(flag)
			{
			req.setAttribute("msg", "Success");
			req.getRequestDispatcher("assignLeave.jsp").forward(req, resp);
			}else
			{
				req.setAttribute("msg", "Error");
				req.getRequestDispatcher("assignLeave.jsp").forward(req, resp);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	

}
