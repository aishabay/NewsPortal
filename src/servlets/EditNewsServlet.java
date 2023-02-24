package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value="/editNews")
public class EditNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(req.getParameter("news_id"));
        String title = req.getParameter("news_title");
        String short_content = req.getParameter("news_short_content");
        String content = req.getParameter("news_content");
        int language_id = Integer.parseInt(req.getParameter("news_language"));
        Language language = FrontManager.getLanguage(language_id);
        String release_date = req.getParameter("news_release_date");
        int publication_id = Integer.parseInt(req.getParameter("news_publication"));
        Publication publication = DBManager.getPublication(publication_id);
        String picture_url = req.getParameter("news_picture_url");

        News news = new News();
        news.setId(id);
        news.setTitle(title);
        news.setShort_content(short_content);
        news.setContent(content);
        news.setLanguage(language);
        news.setPost_date(release_date);
        news.setPicture_url(picture_url);
        news.setPublication(publication);

        System.out.println(news.getTitle());
        System.out.println(news.getPublication().getName());
        System.out.println(news.getLanguage().getName());

        DBManager.editNews(news);

        resp.sendRedirect("/news");
    }
}
