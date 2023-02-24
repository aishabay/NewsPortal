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

@WebServlet(value="/signUp")
public class SignUpServlet extends HttpServlet {
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

        req.setAttribute("publications", publications);
        req.setAttribute("currentLanguage", currentLanguageObj);
        req.setAttribute("content", content);
        req.setAttribute("languages", languages);

        req.getRequestDispatcher("/signUp.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArrayList<User> users = DBManager.getAllUsers();

        String full_name = req.getParameter("user_full_name");
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");
        String repassword = req.getParameter("user_repassword");

        String email_error = "false";
        String password_error = "false";

        for(User u:users){
            if(u.getEmail().equals(email)){
                email_error = "true";
            }
        }
        if(!password.equals(repassword)){
            password_error = "true";
        }
        if(password_error.equals("true") && email_error.equals("true")){
            resp.sendRedirect("/signUp?email_error&password_error");
        }else if(password_error.equals("false") && email_error.equals("true")){
            resp.sendRedirect("/signUp?email_error");
        }else if(password_error.equals("true") && email_error.equals("false")){
            resp.sendRedirect("/signUp?password_error");
        }else{
            User user = new User();
            user.setFull_name(full_name);
            user.setEmail(email);
            user.setPassword(password);
            DBManager.addUser(user);
            resp.sendRedirect("/signUp?success");
        }
    }
}
