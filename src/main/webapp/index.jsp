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

    <%--    引入样式--%>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <%--    引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
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
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empname</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>department</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
        <script type="text/javascript">

            //页面加载完成之后，直接发送ajax请求，要到分页数据
            $(function () {
                //去首页
                to_Page(1);
            });

            function to_Page(pn) {
                $.ajax({
                    url: "${APP_PATH}/emps",
                    data: "pn=" + pn,
                    type: "GET",
                    success: function (result) {
                        // console.log(result);
                        // 1、解析并显示员工数据
                        // 2、解析并显示分页信息
                        build_emps_table(result);
                        build_page_info(result);
                        build_page_nav(result);
                    }
                });
            }

            //解析显示emp数据
            function build_emps_table(result) {
                //清空之前数据
                $("#emps_table tbody").empty();
                var emps = result.data.pageInfo.list;
                $.each(emps, function (index, item) {
                    // alert(item.empName);
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.dept.deptName);
                    var editBtn = $("<button></button>").addClass("btn btn-success btn-sm")
                        .append("<span></span>").addClass("lyphicon glyphicon-pencil")
                        .append("编辑");
                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                        .append("<span></span>").addClass("glyphicon glyphicon-trash")
                        .append("删除");
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                    //append方法返回原来的元素
                    $("<tr></tr>")
                        .append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(deptNameTd)
                        .append(btnTd)
                        .appendTo("#emps_table tbody");
                });
            }


            //解析显示分页信息
            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append(" 当前第" + result.data.pageInfo.pageNum + "页，总" + result.data.pageInfo.pages + "页 总" + result.data.pageInfo.total + "条数据");
            }

            //解析显示分页条信息
            function build_page_nav(result) {
                $("#page_nav_area").empty();
                //page_nav_area
                var nav = $("<nav></nav>").addClass("Page navigation");
                var ul = $("<ul></ul>").addClass("pagination");
                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
                var prePageLi = $("<li></li>").append($("<a></a>").attr("href", "#").attr("aria-label", "Previous").append($("<span></span>").append("&laquo;").attr("aria-hidden", "true")));
                if (result.data.pageInfo.hasPreviousPage == false) {
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                } else {
                    firstPageLi.click(function () {
                        to_Page(1);
                    });
                    prePageLi.click(function () {
                        to_Page(result.data.pageInfo.pageNum - 1);
                    });
                }
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
                var nextPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").attr("aria-label", "Next").append($("<span></span>").append("&raquo;").attr("aria-hidden", "true")));
                if (result.data.pageInfo.hasNextPage == false) {
                    lastPageLi.addClass("disabled");
                    nextPageLi.addClass("disabled");
                } else {
                    lastPageLi.click(function () {
                        to_Page(result.data.pageInfo.pages);
                    });
                    nextPageLi.click(function () {
                        to_Page(result.data.pageInfo.pageNum + 1);
                    });
                }
                ul.append(firstPageLi);
                ul.append(prePageLi);
                $.each(result.data.pageInfo.navigatepageNums, function (index, item) {
                    var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
                    if (result.data.pageInfo.pageNum == item) {
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        to_Page(item);
                    });
                    ul.append(numLi);
                });
                ul.append(nextPageLi);
                ul.append(lastPageLi);
                nav.append(ul);
                nav.appendTo("#page_nav_area");
            }
        </script>
    </div>
</div>
</div>
</body>
</html>