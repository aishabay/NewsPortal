<%@ page import="db.User" %>
<%@ page import="db.Language" %>
<%@ page import="db.Publication" %>
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
                        <h2 class="ms-4 mt-3"><%=content.getPublications()%></h2>
<%--                        <a href="#" class="btn btn-success btn-sm mt-4 me-3 mb-3">ADD NEW</a>--%>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-success btn-sm mt-4 me-3 mb-3" data-bs-toggle="modal" data-bs-target="#add_new">
                            ADD NEW
                        </button>
                    </div>
                    <div class="p-3">
                        <table class="table table-striped col-10 border-top">
                            <thead>
                            <tr class="text-center">
                                <th class="col-1">ID</th>
                                <th class="col-1"><%=content.getName()%></th>
                                <th class="col-7"><%=content.getDescription()%></th>
                                <th class="col-1"><%=content.getRating()%></th>
                                <th class="col-2"><%=content.getOperations()%></th>
                            </tr>
                            </thead>
                            <%
                                for(Publication p:publications){
                            %>
                            <tr>
                                <td class="text-center"><%=p.getId()%></td>
                                <td class="text-center"><%=p.getName()%></td>
                                <td><%=p.getDescription()%></td>
                                <td class="text-center"><%=p.getRating()%></td>
                                <td class="text-center">
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editPublication<%=p.getId()%>">
                                        EDIT
                                    </button>
                                    <a href="#" class="btn btn-danger btn-sm ms-2">DELETE</a>
                                </td>
                            </tr>
                            <!-- Modal -->
                            <div class="modal fade" id="editPublication<%=p.getId()%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <form action="/editPublication" method="post">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="staticBackdropLabel1">Edit Publication</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <input type="hidden" name="publication_id" value="<%=p.getId()%>">
                                                NAME:<br><br>
                                                <input type="text" class="form-control" name="publication_name" required value="<%=p.getName()%>"><br>
                                                DESCRIPTION:<br><br>
                                                <textarea rows="4" class="form-control" name="publication_description" required><%=p.getDescription()%></textarea><br>
                                                RATING:<br><br>
                                                <input type="text" class="form-control" name="publication_rating" required value="<%=p.getRating()%>"><br>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button class="btn btn-success">Edit</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <%
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
    <div class="modal fade" id="add_new" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <form action="/publications" method="post">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Add New Publication</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body pt-4">
                        NAME:<br><br>
                        <input type="text" class="form-control" name="publication_name" required><br>
                        DESCRIPTION:<br><br>
                        <textarea rows="4" class="form-control" name="publication_description" required></textarea><br>
                        RATING:<br><br>
                        <input type="text" class="form-control" name="publication_rating" required><br>
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
