package com.yuan.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuan.crud.entity.Employee;
import com.yuan.crud.entity.Msg;
import com.yuan.crud.service.IEmployeeService;
import com.yuan.crud.service.impl.EmployeeService;
import javafx.scene.effect.Light;
import org.junit.Test;
import org.junit.jupiter.params.shadow.com.univocity.parsers.annotations.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
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

    /**
     * 员工保存
     * 1、支持JSR303校验
     * 2、导入hibernate-validator包
     * @return
     */

    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError error:errors){
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorField",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg  checkUser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名是2-5位中文或者是6-16位英文和数字的组合");
        }else{
            boolean b = employeeService.checkUser(empName);
            if(b){
                return Msg.success();
            }else{
                return Msg.fail().add("va_msg","用户名不可用");
            }
        }
    }

    @RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public  Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return  Msg.success().add("emp",employee);
    }


    @RequestMapping(value = "/saveEmpWithUpdate/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmpWithUpdate(@Valid Employee employee, BindingResult result, HttpServletRequest request){
        System.out.println(request.getParameter("gender"));
        System.out.println(employee);
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError error:errors){
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorField",map);
        }else{
            employeeService.UpdateEmp(employee);
            return Msg.success();
        }

    }

}
