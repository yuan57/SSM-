package com.yuan.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuan.crud.entity.Employee;
import com.yuan.crud.entity.Msg;
import com.yuan.crud.service.IEmployeeService;
import com.yuan.crud.service.impl.EmployeeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jws.WebParam;
import java.util.List;
import java.util.Map;

/**
 *处理员工CRUD
 */
@Controller
public class EmployeeController {
    @Autowired
    IEmployeeService employeeService;

    /**
     * 导入jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value ="pn")Integer pn){
        //这不是一个分页查询
        //引入一个分页插件 pagehelper
        PageHelper.startPage(pn,5);
        //staryPage后面紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果，只要把pageinfo交给页面就行了
        //包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * 查询员工数据
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value ="pn",defaultValue = "1")Integer pn, Map<String,Object> map){
        //这不是一个分页查询
        //引入一个分页插件 pagehelper
        PageHelper.startPage(pn,5);
        //staryPage后面紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果，只要把pageinfo交给页面就行了
        //包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        map.put("pageInfo",page);
        return "list";
    }
}
