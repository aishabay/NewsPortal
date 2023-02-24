package servlets;

import db.Comment;
import db.DBManager;
import db.News;
import db.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value="/editComment")
public class EditCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if(currentUser!=null){
            int news_id = Integer.parseInt(req.getParameter("edited_comment_news_id"));
            News news = DBManager.getNews(news_id);
            String edited_comment = req.getParameter("edited_comment");
            int edited_comment_id = Integer.parseInt(req.getParameter("edited_comment_id"));
            Comment comment = DBManager.getComment(edited_comment_id);
            if(news!=null && comment!=null){
                comment.setComment(edited_comment);
                DBManager.editComment(comment);
            }
            resp.sendRedirect("/detailsMain?id="+news_id);
        }else{
            resp.sendRedirect("/login");
        }
    }
}
