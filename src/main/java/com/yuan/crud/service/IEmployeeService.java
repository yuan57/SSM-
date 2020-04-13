package com.yuan.crud.service;

import com.yuan.crud.entity.Employee;

import java.util.List;

public interface IEmployeeService {
    public List<Employee> getAll();
    void saveEmp(Employee employee);
    boolean checkUser(String empName);

    Employee getEmp(Integer id);

    void UpdateEmp(Employee employee);

    void deleteEmp(Integer id);

    void deleteBatch(List<Integer> ids);
}
