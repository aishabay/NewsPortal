package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DBManager {
    private static Connection connection;
    static{
        try{
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5433/news_portal",
                    "postgres","postgres"
            );
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public static ArrayList<User> getAllUsers(){
        ArrayList<User> users = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_users");
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setFull_name(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setRole_id(resultSet.getInt("role_id"));
                users.add(user);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return users;
    }

    public static void addUser(User user){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "insert into t_users (email, password, full_name) " +
                    "values (?,?,?)");
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getFull_name());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static User getUser(String email){
        User user = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_users where email = ?");
            statement.setString(1,email);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setEmail(email);
                user.setPassword(resultSet.getString("password"));
                user.setFull_name(resultSet.getString("full_name"));
                user.setRole_id(resultSet.getInt("role_id"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }
    public static User getUser(int id){
        User user = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_users where id = ?");
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                user = new User();
                user.setId(id);
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setFull_name(resultSet.getString("full_name"));
                user.setRole_id(resultSet.getInt("role_id"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }

    public static boolean updateUser(User user){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "update t_users set password = ? where id = ?");
            statement.setString(1,user.getPassword());
            statement.setInt(2,user.getId());

            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows > 0;
    }

    public static ArrayList<Publication> getAllPublications(){
        ArrayList<Publication> publications = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_publications");
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                Publication p = new Publication();
                p.setId(resultSet.getInt("id"));
                p.setName(resultSet.getString("name"));
                p.setDescription(resultSet.getString("description"));
                p.setRating(resultSet.getDouble("rating"));
                publications.add(p);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return publications;
    }

    public static Publication getPublication(int id){
        Publication publication = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_publications " +
                    "where id = ?");
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                publication = new Publication();
                publication.setId(resultSet.getInt("id"));
                publication.setName(resultSet.getString("name"));
                publication.setDescription(resultSet.getString("description"));
                publication.setRating(resultSet.getDouble("rating"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return publication;
    }

    public static void addPublication(Publication publication){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "insert into t_publications (name, description, rating) "+
                    "values (?,?,?)");
            statement.setString(1,publication.getName());
            statement.setString(2,publication.getDescription());
            statement.setDouble(3,publication.getRating());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void editPublication(Publication publication){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "update t_publications set name = ?, description = ?, rating = ? " +
                    "where id = ?");
            statement.setString(1,publication.getName());
            statement.setString(2,publication.getDescription());
            statement.setDouble(3,publication.getRating());
            statement.setInt(4,publication.getId());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static ArrayList<News> getAllNews(){
        ArrayList<News> news = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select n.id,\n" +
                    "       n.title,\n" +
                    "       n.short_content,\n" +
                    "       n.content,\n" +
                    "       n.post_date,\n" +
                    "       n.picture_url,\n" +
                    "       n.language_id,\n" +
                    "       l.name as language_name,\n" +
                    "       l.code as language_code,\n" +
                    "       n.publication_id,\n" +
                    "       p.name as publication_name,\n" +
                    "       p.description as publication_description,\n" +
                    "       p.rating as publication_rating\n" +
                    "from t_news n\n" +
                    "inner join t_publications p on n.publication_id = p.id\n" +
                    "inner join t_languages l on n.language_id = l.id");

            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                News n = new News();
                n.setId(resultSet.getInt("id"));
                n.setTitle(resultSet.getString("title"));
                n.setContent(resultSet.getString("content"));
                n.setShort_content(resultSet.getString("short_content"));
                n.setPicture_url(resultSet.getString("picture_url"));
                n.setPost_date(resultSet.getString("post_date"));

                Language language = new Language();
                language.setId(resultSet.getInt("language_id"));
                language.setName(resultSet.getString("language_name"));
                language.setCode(resultSet.getString("language_code"));
                n.setLanguage(language);

                Publication publication = new Publication();
                publication.setId(resultSet.getInt("publication_id"));
                publication.setName(resultSet.getString("publication_name"));
                publication.setDescription(resultSet.getString("publication_description"));
                publication.setRating(resultSet.getDouble("publication_rating"));
                n.setPublication(publication);

                news.add(n);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return news;
    }
    public static ArrayList<News> getAllNews(int id){
        ArrayList<News> news = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select n.id,\n" +
                    "       n.title,\n" +
                    "       n.short_content,\n" +
                    "       n.content,\n" +
                    "       n.post_date,\n" +
                    "       n.picture_url,\n" +
                    "       n.language_id,\n" +
                    "       l.name as language_name,\n" +
                    "       l.code as language_code,\n" +
                    "       n.publication_id,\n" +
                    "       p.name as publication_name,\n" +
                    "       p.description as publication_description,\n" +
                    "       p.rating as publication_rating\n" +
                    "from t_news n\n" +
                    "inner join t_publications p on n.publication_id = p.id\n" +
                    "inner join t_languages l on n.language_id = l.id " +
                    "where n.language_id = ?");
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                News n = new News();
                n.setId(resultSet.getInt("id"));
                n.setTitle(resultSet.getString("title"));
                n.setContent(resultSet.getString("content"));
                n.setShort_content(resultSet.getString("short_content"));
                n.setPicture_url(resultSet.getString("picture_url"));
                n.setPost_date(resultSet.getString("post_date"));

                Language language = new Language();
                language.setId(resultSet.getInt("language_id"));
                language.setName(resultSet.getString("language_name"));
                language.setCode(resultSet.getString("language_code"));
                n.setLanguage(language);

                Publication publication = new Publication();
                publication.setId(resultSet.getInt("publication_id"));
                publication.setName(resultSet.getString("publication_name"));
                publication.setDescription(resultSet.getString("publication_description"));
                publication.setRating(resultSet.getDouble("publication_rating"));
                n.setPublication(publication);

                news.add(n);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return news;
    }

    public static ArrayList<News> getAllNews(Publication p, int id){
        ArrayList<News> news = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select n.id,\n" +
                    "       n.title,\n" +
                    "       n.short_content,\n" +
                    "       n.content,\n" +
                    "       n.post_date,\n" +
                    "       n.picture_url,\n" +
                    "       n.language_id,\n" +
                    "       l.name as language_name,\n" +
                    "       l.code as language_code,\n" +
                    "       n.publication_id,\n" +
                    "       p.name as publication_name,\n" +
                    "       p.description as publication_description,\n" +
                    "       p.rating as publication_rating\n" +
                    "from t_news n\n" +
                    "inner join t_publications p on n.publication_id = p.id\n" +
                    "inner join t_languages l on n.language_id = l.id " +
                    "where n.publication_id = ? and n.language_id = ?");
            statement.setInt(1,p.getId());
            statement.setInt(2,id);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                News n = new News();
                n.setId(resultSet.getInt("id"));
                n.setTitle(resultSet.getString("title"));
                n.setContent(resultSet.getString("content"));
                n.setShort_content(resultSet.getString("short_content"));
                n.setPicture_url(resultSet.getString("picture_url"));
                n.setPost_date(resultSet.getString("post_date"));

                Language language = new Language();
                language.setId(resultSet.getInt("language_id"));
                language.setName(resultSet.getString("language_name"));
                language.setCode(resultSet.getString("language_code"));
                n.setLanguage(language);

                Publication publication = new Publication();
                publication.setId(resultSet.getInt("publication_id"));
                publication.setName(resultSet.getString("publication_name"));
                publication.setDescription(resultSet.getString("publication_description"));
                publication.setRating(resultSet.getDouble("publication_rating"));
                n.setPublication(publication);

                news.add(n);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return news;
    }

    public static News getNews(int id){
        News news = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select n.id,\n" +
                    "       n.title,\n" +
                    "       n.short_content,\n" +
                    "       n.content,\n" +
                    "       n.post_date,\n" +
                    "       n.picture_url,\n" +
                    "       n.language_id,\n" +
                    "       l.name as language_name,\n" +
                    "       l.code as language_code,\n" +
                    "       n.publication_id,\n" +
                    "       p.name as publication_name,\n" +
                    "       p.description as publication_description,\n" +
                    "       p.rating as publication_rating\n" +
                    "from t_news n\n" +
                    "inner join t_publications p on n.publication_id = p.id\n" +
                    "inner join t_languages l on n.language_id = l.id " +
                    "where n.id = ?");
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                news = new News();
                news.setId(id);
                news.setTitle(resultSet.getString("title"));
                news.setShort_content(resultSet.getString("short_content"));
                news.setContent(resultSet.getString("content"));
                news.setPicture_url(resultSet.getString("picture_url"));
                news.setPost_date(resultSet.getString("post_date"));

                Language language = new Language();
                language.setId(resultSet.getInt("language_id"));
                language.setName(resultSet.getString("language_name"));
                language.setCode(resultSet.getString("language_code"));
                news.setLanguage(language);

                Publication publication = new Publication();
                publication.setId(resultSet.getInt("publication_id"));
                publication.setName(resultSet.getString("publication_name"));
                publication.setDescription(resultSet.getString("publication_description"));
                publication.setRating(resultSet.getDouble("publication_rating"));
                news.setPublication(publication);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return news;
    }
    public static void addNews(News news){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "insert into t_news " +
                    "(title, short_content, content, post_date, picture_url, language_id, publication_id) " +
                    "values (?,?,?,?,?,?,?)");
            statement.setString(1,news.getTitle());
            statement.setString(2, news.getShort_content());
            statement.setString(3,news.getContent());
            statement.setString(4,news.getPost_date());
            statement.setString(5, news.getPicture_url());
            statement.setInt(6,news.getLanguage().getId());
            statement.setInt(7,news.getPublication().getId());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void editNews(News news){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "update t_news set title = ?, short_content = ?, content = ?, post_date = ?, picture_url = ?, " +
                    "language_id = ?, publication_id = ? " +
                    "where id = ?");
            statement.setString(1,news.getTitle());
            statement.setString(2,news.getShort_content());
            statement.setString(3,news.getContent());
            statement.setString(4,news.getPost_date());
            statement.setString(5,news.getPicture_url());
            statement.setInt(6,news.getLanguage().getId());
            statement.setInt(7,news.getPublication().getId());
            statement.setInt(8,news.getId());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void addComment(Comment comment){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "insert into t_comments (news_id, user_id, comment) " +
                    "values (?,?,?) ");
            statement.setInt(1,comment.getNews().getId());
            statement.setInt(2,comment.getUser().getId());
            statement.setString(3,comment.getComment());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static ArrayList<Comment> getAllComments(int news_id){
        ArrayList comments = new ArrayList();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select c.id,\n" +
                    "       c.comment,\n" +
                    "       c.post_date,\n" +
                    "       c.news_id,\n" +
                    "       n.title,\n" +
                    "       c.user_id,\n" +
                    "       u.full_name,\n" +
                    "       u.email\n" +
                    "from t_comments c\n" +
                    "inner join t_news n on n.id = c.news_id\n" +
                    "inner join t_users u on u.id = c.user_id\n" +
                    "where c.news_id = ?\n" +
                    "order by c.post_date desc");
            statement.setInt(1,news_id);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                Comment comment = new Comment();
                comment.setId(resultSet.getInt("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getTimestamp("post_date"));

                User user = new User();
                user.setId(resultSet.getInt("user_id"));
                user.setFull_name(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                comment.setUser(user);

                News news = new News();
                news.setId(resultSet.getInt("news_id"));
                news.setTitle(resultSet.getString("title"));
                comment.setNews(news);

                comments.add(comment);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return comments;
    }

    public static Comment getComment(int comment_id){
        Comment comment = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select c.id,\n" +
                    "       c.comment,\n" +
                    "       c.post_date,\n" +
                    "       c.news_id,\n" +
                    "       n.title,\n" +
                    "       c.user_id,\n" +
                    "       u.full_name,\n" +
                    "       u.email\n" +
                    "from t_comments c\n" +
                    "inner join t_news n on n.id = c.news_id\n" +
                    "inner join t_users u on u.id = c.user_id\n" +
                    "where c.id = ?\n");
            statement.setInt(1,comment_id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                comment = new Comment();
                comment.setId(comment_id);
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getTimestamp("post_date"));

                User user = new User();
                user.setId(resultSet.getInt("user_id"));
                user.setFull_name(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                comment.setUser(user);

                News news = new News();
                news.setId(resultSet.getInt("news_id"));
                news.setTitle(resultSet.getString("title"));
                comment.setNews(news);
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return comment;
    }

    public static void editComment(Comment comment){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "update t_comments set news_id = ?, user_id = ?, comment = ?, post_date = ? " +
                    "where id = ? ");
            statement.setInt(1,comment.getNews().getId());
            statement.setInt(2,comment.getUser().getId());
            statement.setString(3,comment.getComment());
            statement.setTimestamp(4,comment.getPostDate());
            statement.setInt(5,comment.getId());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void deleteComment(Comment comment){
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "delete from t_comments where id = ?");
            statement.setInt(1,comment.getId());

            statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
