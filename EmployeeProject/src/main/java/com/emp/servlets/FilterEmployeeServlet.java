package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.dao.EmpDao;
import com.emp.entities.Employees;
import java.util.List;
import com.emp.jdbc.DBConnect;

@WebServlet("/EmployeeFilter")
public class FilterEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roleidstr = request.getParameter("JobTitle");
        String name = request.getParameter("name");
        
//        System.out.println(roleidstr);
//        System.out.println(name);

        HttpSession sess=request.getSession();
        String role=(String)sess.getAttribute("role");
        int mid=((Employees)sess.getAttribute("employee")).getEmpId();
        
        Connection con=null;
        try {
			con = DBConnect.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        EmpDao empDao = new EmpDao(con);
        

        List<Employees> employeesList=null;
        
        try {
            if ((roleidstr == null || roleidstr.isEmpty()) && (name == null || name.isEmpty())) {
                // Initially display all employees
            	if("HR".equals(role))
            	{
                employeesList = empDao.getAllEmployees();
            	}
            	else
            	{
            		employeesList = empDao.getReportees(mid);
            	}
            	
            		
            } else if (roleidstr != null && !roleidstr.isEmpty() && (name == null || name.isEmpty())) {
                // Filter by role only
            	if("HR".equals(role))
            	{
            		employeesList = empDao.getEmployeesByRole(Integer.parseInt(roleidstr));
            	}
            	else
            	{
            		employeesList = empDao.getReporteesByRole(Integer.parseInt(roleidstr),mid);
            	}

                
            } else if (roleidstr != null && !roleidstr.isEmpty() && name != null && !name.isEmpty()) {
                // Filter by both role and name
            	if("HR".equals(role))
            	{
            		employeesList = empDao.getEmployeesByRoleAndName(Integer.parseInt(roleidstr),name);
            	}
            	else
            	{
            		employeesList = empDao.getReporteesByRoleAndName(Integer.parseInt(roleidstr),name,mid);
            	}
              
            } else if ((roleidstr == null || roleidstr.isEmpty()) && name != null && !name.isEmpty()) {
                // Filter by name only
            	if("HR".equals(role))
            	{
            		employeesList = empDao.getEmployeesByName(name);
            	}
            	else
            	{
            		employeesList = empDao.getReporteesByName(name,mid);
            	}
                
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

//        request.setAttribute("roleid", roleid);
//        System.out.println(employeesList);
        request.setAttribute("empList", employeesList);
        request.getRequestDispatcher("employees.jsp").forward(request, response);
    }
}
