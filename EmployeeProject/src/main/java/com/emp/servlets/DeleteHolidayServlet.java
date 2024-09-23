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

@WebServlet("/deleteHoliday")
public class DeleteHolidayServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int id = Integer.parseInt(req.getParameter("id"));
		
		try (Connection con = DBConnect.getConnection()) {
			EmpDao empDao = new EmpDao(con);
			boolean flag = empDao.deleteHolidayRecord(id);
			if(flag)
			{
			req.setAttribute("msg", "Deleted");
			req.getRequestDispatcher("holidays.jsp").forward(req, resp);
			}else
			{
				req.setAttribute("msg", "Error");
				req.getRequestDispatcher("holidays.jsp").forward(req, resp);
			}
		}catch(Exception e)
		{
			
		}
		}
	

}
