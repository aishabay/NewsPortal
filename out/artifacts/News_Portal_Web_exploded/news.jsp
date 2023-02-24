<%@ page import="java.util.ArrayList" %>
<%@ page import="db.*" %><%--
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
      ArrayList<News> news = (ArrayList<News>) request.getAttribute("news");
      ArrayList<Publication> publications = (ArrayList<Publication>) request.getAttribute("publications");
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
                    <div class="d-flex justify-content-between">
                        <h2 class="ms-4 mt-3"><%=content.getNews()%></h2>
                        <button type="button" class="btn btn-success btn-sm mt-4 me-3 mb-3" data-bs-toggle="modal" data-bs-target="#add_new">
                            ADD NEW
                        </button>
                    </div>
                    <div class="p-3">
                        <table class="table table-striped col-10 text-center border-top">
                            <thead>
                            <tr>
                                <th class="col-1">ID</th>
                                <th class="col-4"><%=content.getTitle()%></th>
                                <th class="col-1"><%=content.getLanguage()%></th>
                                <th class="col-2"><%=content.getRelease_date()%></th>
                                <th class="col-1"><%=content.getPublication()%></th>
                                <th class="col-1"><%=content.getDetails()%></th>
                                <th class="col-2"><%=content.getOperations()%></th>
                            </tr>
                            </thead>
                            <%
                                if(news!=null){
                                for(News n:news){
                            %>
                            <tr>
                                <td><%=n.getId()%></td>
                                <td><%=n.getTitle()%></td>
                                <td><%=n.getLanguage().getName()%></td>
                                <td><%=n.getPost_date()%></td>
                                <td><%=n.getPublication().getName()%></td>
                                <td><a href="#" class="btn btn-primary btn-sm">DETAILS</a></td>
                                <td>
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editNews<%=n.getId()%>">
                                        EDIT
                                    </button>
                                    <a href="#" class="btn btn-danger btn-sm ms-2">DELETE</a>
                                </td>
                            </tr>
                            <!-- Modal -->
                            <div class="modal fade" id="editNews<%=n.getId()%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <form action="/editNews" method="post">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="staticBackdropLabel">Add New News</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body pt-4">
                                                <input type="hidden" name="news_id" value="<%=n.getId()%>">
                                                TITLE:<br><br>
                                                <input type="text" class="form-control" name="news_title" value="<%=n.getTitle()%>"><br>
                                                SHORT CONTENT:<br><br>
                                                <textarea class="form-control" name="news_short_content" rows="4"><%=n.getShort_content()%></textarea><br>
                                                CONTENT:<br><br>
                                                <textarea class="form-control" name="news_content" rows="6"><%=n.getContent()%></textarea><br>
                                                LANGUAGE:<br><br>
                                                <select class="form-select" name="news_language">
                                                    <%
                                                        for(Language l:languages){
                                                    %>
                                                    <option
                                                            <% if(n.getLanguage().getName().equals(l.getName())) out.print("selected"); %>
                                                            value="<%=l.getId()%>"><%=l.getName()%>
                                                    </option>
                                                    <%
                                                        }
                                                    %>
                                                </select><br>
                                                PUBLICATION:<br><br>
                                                <select class="form-select" name="news_publication">
                                                    <%
                                                        for(Publication p:publications){
                                                    %>
                                                    <option
                                                            <% if(n.getPublication().getName().equals(p.getName())) out.print("selected"); %>
                                                            value="<%=p.getId()%>"><%=p.getName()%>
                                                    </option>
                                                    <%
                                                        }
                                                    %>
                                                </select><br>
                                                PICTURE URL:<br><br>
                                                <input type="text" class="form-control" name="news_picture_url" value="<%=n.getPicture_url()%>"><br>
                                                RELEASE DATE:<br><br>
                                                <input type="date" class="form-control" name="news_release_date" value="<%=n.getPost_date()%>"><br>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button class="btn btn-success">Add</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <%
                                }
                                }
                            %>
                        </table>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="add_new" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <form action="/news" method="post">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel1">Add New News</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body pt-4">
                        TITLE:<br><br>
                        <input type="text" class="form-control" name="news_title" required><br>
                        SHORT CONTENT:<br><br>
                        <textarea class="form-control" name="news_short_content" required rows="4"></textarea><br>
                        CONTENT:<br><br>
                        <textarea class="form-control" name="news_content" required rows="6"></textarea><br>
                        LANGUAGE:<br><br>
                        <select class="form-select" name="news_language">
                            <%
                                for(Language l:languages){
                            %>
                            <option value="<%=l.getId()%>"><%=l.getName()%></option>
                            <%
                                }
                            %>
                        </select><br>
                        PUBLICATION:<br><br>
                        <select class="form-select" name="news_publication">
                            <%
                                for(Publication p:publications){
                            %>
                            <option value="<%=p.getId()%>"><%=p.getName()%></option>
                            <%
                                }
                            %>
                        </select><br>
                        PICTURE URL:<br><br>
                        <input type="text" class="form-control" name="news_picture_url" required><br>
                        RELEASE DATE:<br><br>
                        <input type="date" class="form-control" name="news_release_date" required><br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button class="btn btn-success">Add</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
