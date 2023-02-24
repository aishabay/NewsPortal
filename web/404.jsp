<%@ page import="db.Language" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.Content" %><%--
  Created by IntelliJ IDEA.
  User: aishazhumagul
  Date: 07.10.2022
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error Page</title>
    <%@include file="head.jsp"%>
</head>
<body>
    <%
      Content content = (Content) request.getAttribute("content");
      ArrayList<Language> languages = (ArrayList<Language>) request.getAttribute("languages");
      Language currentLanguage = (Language) request.getAttribute("currentLanguage");
      String currentPage = "/login";
    %>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-12 mx-auto">
          <%@include file="navbar.jsp"%>
          <div class="row col-6 my-5 mx-auto">
              <h1 class="display-1 text-center">404: PAGE NOT FOUND</h1>
          </div>
          <%@include file="footer.jsp"%>
        </div>
      </div>
    </div>
</body>
</html>
