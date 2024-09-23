package com.emp.entities;

public class EmployeeFullDetails {
    private Employees employee;
    private Address address;

    
    public EmployeeFullDetails() {
		super();
	}

	// Constructors, getters, and setters
    public EmployeeFullDetails(Employees employee, Address address) {
        this.employee = employee;
        this.address = address;
    }

    public Employees getEmployee() {
        return employee;
    }

    public void setEmployee(Employees employee) {
        this.employee = employee;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}

