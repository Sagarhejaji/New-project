package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.emp.dao.EmpDao;
import com.emp.jdbc.DBConnect;

@WebServlet("/AttendanceUpdate")
public class AttendanceUpdateServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int ID = Integer.parseInt(request.getParameter("id"));
        String date = request.getParameter("Date");
        String ChIn = request.getParameter("CIT");
        String ChO = request.getParameter("COT");

        Connection con = null;
        String msg="";
        try {
			con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			boolean flag = empDao.UpdateAttendance(ID,date,ChIn,ChO);
			if(flag)
			{
				request.setAttribute("msg", "Success");
		        request.getRequestDispatcher("attendanceRequest.jsp").forward(request, response);
			}else
			{
				request.setAttribute("msg", "Error");
		        request.getRequestDispatcher("attendanceRequest.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
	}

}
