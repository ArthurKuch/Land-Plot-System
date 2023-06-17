package com.kuch.landsystem.DAO;

import com.kuch.landsystem.DatabaseConnection.DBConnection;
import com.kuch.landsystem.model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsersDao {

    private static final String UPDATE_USERS_SQL = "update users set uname = ?,usurname= ?, phone =?, city =? where id = ?;";
    private static final String SELECT_USER_BY_ID = "select * from users where id =?";

    public int registerUser(Users user){
        String INSERT_USERS_SQL = "INSERT INTO USERS" + "(id, uname, usurname, uemail, ulogin, upass, role) VALUES " +
                "(?, ?, ?, ?, ?, ?, ?)";
        int result = 0;

        PreparedStatement ps = null;
        Connection connection = DBConnection.createConnection();
        try{
            ps = connection.prepareStatement(INSERT_USERS_SQL);
            ps.setInt(1, 1);
            ps.setString(2, user.getName());
            ps.setString(3, user.getSurname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getLogin());
            ps.setString(6, user.getPass());
            ps.setString(7, "USER");

            result = ps.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }

    public boolean updateUser(Users user) throws SQLException{
        boolean check;
        try(Connection con = DBConnection.getConnection(); PreparedStatement statement = con.prepareStatement(UPDATE_USERS_SQL);){
            statement.setString(1, user.getName());
            statement.setString(2, user.getSurname());
            statement.setString(3, user.getPhone());
            statement.setString(4, user.getCity());
            statement.setInt(5, user.getId());

            check = statement.executeUpdate() > 0;
        }
        return check;
    }

    public Users selectUser(int id) {
        Users user = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID);) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("uname");
                String lastname = rs.getString("usurname");
                String phone = rs.getString("phone");
                String city = rs.getString("city");
                user = new Users(name,lastname,id,phone,city);
            }
        } catch (SQLException e) {
           e.printStackTrace();
        }
        return user;
    }




}
