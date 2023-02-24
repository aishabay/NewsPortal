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

@WebServlet(value="/publications")
public class PublicationsServlet extends HttpServlet {
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
        ArrayList<Publication> publications = DBManager.getAllPublications();

        req.setAttribute("currentLanguage", currentLanguageObj);
        req.setAttribute("content", content);
        req.setAttribute("languages", languages);
        req.setAttribute("publications",publications);

        req.getRequestDispatcher("publications.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("publication_name");
        String description = req.getParameter("publication_description");
        Double rating = Double.parseDouble(req.getParameter("publication_rating"));

        Publication publication = new Publication();
        publication.setName(name);
        publication.setDescription(description);
        publication.setRating(rating);

        DBManager.addPublication(publication);

        resp.sendRedirect("/publications");
    }
}
