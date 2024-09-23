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

@WebServlet("/cancel")
public class DeleteLeaveServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int leaveid = Integer.parseInt(req.getParameter("id"));
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			boolean flag = empDao.deleteLeaveRecord(leaveid);
			if(flag)
			{
				System.out.println("leave cancel Success");
				req.setAttribute("msg","Success");
				req.getRequestDispatcher("myLeaves.jsp").forward(req, resp);
			}else
			{
				System.out.println("leave cancel Error");
				req.setAttribute("msg","Error");
				req.getRequestDispatcher("myLeaves.jsp").forward(req, resp);
			}
		
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	

}
