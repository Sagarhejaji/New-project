package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.emp.dao.EmpDao;
import com.emp.entities.Attendance;
import com.emp.jdbc.DBConnect;

@WebServlet("/filterAttendance")
public class FilterAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	
    	String year = request.getParameter("year");
        String month = request.getParameter("month");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
//        String origin = request.getParameter("origin");

        Connection con = null;
        List<Attendance> filteredAttendance = null;
        int id = -1;
        
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        try {
            con = DBConnect.getConnection();
            EmpDao empDao = new EmpDao(con);

            if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
                filteredAttendance = empDao.getAttendanceByDateRange(id, fromDate, toDate);
            } else if (year != null && !year.isEmpty() && month != null && !month.isEmpty()) {
                filteredAttendance = empDao.getAttendanceByYearMonth(id, year, month);
            } else if (year != null && !year.isEmpty()) {
                filteredAttendance = empDao.getAttendanceByYear(id, year);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        request.setAttribute("filteredAttendance", filteredAttendance);
//        if ("attendance".equals(origin)) {
            request.getRequestDispatcher("attendance.jsp").forward(request, response);
//        } else {
//            request.getRequestDispatcher("EmpAttend.jsp").forward(request, response);
//        }
        
    }
}
