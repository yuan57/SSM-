package com.yuan.crud.controller;

import com.yuan.crud.entity.Department;
import com.yuan.crud.entity.Msg;
import com.yuan.crud.service.IDpartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**处理和部门有关的请求
 */
@Controller
 public class DeptController {
    @Autowired
    private IDpartmentService departmentService;
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
