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

@WebServlet("/insertHoliday")
public class InsertHolidayServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String date = req.getParameter("date");
		String holidayname = req.getParameter("holidayName");
		
		try {
			
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			if(empDao.insertHoliday(date, holidayname))
			{
				req.setAttribute("msg","Inserted");
				req.getRequestDispatcher("holidays.jsp").forward(req, resp);
			}else
			{
				req.setAttribute("msg", "Error");
				req.getRequestDispatcher("holidays.jsp").forward(req, resp);
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
