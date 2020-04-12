package com.yuan.crud.entity;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //状态码 200-成功  300-失败
    private int code;
    //提示信息
    private String msg;
    //用户返回给浏览器的数据
    private Map<String,Object> data =new HashMap<>();

    public static  Msg success(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理成功");
        return result;
    }

    public static  Msg fail(){
        Msg result = new Msg();
        result.setCode(300);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.data.put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public Msg(int code, String msg, Map<String, Object> data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    public Msg() {
    }
}
