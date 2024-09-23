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
import com.emp.jdbc.DBConnect;

@WebServlet("/updaterejectreason")
public class UpdateRejectReasonServlet extends HttpServlet {


	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session= req.getSession();
//		 String uname = (String)session.getAttribute("username");
		String rs=req.getParameter("rejectreason");
		String status="Approved";
//		System.out.println(req.getParameter("rejectreason"));
		if(rs!= null && !rs.isEmpty())
		{
			rs=req.getParameter("rejectreason");
			status="Rejected";
		}

		int eid = Integer.parseInt(req.getParameter("eid"));
		//System.out.println("Approvedby "+eid);
		int leaveid=0;
		try {
			leaveid = Integer.parseInt(req.getParameter("leaveid"));
		}catch(NumberFormatException ne)
		{
			ne.printStackTrace();
		}
		
		try (Connection con = DBConnect.getConnection()) {
			EmpDao eDao = new EmpDao(con);
//			Employees em = eDao.getEmpData(uname);
			if(eDao.updaterejectreason(rs, eid,leaveid,status)) {
			if(!status.equals("Approved"))
			{
				eDao.updateLeavestock(leaveid);
			}
			System.out.println("approved");
			req.setAttribute("msg", "Success");
			req.getRequestDispatcher("leaveRequests.jsp").forward(req, resp);
			}else
			{
//				System.out.println("something went wrong");
				req.setAttribute("msg", "Error");
				req.getRequestDispatcher("leaveRequests.jsp").forward(req, resp);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}


}
