<%@ page import="db.User" %>
<div class="d-flex justify-content-between align-items-center p-4 text-center">
    <div class="col-3 d-flex justify-content-start text-secondary">
        <%
            if(languages!=null){
                for(Language l:languages){
        %>
            <a class="btn text-secondary" href="/changeLanguage?name=<%=l.getName()%>&currentPage=<%=currentPage%>"><%=l.getCode()%></a>
        <%
                }
            }
        %>
    </div>
    <div class="col-6 mb-2">
        <a href="/main" style="text-decoration: none;">
            <h1 class="d-inline text-danger col-4 fs-1">
                <%=content.getHeader_heading()%>
            </h1>
        </a>
    </div>
    <div class="col-3 d-flex align-items-center justify-content-end">
        <div class="text-secondary me-4" style="-webkit-transform: rotate(45deg);
               -moz-transform: rotate(45deg);
                 -o-transform: rotate(45deg);
                    transform: rotate(45deg);
                    font-size: 32px;">
            &#9906;
        </div>
        <%
            if(currentUser==null){
        %>
        <a class="btn btn btn-light text-secondary border-secondary me-2" href="/login"><%=content.getLogin_btn()%></a>
        <a class="btn btn btn-light text-secondary border-secondary" href="/signUp"><%=content.getSign_up_btn()%></a>
        <%
            }else{
                if(currentUser.getRole_id()==1){
        %>
        <a class="btn btn btn-light text-secondary border-secondary me-2" href="/admin"><%=content.getAdmin_panel()%></a>
        <%
                }
        %>
        <a class="btn btn btn-light text-secondary border-secondary me-2" href="/profile"><%=content.getProfile()%></a>
        <a class="btn btn btn-light text-secondary border-secondary" href="/logout"><%=content.getLog_out()%></a>
        <%
            }
        %>
    </div>
</div>
<nav class="navbar navbar-expand-xl navbar-dark bg-dark fw-bold rounded-2 p-2 fs-5">
    <div class="container-fluid">
<%--        <a class="navbar-brand" href="#">Navbar</a>--%>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mb-2 mb-lg-0 d-flex justify-content-between mx-auto">
                <%
                    for(Publication p:publications){
                %>
                <li class="nav-item px-3">
<%--                    <% currentPage = "/main?publication_id="+p.getId();%>--%>
                    <a class="nav-link active" href="/main?publication_id=<%=p.getId()%>"><%=p.getName()%></a>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>
