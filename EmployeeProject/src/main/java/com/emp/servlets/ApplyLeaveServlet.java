package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import com.emp.entities.Leaves;
import com.emp.jdbc.DBConnect;

@WebServlet("/applyLeave")
public class ApplyLeaveServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession ses = req.getSession();
		Employees emp = (Employees)ses.getAttribute("employee");
		
		String from_date = req.getParameter("fromDate");
		String to_date = req.getParameter("toDate");

		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);

			Leaves lev = new Leaves();
			lev.setEmployeeID(emp.getEmpId());
			lev.setFromDate(from_date);
			lev.setToDate(to_date);
			lev.setLeaveType(req.getParameter("leaveType"));
			lev.setAppliedReason(req.getParameter("reason"));
			lev.setLeaveStatus("Pending");

			int totalDays = empDao.validateLeaves(req.getParameter("fromDate"), req.getParameter("toDate"));
			if(empDao.getAvailableLeaves(emp.getEmpId()) >= totalDays)
			{
				lev.setTotalDays(totalDays);
				boolean f = empDao.getLeave(emp.getEmpId(),from_date,to_date);
//				System.out.println("boolean value : "+f);
				if(f)
					{
						req.setAttribute("msg","AlreadyLeaveApplied");
						req.getRequestDispatcher("applyLeave.jsp").forward(req, resp);
					}else
				{
					int leaveid = empDao.insertLeave(lev);
					if(leaveid > 0)
					{
						if(empDao.updateLeavestock(leaveid))
						{
							req.setAttribute("msg","Success");
							req.getRequestDispatcher("applyLeave.jsp").forward(req, resp);
							//						resp.sendRedirect("applyLeave.jsp?message=Leave aaplied successfully!!!");
						}else
						{
							req.setAttribute("msg","Error");
							req.getRequestDispatcher("applyLeave.jsp").forward(req, resp);
							//							resp.sendRedirect("applyLeave.jsp?message=Something went wrong!!!");
						}
					}else
					{
						req.setAttribute("msg","LeaveStockError");
						req.getRequestDispatcher("applyLeave.jsp").forward(req, resp);
						//				resp.sendRedirect("applyLeave.jsp?message=Leave not applied !!!");
					}
				}
			}else
			{
				req.setAttribute("msg","OutOfLeaves");
				req.getRequestDispatcher("applyLeave.jsp").forward(req, resp);
				//			resp.sendRedirect("applyLeave.jsp?message=out of days!!!");
			}





		}catch(Exception e)
		{
			e.printStackTrace();
		}


	}

}
