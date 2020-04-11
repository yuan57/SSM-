package com.yuan.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuan.crud.entity.Employee;
import com.yuan.crud.service.IEmployeeService;
import com.yuan.crud.service.impl.EmployeeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.jws.WebParam;
import java.util.List;

/**
 *处理员工CRUD
 */
@Controller
public class EmployeeController {
    @Autowired
    IEmployeeService employeeService;
    /**
     * 查询员工数据
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value ="pn",defaultValue = "1")Integer pn, Model model){
        //这不是一个分页查询
        //引入一个分页插件 pagehelper
        PageHelper.startPage(pn,10);
        //staryPage后面紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果，只要把pageinfo交给页面就行了
        //包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
