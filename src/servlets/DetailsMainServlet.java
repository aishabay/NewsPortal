package servlets;

import db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Optional;

@WebServlet(value="/detailsMain")
public class DetailsMainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        ArrayList<Publication> publications = DBManager.getAllPublications();

        ArrayList<News> news = DBManager.getAllNews(currentLanguage_id);
        Publication publication = null;
        String currentPage = "/main";

        String publication_id = req.getParameter("publication_id");
        if(publication_id!=null){
            publication = DBManager.getPublication(Integer.parseInt(publication_id));
            news = DBManager.getAllNews(publication, currentLanguage_id);
            currentPage = "/main?publication_id=" + publication_id;
        }

        String id = req.getParameter("id");
        int news_id = 0;
        News newsDetails = null;
        ArrayList<Comment> comments = null;
        if(id!=null){
            news_id = Integer.parseInt(id);
            newsDetails = DBManager.getNews(news_id);
            comments = DBManager.getAllComments(news_id);
        }

        req.setAttribute("comments",comments);
        req.setAttribute("newsDetails", newsDetails);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("currentLanguage", currentLanguageObj);
        req.setAttribute("content", content);
        req.setAttribute("languages", languages);
        req.setAttribute("publications", publications);
        req.setAttribute("news", news);

        req.getRequestDispatcher("/detailsMain.jsp").forward(req,resp);
    }
}
