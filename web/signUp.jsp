<%@ page import="db.Language" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.Content" %>
<%@ page import="db.Publication" %><%--
  Created by IntelliJ IDEA.
  User: aishazhumagul
  Date: 07.10.2022
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up Page</title>
    <%@include file="head.jsp" %>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    Content content = (Content) request.getAttribute("content");
    ArrayList<Language> languages = (ArrayList<Language>) request.getAttribute("languages");
    ArrayList<Publication> publications = (ArrayList<Publication>) request.getAttribute("publications");
    Language currentLanguage = (Language) request.getAttribute("currentLanguage");
    String currentPage = "/signUp";
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12 mx-auto">
            <%@include file="navbar.jsp" %>
            <div class="row col-7 my-5 mx-auto">
                <div class="card text-bg-light p-0 shadow-lg bg-body rounded">
                    <div class="card-header p-3 mb-3 fs-5 fw-light ps-4"><%=content.getRegistration()%></div>
                    <form action="/signUp" method="post">
                        <div class="card-body">
                            <div class="d-flex justify-content-between me-5">
                                <div class="ms-2 col-4"><%=content.getFull_name()%></div>
                                <div class="col-8">
                                    <input class="form-control" type="text" name="user_full_name">
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mt-3 me-5">
                                <div class="ms-2 col-4"><%=content.getEmail()%></div>
                                <div class="col-8">
                                    <input class="form-control" type="email" name="user_email">
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mt-3 me-5">
                                <div class="ms-2 col-4"><%=content.getPassword()%></div>
                                <div class="col-8">
                                    <input class="form-control" type="password" name="user_password">
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mt-3 me-5">
                                <div class="ms-2 col-4"><%=content.getRetype_password()%></div>
                                <div class="col-8">
                                    <input class="form-control" type="password" name="user_repassword">
                                </div>
                            </div>
                            <div class="d-flex justify-content-end mt-3 me-5">
                                <button class="btn btn-success btn-sm ms-2 mt-3 px-3 py-2 text-uppercase"><%=content.getSign_up_btn()%></button>
                            </div>
                            <%
                                String email_error = request.getParameter("email_error");
                                if(email_error!=null){
                            %>
                            <div class="alert alert-danger alert-dismissible fade show mt-5" role="alert">
                                This <b>email</b> has already been registered!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                }
                            %>
                            <%
                                String password_error = request.getParameter("password_error");
                                if(password_error!=null){
                            %>
                            <div class="alert alert-danger alert-dismissible fade show mt-5" role="alert">
                                Entered <b>password</b> values do not match!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                }
                            %>
                            <%
                                String success = request.getParameter("success");
                                if(password_error==null && email_error==null && success!=null){
                            %>
                            <div class="alert alert-success alert-dismissible fade show mt-5" role="alert">
                                You have been registered successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                }
                            %>
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
