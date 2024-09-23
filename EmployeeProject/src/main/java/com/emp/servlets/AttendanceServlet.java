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
import com.emp.jdbc.DBConnect;

@WebServlet("/insertLogin")
public class AttendanceServlet extends HttpServlet{


	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


		//String yes = req.getParameter("yes");
		//String no = req.getParameter("no");


		HttpSession session = req.getSession();
		Employees emp = (Employees) session.getAttribute("employee");
		//		int id = emp.getEmpId();

		if (emp != null) {
			int eid = emp.getEmpId();
			try (Connection con = DBConnect.getConnection()) {
				EmpDao eDao = new EmpDao(con);
				if(eDao.getLogin(eid))
				{
					if(eDao.validateAttendance(eid))
					{
//						System.out.println("You are on leave");
						req.setAttribute("msg","onLeave");
						req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
					}else
					{
						if(eDao.validateAttendanceHoliday())
						{
//							System.out.println("In Holiday Validation true");
							eDao.insertLogin(eid);
							req.setAttribute("msg","Login");
							req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
						}
						else
						{
//							System.out.println("In Holiday Validation false");
							req.setAttribute("flag", true);
							req.setAttribute("msg","Holiday");
							req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
						}

					}

				}else
				{
//					System.out.println("already log in");
					req.setAttribute("msg","alreadyLoggedIn");
					req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
				}


			}
			catch(Exception e) {
//				System.out.println("something went wrong");
				req.setAttribute("msg","Error");
				req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
				e.printStackTrace();
			}
		}



	}
}


