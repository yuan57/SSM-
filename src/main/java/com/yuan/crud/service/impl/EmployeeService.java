package com.yuan.crud.service.impl;

import com.yuan.crud.entity.Employee;
import com.yuan.crud.entity.EmployeeExample;
import com.yuan.crud.entity.Msg;
import com.yuan.crud.mapper.EmployeeMapper;
import com.yuan.crud.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检查数据库中是否有此用户名
     * @param empName
     * @return true 存在   false 不存在
     */
    @Override
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count==0;
    }

    @Override
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    @Override
    public void UpdateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }


}
