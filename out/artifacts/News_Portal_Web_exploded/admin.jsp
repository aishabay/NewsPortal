<%@ page import="db.User" %>
<%@ page import="db.Content" %>
<%@ page import="db.User" %>
<%@ page import="db.Language" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: aishazhumagul
  Date: 10.10.2022
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Page</title>
    <%@include file="head.jsp" %>
</head>
<body>
    <%
      User currentUser = (User) session.getAttribute("currentUser");
      Content content = (Content) request.getAttribute("content");
      ArrayList<Language> languages = (ArrayList<Language>) request.getAttribute("languages");
      ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
      Language currentLanguage = (Language) request.getAttribute("currentLanguage");
      String currentPage = "/admin";
    %>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-12 mx-auto">
            <div class="d-flex justify-content-between align-items-center bg-dark text-center mt-3">
                <div class="col-3 border-end border-secondary py-3">
                    <a href="/main" style="text-decoration: none;">
                        <h6 class="d-inline text-light col-4">
                            <%=content.getHeader_heading()%>
                        </h6>
                    </a>
                </div>
                <div class="col-8"></div>
                <div class="col-1">
                    <a class="btn btn btn-dark text-secondary border-secondary" href="/logout"><%=content.getLog_out()%></a>
                </div>
            </div>
            <div class="d-flex justify-content-between bg-light" style="min-height: 90vh;">
                <div class="col-3 border-end border-secondary py-4">
                    <a href="/admin" style="text-decoration: none;">
                        <p class="text-dark col-4 fw-bold text-uppercase ms-5">
                            <%=content.getAdmin_panel()%>
                        </p>
                    </a>
                    <a href="/users" style="text-decoration: none;">
                        <p class="text-dark col-4 fw-bold my-4 ms-5">
                            <%=content.getUsers()%>
                        </p>
                    </a>
                    <a href="/languages" style="text-decoration: none;">
                        <p class="text-dark col-4 fw-bold my-4 ms-5">
                            <%=content.getLanguages()%>
                        </p>
                    </a>
                    <a href="/publications" style="text-decoration: none;">
                        <p class="text-dark col-4 fw-bold my-4 ms-5">
                            <%=content.getPublications()%>
                        </p>
                    </a>
                    <a href="/news" style="text-decoration: none;">
                        <p class="text-dark col-4 fw-bold my-4 ms-5">
                            <%=content.getNews()%>
                        </p>
                    </a>
                </div>
                <div class="col-9">
                    <div class="mt-4">
                        <h2 class="ms-4 mt-3 text-center"><%=content.getWelcome()%></h2>
                        <h3 class="ms-4 mt-5"><%=content.getIntro()%></h3>
                        <h3 class="ms-4 mt-5 text-danger"><%=content.getWarning()%></h3>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
</body>
</html>
