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

@WebServlet("/cancelLeave")
public class CancelLeaveServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int leaveid = Integer.parseInt(req.getParameter("id"));
		String status="Cancelled";
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			boolean flag = empDao.CancelLeave(leaveid,status);
			empDao.updateLeavestock(leaveid);
			if(flag)
			{
				req.setAttribute("msg","Success");
				req.getRequestDispatcher("employeeLeaves.jsp").forward(req, resp);
			}else
			{
				req.setAttribute("msg","Error");
				req.getRequestDispatcher("employeeLeaves.jsp").forward(req, resp);
			}
		
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}