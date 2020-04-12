package com.yuan.crud.service.impl;

import com.yuan.crud.entity.Department;
import com.yuan.crud.entity.Msg;
import com.yuan.crud.mapper.DepartmentMapper;
import com.yuan.crud.service.IDpartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService implements IDpartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    @Override
    public List<Department> getDepts() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
