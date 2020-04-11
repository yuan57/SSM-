package com.yuan.crud.service.impl;

import com.yuan.crud.entity.Employee;
import com.yuan.crud.mapper.EmployeeMapper;
import com.yuan.crud.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService implements IEmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    /**
     *查询所有员工
     * @return
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }
}
