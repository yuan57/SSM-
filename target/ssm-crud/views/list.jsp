<!DOCTYPE html>
<%@ page contentType="text/html;charset=gb2312" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" >
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>员工列表</title>

<%--    不以/为开始的相对路径，以当前资源的路径为基准，经常容易出问题
        以/为开始的相对路径，找资源，以服务器的路径为基准（http://localhost:3306）:需要加上项目名
        http://localhost:8080/ssm/
--%>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <%--    引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.8.3.js"></script>
    <%--    引入样式--%>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/npm.js"></script>
</head>
<body>
    <%--搭建显示页面--%>
    <div class="container">
        <%--标题--%>
        <div class="row" class="col-md-12">SSM-CRUD</div>
        <%--按钮--%>
        <div class="row"></div>
        <%--显示表格数据--%>
        <div class="row"></div>
         <%--显示分页--%>
        <div class="row"></div>
    </div>
</body>
</html>