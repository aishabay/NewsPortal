package servlets;

import db.FrontManager;
import db.Language;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/changeLanguage")
public class ChangeLanguageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String language = FrontManager.getLanguage(name).getName();
        if(language!=null && name!=null){
            Cookie cookie = new Cookie("language", language);
            cookie.setMaxAge(3600*24*30);
            resp.addCookie(cookie);
        }
        String currentPage = req.getParameter("currentPage");
        resp.sendRedirect(currentPage);
    }
}
