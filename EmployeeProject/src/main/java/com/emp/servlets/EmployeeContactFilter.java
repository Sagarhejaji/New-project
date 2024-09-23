package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import com.emp.jdbc.DBConnect;

@WebServlet("/employeeContactFilter")
public class EmployeeContactFilter extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ename = req.getParameter("name");
		String empno = req.getParameter("empno");

		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			List<Employees> empList = null;

			if(!ename.isEmpty() && ename != null)
			{
				empList = empDao.getEmployeesByEmpName(ename);
				//				System.out.println("ename records : "+empList);
			}else if(!empno.isEmpty() && empno != null){
				empList = empDao.getEmployeesByEmpNo(empno);
				//			System.out.println("empno records : "+empList);
			}else if(!ename.isEmpty() && ename != null && !empno.isEmpty() && empno != null){
				empList = empDao.getEmployeesByEmpNameAndNo(empno,ename);
				//				System.out.println("empno records : "+empList);
			}

			req.setAttribute("empList", empList);
			req.getRequestDispatcher("contacts.jsp").forward(req, resp);


		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
