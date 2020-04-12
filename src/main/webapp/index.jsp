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
<%--   员工添加模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="emp_add_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="gridSystemModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="zs">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gendar</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gendar_M_add" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gendar_F_add" value="F"> 女
                        </label>
                    </div>
                    <!--部门名下拉列表 提交部门id即可-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--    员工修改模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel"
     id="emp_update_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input"
                               class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update-static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control"
                                   id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input"
                               class="col-sm-2 control-label">gendar</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="M"
                                   checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="F"> 女
                        </label>
                    </div>
                    <!--部门名下拉列表 提交部门id即可-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row" class="col-md-12">
        <h1>SSM-CRUD</h1>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success  btn-sm" id="emp_add_modal_btn">新增</button>
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


            var totalRecord;
            var currentPage;

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
                        .append("<span></span>").addClass("lyphicon glyphicon-pencil edit_btn")
                        .append("编辑");
                    //为编辑按钮添加自定义属性，来表示员工当前id
                    editBtn.attr("edit_id",item.empId);
                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                        .append("<span></span>").addClass("glyphicon glyphicon-trash delete_btn")
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
                totalRecord = result.data.pageInfo.total;
                currentPage = result.data.pageInfo.pageNum;
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

            //清除表单数据和样式
            function resetForm(ele) {
                //清除表单数据
                $(ele)[0].reset();
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }

            //点击新增按钮弹出模块框
            $("#emp_add_modal_btn").click(function () {
                //清除表单数据和样式
                resetForm($("#emp_add_modal form"));
                //发送ajax请求，查出部门信息，显示下拉列表
                getDepts("#dept_add_select");
                //弹出模态框
                $("#emp_add_modal").modal({
                    backdrop: false
                });
            });

            // 查询部门信息
            function getDepts(ele) {
                //清空下拉列表
                $(ele).empty();
                $.ajax({
                    url: "${APP_PATH}/depts",
                    type: "GET",
                    success: function (result) {
                        $.each(result.data.depts, function () {
                            var option = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                            option.appendTo(ele);
                        });
                    }
                });
            }

            function validate_add_form() {
                //1、拿到要校验的数据，使用正则表达式进行校验
                var empName = $("#empName_add_input").val();
                var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
                if (!regName.test(empName)) {
                    // alert("用户名是2-5位中文或者是6-16位英文和数字的组合");
                    show_validate_msg($("#empName_add_input"), "eror", "用户名是2-5位中文或者是6-16位英文和数字的组合");
                    return false;
                } else {
                    show_validate_msg($("#empName_add_input"), "success", "");
                }
                var email = $("#email_add_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!regEmail.test(email)) {
                    // alert("邮箱格式不正确");
                    //应该清空这个元素之前的样式
                    show_validate_msg($("#email_add_input"), "eror", "邮箱格式不正确")
                    return false;
                } else {
                    show_validate_msg($("#email_add_input"), "success", "");
                }
                return true;
            }

            function show_validate_msg(ele, status, msg) {
                //清除当前元素校验状态
                ele.parent().removeClass("has-success has-error");
                ele.next("span").text("");
                if (status == "success") {
                    ele.parent().addClass("has-success");
                    ele.next("span").text(msg);
                } else {
                    ele.parent().addClass("has-error");
                    ele.next("span").text(msg);
                }
            }

            //点击保存
            $("#emp_save_btn").click(function () {
                //1、将模态框中的数据提交给数据库
                //2、先对要提交服务器的数据进行校验
                //3、判断之前的用户名校验是否成功，如果成功，继续
                //3、发送ajax请求，保存员工
                if (!validate_add_form()) {
                    return false;
                }
                if ($(this).attr("ajax-va") == "error") {
                    return false;
                }
                $.ajax({
                    url: "${APP_PATH}/saveEmp",
                    type: "post",
                    data: $("#emp_add_modal form").serialize(),
                    success: function (result) {
                        // alert(result.msg);
                        if (result.code == 200) {
                            // 保存成功：
                            // 1、关闭模态框
                            $("#emp_add_modal").modal('hide');
                            // 2、来到最后一页
                            //发送ajax请求显示最后一页数据
                            to_Page(totalRecord);
                        } else {
                            // {"code":300,"msg":"处理失败","data":{"errorField":{"email":"邮箱格式不正确"}}}
                            if (result.data.errorField.email != undefined) {
                                //显示邮箱错误信息
                                show_validate_msg($("#email_add_input"), "error", "邮箱格式错误");
                            }
                            if (result.data.errorField.empName != undefined) {
                                //显示名字错误信息
                                show_validate_msg($("#email_add_input"), "error", "va_msg\",\"用户名是2-5位中文或者是6-16位英文和数字的组合");
                            }
                        }

                    }
                });
            });

            //检查用户名是否重复
            $("#empName_add_input").change(function () {
                //发送ajax请求检验用户名是否可用
                var empName = this.value;
                $.ajax({
                    url: "${APP_PATH}/checkUser",
                    data: "empName=" + empName,
                    type: "POST",
                    success: function (result) {
                        if (result.code == 200) {
                            //成功
                            show_validate_msg($("#empName_add_input"), "success", result.data.va_msg);
                            $("#emp_save_btn").attr("ajax-va", "success");
                        } else {
                            show_validate_msg($("#empName_add_input"), "error", result.data.va_msg);
                            $("#emp_save_btn").attr("ajax-va", "error");
                        }
                    }
                });
            });

            //1、按钮创建之前就绑定了，因此绑定不上
            //可以在创建按钮的时候创建，也可以使用live
            $(document).on("click", ".edit_btn", function () {
                // 1、查出员工信息
                getEmp($(this).attr("edit_id"));
                //2、查出部门信息并显示部门列表
                getDepts("#dept_update_select");
                // 3、弹出模态框,把员工的id传给更新按钮
                $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
                $("#emp_update_modal").modal({
                    backdrop: "static"
                });
            });
            //获取一个员工的信息
            function getEmp(id) {
                $.ajax({
                    url:"${APP_PATH}/getEmp/"+ id,
                    type:"GET",
                    success:function (result) {
                        //{"code":200,"msg":"处理成功","data":{"emp":{"empId":1,"empName":"c7b79","gender":"M","email":"c7b79@qq.com","dId":1,"dept":null}}}
                       var empData=result.data.emp;
                       $("#empName_update-static").text(empData.empName);
                       $("#email_update_input").val(empData.email);
                       $("input[name=gender]").val([empData.gender]);
                       $("#dept_update_select").val([empData.dId]);
                    }
                });
            }

            /**给更新添加单击事件
             *
             * 如果直接发送ajax =PUT形式的请求
             *封装的数据 Employee{empId=1, empName='null', gender='null', email='null', dId=null, dept=null}
             *问题：请求中有数据 但emploee封装不上
             *原因：
             * tomcat：
             * 1、将请求体中的数据，封装成一个Map
             * 2、request.getParameter("empname")就会从这个Map取值、
             *3、SpringMVC封装POJO对象时，会把pojo中的每个属性的值 ，request.getParameter("email")
             *PUT请求：请求体中的数据，request.getParameter()拿不到
             * Tomcat看到是PUT请求就不会封装，只有Post请求才封装
             *
             *要能支持直接发送PUT请求话要封装请求体中的数据
             * FormContentFilter
             * 作用:将请求体中的数据请求包装成map
             * request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
             */
            $("#emp_update_btn").click(function () {
                //1、验证邮箱是否合法
                var email = $("#email_update_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!regEmail.test(email)) {
                    show_validate_msg($("#email_update_input"), "eror", "邮箱格式不正确")
                    return false;
                } else {
                    show_validate_msg($("#email_update_input"), "success", "");
                }
                //2、发送ajax请求，保存修改后的信息  发送PUT请求
                $.ajax({
                    url:"${APP_PATH}/saveEmpWithUpdate/"+$(this).attr("edit_id"),
                    type:"PUT",
                    data:$("#emp_update_modal form").serialize(),
                    success:function (result) {
                        $("#emp_update_modal").modal('hide');
                        to_Page(currentPage);
                    }
                });

            });
        </script>
    </div>
</div>
</div>
</body>
</html>