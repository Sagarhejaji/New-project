package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import com.emp.jdbc.DBConnect;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String currentPassword = req.getParameter("currentPassword");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");
		
		HttpSession ses = req.getSession();
		Employees emp = (Employees)ses.getAttribute("employee");

		
		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
//            eDao.updatePwd(emp.getEmpId(), hashPwd);
            if(eDao.validateUserPassword(username, currentPassword))
            {
//            	System.out.println("uname and oldpwd validated!!!");
            if(newPassword.equals(confirmPassword))
    		{
    			String hashPwd = BCrypt.hashpw(confirmPassword, BCrypt.gensalt());
//    			System.out.println("pwd encrypted!!!");
    			eDao.updatePwd(emp.getEmpId(), hashPwd);
//    			System.out.println("pwd chenged");
    			req.setAttribute("msg", "pwdSaved");
    			req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
//            resp.sendRedirect("dashboard.jsp?message=password changed successfully");
    		}else
    		{
//    			System.out.println("pwdmis match");
    			req.setAttribute("msg", "pwdMisMatch");
    			req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
//                resp.sendRedirect("changePassword.jsp?message=password doesn't match!!");

    		}
            }else
            {
//            	System.out.println("old pwd mis match");
            	req.setAttribute("msg", "oldPwdMisMatch");
    			req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
//            	resp.sendRedirect("changePassword.jsp?message=oldPassword doesn't match!!");
            }
		}catch(Exception e1)
		{
//			System.out.println("error");
			req.setAttribute("msg", "Error");
			req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
			e1.printStackTrace();
		}
	
		
	
	}
}
