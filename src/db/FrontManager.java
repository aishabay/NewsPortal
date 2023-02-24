package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FrontManager {
    private static Connection connection;
    static{
        try{
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5433/news_portal",
                    "postgres",
                    "postgres"
                    );
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public static Content getContent(int language_id){
        Content content = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_content where language_id = ?");
            statement.setInt(1, language_id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                content = new Content();
                content.setId(resultSet.getInt("id"));
                content.setHeader_heading(resultSet.getString("header_heading"));
                content.setSign_up_btn(resultSet.getString("sign_up_btn"));
                content.setPoster_heading(resultSet.getString("poster_heading"));
                content.setPoster_text(resultSet.getString("poster_text"));
                content.setRead_more(resultSet.getString("read_more"));
                content.setFooter(resultSet.getString("footer"));
                content.setLogin_btn(resultSet.getString("login_btn"));
                content.setEmail(resultSet.getString("email"));
                content.setPassword(resultSet.getString("password"));
                content.setRetype_password(resultSet.getString("retype_password"));
                content.setRegistration(resultSet.getString("registration"));
                content.setFull_name(resultSet.getString("full_name"));
                content.setProfile(resultSet.getString("profile"));
                content.setRole(resultSet.getString("role"));
                content.setLog_out(resultSet.getString("log_out"));
                content.setAdmin_panel(resultSet.getString("admin_panel"));
                content.setLanguages(resultSet.getString("languages"));
                content.setPublications(resultSet.getString("publications"));
                content.setNews(resultSet.getString("news"));
                content.setName(resultSet.getString("name"));
                content.setCode(resultSet.getString("code"));
                content.setOperations(resultSet.getString("operations"));
                content.setAdd_new(resultSet.getString("add_new"));
                content.setEdit(resultSet.getString("edit"));
                content.setDelete(resultSet.getString("delete"));
                content.setAdd_new_language(resultSet.getString("add_new_language"));
                content.setAdd(resultSet.getString("add"));
                content.setClose(resultSet.getString("close"));
                content.setUsers(resultSet.getString("users"));
                content.setWelcome(resultSet.getString("welcome"));
                content.setIntro(resultSet.getString("intro"));
                content.setWarning(resultSet.getString("warning"));
                content.setDescription(resultSet.getString("description"));
                content.setRating(resultSet.getString("rating"));
                content.setTitle(resultSet.getString("title"));
                content.setLanguage(resultSet.getString("language"));
                content.setRelease_date(resultSet.getString("release_date"));
                content.setPublication(resultSet.getString("publication"));
                content.setDetails(resultSet.getString("details"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return content;
    }

    public static ArrayList<Language> getAllLanguages(){
        ArrayList<Language> languages = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_languages");
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                Language language = new Language();
                language.setId(resultSet.getInt("id"));
                language.setName(resultSet.getString("name"));
                language.setCode(resultSet.getString("code"));
                languages.add(language);
            }
            statement.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return languages;
    }

    public static Language getLanguage(String name){
        Language language = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_languages where name = ?");
            statement.setString(1, name);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                language = new Language();
                language.setId(resultSet.getInt("id"));
                language.setName(name);
                language.setCode(resultSet.getString("code"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return language;
    }

    public static Language getLanguage(int id){
        Language language = null;
        try{
            PreparedStatement statement = connection.prepareStatement(" "+
                    "select * from t_languages where id = ?");
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                language = new Language();
                language.setId(id);
                language.setName(resultSet.getString("name"));
                language.setCode(resultSet.getString("code"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return language;
    }
}
