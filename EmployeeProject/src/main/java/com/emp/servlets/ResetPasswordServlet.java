package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.emp.dao.EmpDao;
import com.emp.jdbc.DBConnect;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		
		System.out.println("newpwd : "+newPassword+"\n confirmpwd : "+confirmPassword);

		if(newPassword.equals(confirmPassword))
		{
			String hashPwd = BCrypt.hashpw(confirmPassword, BCrypt.gensalt());

			// Database connection
			try (Connection con = DBConnect.getConnection()) {
				EmpDao eDao = new EmpDao(con);

				boolean f = eDao.changePassword(hashPwd,username);
				if(f) {System.out.println("Method success");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				}else
				{
					System.out.println("Method failed!");
					request.setAttribute("msg","Error2");
					request.getRequestDispatcher("resetpwd.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();	         	
			}

		}else
		{
			request.setAttribute("msg", "Error");
			request.getRequestDispatcher("resetpwd.jsp").forward(request, response);
		}






	}
}

