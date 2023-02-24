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

@WebServlet(value="/admin")
public class AdminServlet extends HttpServlet {
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
        ArrayList<User> users = DBManager.getAllUsers();

        req.setAttribute("currentLanguage", currentLanguageObj);
        req.setAttribute("content", content);
        req.setAttribute("languages", languages);
        req.setAttribute("users",users);

        req.getRequestDispatcher("admin.jsp").forward(req,resp);
    }
}
