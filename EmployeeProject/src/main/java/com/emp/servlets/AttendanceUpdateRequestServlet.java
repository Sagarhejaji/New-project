package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import com.emp.jdbc.DBConnect;

@WebServlet("/requestUpdate")
public class AttendanceUpdateRequestServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int ID = Integer.parseInt(request.getParameter("attenId"));
//        System.out.println("attendId"+ID);
        String date = request.getParameter("date");
        String ChIn = request.getParameter("cit");
        String ChO = request.getParameter("cot");
        String name=request.getParameter("empName");

        Connection con = null;
        HttpSession ses= request.getSession();
        Employees emp=(Employees)ses.getAttribute("employee");
        String msg="";
        try {
			con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			boolean flag=empDao.UpdateAttendanceTable(ID,name,date,ChIn,ChO,emp.getEmpId());
//			System.out.println("Attendance obj after request update : "+att);
			if(flag)
			{
				request.setAttribute("msg", "Success");
		        request.getRequestDispatcher("attendance.jsp").forward(request, response);
			}else
			{
				request.setAttribute("msg", "Error");
		        request.getRequestDispatcher("attendance.jsp").forward(request, response);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
        
        
	}
	

}
