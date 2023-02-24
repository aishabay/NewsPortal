package servlets;

import db.Comment;
import db.DBManager;
import db.News;
import db.User;
import util.HtmlEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value="/addComment")
public class AddCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if(currentUser!=null){
            String comment = req.getParameter("comment");
            int news_id = Integer.parseInt(req.getParameter("news_id"));
            News news = DBManager.getNews(news_id);
            if(news!=null){
                Comment commentObj = new Comment();
                commentObj.setComment(HtmlEncoder.encodeAll(comment));
                commentObj.setNews(news);
                commentObj.setUser(currentUser);
                DBManager.addComment(commentObj);
                resp.sendRedirect("/detailsMain?id="+news_id);
            }
        }else{
            resp.sendRedirect("/login");
        }
    }
}
