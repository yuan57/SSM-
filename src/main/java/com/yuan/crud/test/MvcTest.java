package com.yuan.crud.test;

import com.github.pagehelper.PageInfo;
import com.yuan.crud.entity.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 *
 *使用Spring测试模块的测试请求功能，测试curd的请求的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
    //传入springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求，获取处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public  void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult rs = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

        //请求成功以后，请求域会有pageInfo, 去除pageInfo进行验证
        MockHttpServletRequest request = rs.getRequest();
        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码：");
        int[] nums= pageInfo.getNavigatepageNums();
        for(int i:nums){
            System.out.println("" + i);
        }
        System.out.println("员工数据：");
        List<Employee> emps = pageInfo.getList();
        for(Employee emp:emps){
            System.out.println("ID:"+emp.getEmpId()+"===>name"+emp.getEmpName());
        }
    }
}
