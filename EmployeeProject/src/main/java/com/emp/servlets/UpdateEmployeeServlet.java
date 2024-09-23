package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emp.dao.EmpDao;
import com.emp.entities.Address;
import com.emp.entities.Employees;
import com.emp.jdbc.DBConnect;

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int employeeid = Integer.parseInt(req.getParameter("employeeid"));
		// Employees object to store one record
		Employees e=new Employees();
		e.setFname(req.getParameter("FirstName"));
		e.setLname(req.getParameter("LastName"));
		e.setDateofBirth(req.getParameter("DateOfBirth"));
		e.setGender(req.getParameter("Gender"));
		e.setNationality(req.getParameter("Nationality"));
		e.setMaritalStatus(req.getParameter("MaritalStatus"));
		e.setBloodGroup(req.getParameter("BloodGroup"));		
		e.setPersonalMobile(req.getParameter("Mobile"));
		e.setPersonalHome(req.getParameter("Home"));
		e.setEmergencyName(req.getParameter("EmergencyName"));
		e.setEmergencyRelatoin(req.getParameter("Relation"));
		e.setEmergencyMobile(req.getParameter("EmergencyMobile"));
		e.setPersonalEmail(req.getParameter("PersonalEmail"));
		e.setWorkEmail(req.getParameter("WorkEmail"));
		e.setHireDate(req.getParameter("JoinedDate"));
		e.setRoleId(Integer.parseInt(req.getParameter("JobTitle")));
		e.setJobLocation(req.getParameter("Location"));
		
//		UserCredentials uc=new UserCredentials();
//		uc.setUsername(req.getParameter("Username"));
//		uc.setPassword(BCrypt.hashpw(req.getParameter("Password"), BCrypt.gensalt()));
		
		// Address object to store one record
		Address a=new Address();
		a.setLine1(req.getParameter("PermanentStreet1"));
		a.setLine2(req.getParameter("PermanentStreet2"));
		a.setCity(req.getParameter("PermanentCity"));
		a.setState(req.getParameter("PermanentState"));
		a.setPostalCode(req.getParameter("PermanentPostalCode"));
		a.setCountry(req.getParameter("PermanentCountry"));
		a.setTempLine1(req.getParameter("TemporaryStreet1"));
		a.setTempLine2(req.getParameter("TemporaryStreet2"));
		a.setTempCity(req.getParameter("TemporaryCity"));
		a.setTempState(req.getParameter("TemporaryState"));
		a.setTempPostalCode(req.getParameter("TemporaryPostalCode"));
		a.setTempCountry(req.getParameter("TemporaryCountry"));
		
		
		try {
			Connection con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			boolean f = empDao.updateEmployeeAndAddress(e, a, employeeid);
			if(f)
			{
				req.setAttribute("msg", "empUpdated");
				req.getRequestDispatcher("employees.jsp").forward(req, resp);
			}else
			{
				req.setAttribute("msg", "Error");
				req.getRequestDispatcher("editEmployee.jsp").forward(req, resp);
			}
			
		}catch(Exception exp)
		{
			exp.printStackTrace();
		}
	}

	
	
}
