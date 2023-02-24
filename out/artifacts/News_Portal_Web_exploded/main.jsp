<%@ page import="java.util.ArrayList" %>
<%@ page import="db.*" %><%--
  Created by IntelliJ IDEA.
  User: aishazhumagul
  Date: 05.10.2022
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Main Page</title>
    <%@include file="head.jsp"%>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
//        String currentPage = "/main";
        String currentPage = (String) request.getAttribute("currentPage");
        Content content = (Content) request.getAttribute("content");
        ArrayList<Language> languages = (ArrayList<Language>) request.getAttribute("languages");
        ArrayList<Publication> publications = (ArrayList<Publication>) request.getAttribute("publications");
        ArrayList<News> news = (ArrayList<News>) request.getAttribute("news");
        Language currentLanguage = (Language) request.getAttribute("currentLanguage");
    %>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12 mx-auto">
                <%@include file="navbar.jsp"%>
                <div class="bg-info text-light fw-light p-5 mt-3 rounded-2">
                    <p class="fst-italic" style="font-size:50px;"><%=content.getPoster_heading()%></p>
                    <p class="fs-5"><%=content.getPoster_text()%></p>
                </div>
                <div class="row gx-4 row-cols-2 d-flex justify-content-between mt-2 mx-5" style="min-height: 34vh;">
                    <%
                        for(News n:news){
                    %>
                    <div class="card col-5 m-4 d-flex justify-content-around">
                        <img src="<%=n.getPicture_url()%>" class="card-img-top mt-2" alt="...">
                        <div class="card-body">
                            <a href="#" class="btn p-0 my-3 text-primary fw-bold"><%=n.getPublication().getName()%></a>
                            <h5 class="card-title mb-0"><%=n.getTitle()%></h5>
                            <p class="text-secondary mt-0"><%=n.getPost_date()%></p>
                            <p class="card-text"><%=n.getShort_content()%></p>
                            <a href="/detailsMain?id=<%=n.getId()%>" class="btn p-0 mb-3 text-primary fw-light"><%=content.getRead_more()%></a>
                        </div>
                    </div>
                    <%
                        }
                    %>
<%--                    <div class="card col-5 m-4 d-flex justify-content-around">--%>
<%--                        <img src="https://i.picsum.photos/id/120/4928/3264.jpg?hmac=i-8mkfKj_gRyQt9ZJVhbIBXbtIBNcsbI_gwNe_39vus" class="card-img-top mt-2" alt="...">--%>
<%--                        <div class="card-body">--%>
<%--                            <a href="#" class="btn p-0 my-3 text-primary fw-bold">BBC</a>--%>
<%--                            <h5 class="card-title mb-0">Mortgage rates still rising as big lenders revise deals</h5>--%>
<%--                            <p class="text-secondary mt-0">22.09.2020</p>--%>
<%--                            <p class="card-text">The UK's biggest mortgage lender will raise rates on Wednesday as the cost of new fixed rate deals keeps climbing.</p>--%>
<%--                            <a href="#" class="btn p-0 mb-3 text-primary fw-light"><%=content.getRead_more()%></a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </div>
                <%@include file="footer.jsp"%>
            </div>
        </div>
    </div>
</body>
</html>
