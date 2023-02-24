package servlets;

import db.DBManager;
import db.Publication;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value="/editPublication")
public class EditPublicationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(req.getParameter("publication_id"));
        String name = req.getParameter("publication_name");
        String description = req.getParameter("publication_description");
        Double rating = Double.parseDouble(req.getParameter("publication_rating"));

        Publication publication = new Publication();
        publication.setId(id);
        publication.setName(name);
        publication.setDescription(description);
        publication.setRating(rating);

        DBManager.editPublication(publication);

        resp.sendRedirect("/publications");
    }
}
