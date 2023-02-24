package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Optional;

@WebServlet(value="/news")
public class NewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String currentLanguage = "english";
        int currentLanguage_id = 1;
        Language currentLanguageObj = FrontManager.getLanguage(currentLanguage);

        Cookie[] cookies = req.getCookies();
        if(cookies!=null) {
            Optional<Cookie> opt = Arrays.stream(cookies)
                    .filter(cook -> cook.getName().equals("language"))
                    .findFirst();

            if (!opt.isEmpty()) {
                currentLanguage = opt.get().getValue();
                currentLanguageObj = FrontManager.getLanguage(currentLanguage);
                currentLanguage_id = currentLanguageObj.getId();
            }
        }

        Content content = FrontManager.getContent(currentLanguage_id);
        ArrayList<Language> languages = FrontManager.getAllLanguages();
        ArrayList<News> news = DBManager.getAllNews();
        ArrayList<Publication> publications = DBManager.getAllPublications();

        req.setAttribute("currentLanguage", currentLanguageObj);
        req.setAttribute("content", content);
        req.setAttribute("languages", languages);
        req.setAttribute("news",news);
        req.setAttribute("publications",publications);

        req.getRequestDispatcher("news.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
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
        news.setTitle(title);
        news.setShort_content(short_content);
        news.setContent(content);
        news.setLanguage(language);
        news.setPost_date(release_date);
        news.setPicture_url(picture_url);
        news.setPublication(publication);

        DBManager.addNews(news);

        resp.sendRedirect("/news");
    }
}
