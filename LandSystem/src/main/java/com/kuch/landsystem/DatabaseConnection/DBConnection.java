package com.kuch.landsystem.DatabaseConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection connection;

    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try {
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysystem", "root", "root");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static Connection createConnection()
    {
        Connection con = null;
        String url = "jdbc:mysql://localhost:3306/mysystem";
        String username = "root";
        String password = "root";

        try
        {
            try
            {
                Class.forName("com.mysql.cj.jdbc.Driver");
            }
            catch (ClassNotFoundException e)
            {
                e.printStackTrace();
            }
            con = DriverManager.getConnection(url, username, password);
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return con;
    }

}
