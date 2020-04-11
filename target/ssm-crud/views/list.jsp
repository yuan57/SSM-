<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=gb2312" isELIgnored="false" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>员工列表</title>

    <%--    不以/为开始的相对路径，以当前资源的路径为基准，经常容易出问题
            以/为开始的相对路径，找资源，以服务器的路径为基准（http://localhost:3306）:需要加上项目名
            http://localhost:8080/ssm/
    --%>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <%--    引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.8.3.js"></script>
    <%--    引入样式--%>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/npm.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" class="col-md-12">
        <h1>SSM-CRUD</h1>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success  btn-sm">新增</button>
            <button class="btn btn-danger btn-sm">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empname</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>department</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="emp" items="${pageInfo.list}">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.dept.deptName}</th>
                        <th>
                            <button class="btn btn-success btn-sm">
                                编辑
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            </button>
                            <button class="btn btn-danger btn-sm">
                                删除
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--显示分页--%>
    <div class="row">
        <%--文字信息--%>
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页，总${pageInfo.pages}页 总${pageInfo.total}条数据
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum==pageInfo.pageNum}" var="page_Num">
                            <li class="active"><a href="#">${pageNum}</a></li>
                        </c:if>
                        <c:if test="${pageNum!=pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>