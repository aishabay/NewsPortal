<%@ page import="java.util.ArrayList" %>
<%@ page import="db.*" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: aishazhumagul
  Date: 05.10.2022
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Details Page</title>
    <%@include file="head.jsp"%>
    <style>
        a > img:hover{
            width: 60px;
            height: 60px;
        }
    </style>
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
        News newsDetails = (News) request.getAttribute("newsDetails");
        Language currentLanguage = (Language) request.getAttribute("currentLanguage");
    %>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12 mx-auto">
                <%@include file="navbar.jsp"%>
                <div class="row p-2 mt-3 rounded-2">
                    <div class="col-8 ps-4 pe-3 py-2">
                        <div class="border-bottom border-secondary border-1 p-2">
                            <h2><%=newsDetails.getTitle()%></h2>
                            <p><span class="text-secondary"><%=newsDetails.getPost_date()%></span> | <span class="text-primary"><%=newsDetails.getPublication().getName()%></span>
                            </p>
                        </div>
                        <div class="border-bottom border-secondary border-1 py-4">
                            <img src="<%=newsDetails.getPicture_url()%>"
                                 style="object-fit: cover;width: 100%;">
                        </div>
                        <div class="py-4 mt-3" style="font-size: 22px;">
                            <p class="fw-bold mb-4"><%=newsDetails.getShort_content()%></p>
                            <p class="text-secondary"><%=newsDetails.getContent()%></p>
                        </div>
                    </div>
                    <div class="col-4 px-4 py-2">
                        <div class="bg-info p-4 rounded-2 text-light">
                            <h3 class="fst-italic mb-4">About <%=newsDetails.getPublication().getName()%></h3>
                            <p><%=newsDetails.getPublication().getDescription()%></p>
                            <h5 class="mt-4">Rating: <%=newsDetails.getPublication().getRating()%></h5>
                        </div>
                        <div class="bg-light p-4 rounded-2 text-primary mt-5">
                            <h3 class="fst-italic mb-3 text-dark">Archives</h3>
                            <div class="d-flex flex-column">
                                <a href="#" style="text-decoration: none;">October 2022</a>
                                <a href="#" style="text-decoration: none;">September 2022</a>
                                <a href="#" style="text-decoration: none;">August 2022</a>
                                <a href="#" style="text-decoration: none;">July 2022</a>
                                <a href="#" style="text-decoration: none;">June 2022</a>
                                <a href="#" style="text-decoration: none;">May 2022</a>
                                <a href="#" style="text-decoration: none;">April 2022</a>
                                <a href="#" style="text-decoration: none;">March 2022</a>
                                <a href="#" style="text-decoration: none;">February 2022</a>
                            </div>
                        </div>
                        <div class="bg-light p-4 rounded-2 text-primary mt-5">
                            <h3 class="fst-italic mb-4 text-dark">Follow us</h3>
                            <div class="d-flex flex-row justify-content-around">
                                <a href="https://www.instagram.com/" target="_blank" style="text-decoration: none;">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/9/95/Instagram_logo_2022.svg"
                                    width="50px" height="50px" style="object-fit: contain;">
                                </a>
                                <a href="https://twitter.com/?lang=en" target="_blank" style="text-decoration: none;">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Twitter-logo.svg/800px-Twitter-logo.svg.png"
                                         width="50px" height="50px" style="object-fit: contain;">
                                </a>
                                <a href="https://www.facebook.com/" target="_blank" style="text-decoration: none;">
                                    <img src="https://theacademy.la/wp-content/uploads/2017/04/facebook-logo-png-transparent-background.png"
                                         width="50px" height="50px" style="object-fit: contain;">
                                </a>
                                <a href="https://vk.com/" target="_blank" style="text-decoration: none;">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/VK_Compact_Logo_%282021-present%29.svg/1200px-VK_Compact_Logo_%282021-present%29.svg.png"
                                         width="50px" height="50px" style="object-fit: contain;">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row col-8 mx-auto bg-light mb-5 p-3 rounded-4">
                    <%
                        if(currentUser!=null){
                    %>
                    <form action="/addComment" method="post">
                        <input type="hidden" value="<%=newsDetails.getId()%>" name="news_id">
                        <div class="col-12 d-flex align-items-center">
                            <div class="col-11">
                                <textarea class="form-control me-5 rounded-5 p-4 mt-3" name="comment" rows="1" placeholder="Enter your comment..."
                                style="min-height: 74px;"></textarea>
                            </div>
                            <div class="col-1 m-0">
                                <button class="btn btn-lg fs-2 text-secondary">&#10148;</button>
                            </div>
                        </div>
                    </form>
                    <%
                        }
                    %>
                    <%
                        ArrayList<Comment> comments = (ArrayList<Comment>) request.getAttribute("comments");
                        if(comments!=null){
                            int count_comments = comments.size();
                    %>
                    <h4 class="mt-3 mb-4">Comments (<%=count_comments %>):</h4>
                    <div class="list-group mb-4">
                        <%
                            for(Comment c:comments){
                        %>
                            <a href="JavaScript:void(0)" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1"><%=c.getUser().getFull_name()%></h5>
                                    <small class="text-muted">
                                        <%
                                            String time = new SimpleDateFormat("dd.MM.yyyy HH:mm").format(c.getPostDate());
                                            out.print(time);
                                        %>
                                    </small>
                                </div>
                                <p class="mb-1 mt-2"><%=c.getComment()%></p>
                                <%
                                    if(currentUser!=null && currentUser.getId() == c.getUser().getId()){
                                %>
                                <div class="mt-2 d-flex justify-content-end">
                                    <button type="button" class="btn btn-sm me-2 fs-3" onclick="editModalOpen(<%=c.getId()%>, '<%=c.getComment()%>', '<%=c.getUser().getFull_name()%>', <%=c.getNews().getId()%>)">
                                        &#9998;
                                    </button>
                                    <button type="button" class="btn btn-sm fs-5" onclick="deleteModalOpen(<%=c.getId()%>, <%=c.getNews().getId()%>)">
                                        &#10060;
                                    </button>
                                </div>

                                <%
                                   }
                                %>
                            </a>
                    <%
                            }
                    %>
                        <script type="text/javascript">

                            function editModalOpen(commentId, commentText, userFullName, newsId){
                                const myEditModal = new bootstrap.Modal('#editCommentModal', {backdrop: true});
                                document.getElementById("edit_comment_text_value").value = commentText;
                                document.getElementById("edit_news_comment_id").value = commentId;
                                document.getElementById("comment_author").innerText = "Edit Comment by "+userFullName;
                                document.getElementById("edited_comment_news_id").value = newsId;
                                myEditModal.show();
                            }
                            function deleteModalOpen(commentId, newsId){
                                const myDeleteModal = new bootstrap.Modal('#deleteCommentModal', {backdrop: true});
                                document.getElementById("deleted_comment_id").value = commentId;
                                document.getElementById("deleted_comment_news_id").value = newsId;
                                myDeleteModal.show();
                            }
                        </script>

                        <div class="modal fade" id="editCommentModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <form action="/editComment" method="post">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 id="comment_author" class="modal-title fs-5">EDIT COMMENT</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="edited_comment_news_id" id="edited_comment_news_id">
                                            <input type="hidden" name="edited_comment_id" id = "edit_news_comment_id">
                                            <textarea class="form-control me-5 mt-3" name="edited_comment" rows="10"
                                                      style="min-height: 74px;" id = "edit_comment_text_value"></textarea>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button class="btn btn-success">Edit</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="modal fade" id="deleteCommentModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <form action="/deleteComment" method="post">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5">Are you sure that you want to delete this comment?</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="deleted_comment_news_id" id="deleted_comment_news_id">
                                            <input type="hidden" name="deleted_comment_id" id="deleted_comment_id">
                                            This action is irreversible!
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button class="btn btn-danger">Delete</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    <%
                        }
                    %>
                    </div>
                </div>
                <%@include file="footer.jsp"%>
            </div>
        </div>
    </div>
</body>
</html>
