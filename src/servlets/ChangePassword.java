package servlets;

import db.DBManager;
import db.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value="/changePassword")
public class ChangePassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String redirect = "/login";
//        int user_id = Integer.parseInt(req.getParameter("user_id"));
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if(currentUser!=null){
            redirect = "/profile?error=1";
            String old_password = req.getParameter("old_password");
            String new_password = req.getParameter("new_password");
            String re_new_password = req.getParameter("re_new_password");
            if(old_password.equals(currentUser.getPassword())){
                redirect = "profile?error=2";
                if(new_password.equals(re_new_password)){
                    currentUser.setPassword(new_password);
                    if(DBManager.updateUser(currentUser)){
                        redirect = "/profile?passwordsuccess";
                    }
                }
            }
        }
        resp.sendRedirect(redirect);
    }
}
