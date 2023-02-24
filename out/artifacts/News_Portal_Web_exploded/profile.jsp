<%@ page import="java.util.ArrayList" %>
<%@ page import="db.*" %><%--
  Created by IntelliJ IDEA.
  User: aishazhumagul
  Date: 07.10.2022
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile Page</title>
    <%@include file="head.jsp" %>
</head>
<body>
<%
    Content content = (Content) request.getAttribute("content");
    ArrayList<Language> languages = (ArrayList<Language>) request.getAttribute("languages");
    ArrayList<Publication> publications = (ArrayList<db.Publication>) request.getAttribute("publications");
    Language currentLanguage = (Language) request.getAttribute("currentLanguage");
    User currentUser = (User) session.getAttribute("currentUser");
    //there will be an error if the current session will be manually deleted from cookies
    String currentPage = "/profile";
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12 mx-auto">
            <%@include file="navbar.jsp" %>
            <div class="row col-6 my-5 mx-auto">
                <div class="card text-bg-light p-0 shadow-lg bg-body rounded">
                    <div class="card-header p-3 mb-3 fs-5 fw-light ps-4"><%=content.getProfile()%>
                    </div>
                    <form action="/changePassword" method="post">
<%--                        <input type="hidden" value="<%=currentUser.getId()%>" name="user_id">--%>
                        <div class="card-body">
                            <div class="d-flex justify-content-between me-5 my-4">
                                <div class="ms-2 col-4"><%=content.getEmail()%>:</div>
                                <div class="col-8 fw-bold">
                                    <%=currentUser.getEmail()%>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between me-5 my-4">
                                <div class="ms-2 col-4"><%=content.getFull_name()%>:</div>
                                <div class="col-8 fw-bold">
                                    <%=currentUser.getFull_name()%>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between me-5 my-4">
                                <div class="ms-2 col-4"><%=content.getRole()%>:</div>
                                <div class="col-8 fw-bold">
                                    <%
                                        if(currentUser.getRole_id()==1){
                                            out.print("admin");
                                        }else if(currentUser.getRole_id()==2){
                                            out.print("user");
                                        }
                                    %>
                                </div>
                            </div>
                            <h5 class="text-center mt-5">Change Password</h5><br>
                            <%
                                String error = request.getParameter("error");
                                if(error!=null){
                                    if(error.equals("1")){
                            %>
                            <div class="alert alert-danger alert-dismissible fade show me-4 mb-4" role="alert">
                                Wrong old password was entered!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                    }else if(error.equals("2")){
                            %>
                            <div class="alert alert-danger alert-dismissible fade show me-4 mb-4" role="alert">
                                New password values do not match!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                    }
                                }
                            %>
                            <%
                                String passwordsuccess = request.getParameter("passwordsuccess");
                                if(passwordsuccess!=null){
                            %>
                            <div class="alert alert-success alert-dismissible fade show me-4 mb-4" role="alert">
                                Your password has successfully been updated!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                }
                            %>
                            <div class="d-flex justify-content-between me-5 mb-4">
                                <div class="ms-2 col-4">Old Password:</div>
                                <div class="col-8 fw-bold">
                                    <input class="form-control" type="password" name="old_password" required>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between me-5 mb-4">
                                <div class="ms-2 col-4">New Password:</div>
                                <div class="col-8 fw-bold">
                                    <input class="form-control" type="password" name="new_password" required>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between me-5 mb-4">
                                <div class="ms-2 col-4">Retype New Password:</div>
                                <div class="col-8 fw-bold">
                                    <input class="form-control" type="password" name="re_new_password" required>
                                </div>
                            </div>
                            <button class="btn btn-success offset-8 mt-3">UPDATE PASSWORD</button>
<%--                            <div class="d-flex justify-content-between mt-3 me-5">--%>
<%--                                <div class="ms-2 col-4"><%=content.getFull_name()%>--%>
<%--                                </div>--%>
<%--                                <div class="col-8">--%>
<%--                                    <input class="form-control" type="password" name="user_password">--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="d-flex justify-content-end mt-4 me-5">--%>
<%--                                <button class="btn btn-success btn-sm ms-2 mt-3 px-3 py-2 text-uppercase"><%=content.getLogin_btn()%>--%>
<%--                                </button>--%>
<%--                            </div>--%>
                        </div>
                    </form>
                </div>
            </div>
            <%@include file="footer.jsp" %>
        </div>
    </div>
</div>
</body>
</html>
