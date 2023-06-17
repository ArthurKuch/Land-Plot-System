package com.kuch.landsystem.DAO;

import com.kuch.landsystem.DatabaseConnection.DBConnection;
import com.kuch.landsystem.model.Users;

import java.sql.*;

public class LoginDao {


    public String authenticateUser(Users user)
    {
        String login = user.getLogin();
        String password = user.getPass();

        Connection con;
        Statement statement;
        ResultSet resultSet;

        String loginDB;
        String passwordDB;
        String roleDB;

        try
        {
            con = DBConnection.createConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("select ulogin,upass,role from users");

            while(resultSet.next())
            {
                loginDB = resultSet.getString("ulogin");
                passwordDB = resultSet.getString("upass");
                roleDB = resultSet.getString("role");

                if(login.equals(loginDB) && password.equals(passwordDB) && roleDB.equals("ADMIN"))
                    return "Admin_Role";
                else if(login.equals(loginDB) && password.equals(passwordDB) && roleDB.equals("USER"))
                    return "User_Role";
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }

    public int getUserID(String login){

        int id = 0;
        Connection con;
        Statement statement;
        ResultSet resultSet;
        try
        {
            con = DBConnection.createConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("SELECT id FROM users WHERE ulogin = " + "'"+login + "'");

            while(resultSet.next())
            {
               
                id = resultSet.getInt("id");
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return id;
    }

}
