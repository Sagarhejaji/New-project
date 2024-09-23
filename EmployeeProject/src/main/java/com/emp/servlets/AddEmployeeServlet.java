package com.emp.servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import com.emp.entities.UserCredentials;
import com.emp.entities.Address;

import com.emp.jdbc.DBConnect;

@WebServlet("/AddEmployee")
public class AddEmployeeServlet extends HttpServlet{

	InputStream ns = null;
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
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
		e.setEmpNo(req.getParameter("empno"));
		
		
		UserCredentials uc=new UserCredentials();
		uc.setUsername(req.getParameter("Username"));
		uc.setPassword(BCrypt.hashpw(req.getParameter("Password"), BCrypt.gensalt()));
		
		
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
		
		
		
		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            String qry="Select username from user_credentials where BINARY username=?";
            PreparedStatement ps=con.prepareStatement(qry);
            ps.setString(1,uc.getUsername());
            ResultSet rs=ps.executeQuery();
            if(!rs.next())
            {
            boolean f=eDao.addEmployees(e,uc,a);
            
            	if(f) 
            	{
            		req.setAttribute("msg", "empInserted");
            		req.getRequestDispatcher("employees.jsp").forward(req, resp);
            	}
            	else
            	{
            		req.setAttribute("msg", "Error2");
            		req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);
            	}
            }
            else
            {
            	req.setAttribute("msg", "Error3");
            	req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);
            }
  
            
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}

		
	}



}
