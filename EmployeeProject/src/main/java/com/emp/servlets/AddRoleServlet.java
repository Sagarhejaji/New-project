package com.emp.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.jdbc.DBConnect;

@WebServlet("/AddRoleServlet")
public class AddRoleServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String roleName = req.getParameter("newRole");
		try (Connection con = DBConnect.getConnection()) {

			EmpDao eDao = new EmpDao(con);
			boolean f = eDao.insertRole(roleName);
			if(f)
			{	
				req.setAttribute("msg", "roleAdded");
				req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);
			}else {
				req.setAttribute("msg", "DuplicateName");
			req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
