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
    <title>Login Page</title>
    <%@include file="head.jsp" %>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
        Content content = (Content) request.getAttribute("content");
        ArrayList<Language> languages = (ArrayList<Language>) request.getAttribute("languages");
        ArrayList<Publication> publications = (ArrayList<Publication>) request.getAttribute("publications");
        Language currentLanguage = (Language) request.getAttribute("currentLanguage");
        String currentPage = "/login";
    %>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12 mx-auto">
                <%@include file="navbar.jsp" %>
                <div class="row col-6 my-5 mx-auto">
                    <div class="card text-bg-light p-0 shadow-lg bg-body rounded">
                        <div class="card-header p-3 mb-3 fs-5 fw-light ps-4"><%=content.getLogin_btn()%>
                        </div>
                        <form action="/login" method="post">
                            <div class="card-body">
                                <div class="d-flex justify-content-between me-5 my-4">
                                    <div class="ms-2 col-4"><%=content.getEmail()%>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-control" type="email" name="user_email">
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between mt-3 me-5">
                                    <div class="ms-2 col-4"><%=content.getPassword()%>
                                    </div>
                                    <div class="col-8">
                                        <input class="form-control" type="password" name="user_password">
                                    </div>
                                </div>
                                <div class="d-flex justify-content-end mt-4 me-5">
                                    <button class="btn btn-success btn-sm ms-2 mt-3 px-3 py-2 text-uppercase"><%=content.getLogin_btn()%>
                                    </button>
                                </div>
                                <%
                                    String failure = request.getParameter("failure");
                                    if (failure != null) {
                                %>
                                <div class="alert alert-danger alert-dismissible fade show mt-5" role="alert">
                                    Incorrect <b>email</b> and/or <b>password</b>!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
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
