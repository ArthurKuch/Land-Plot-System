package com.kuch.landsystem.DAO;

import com.kuch.landsystem.DatabaseConnection.DBConnection;
import com.kuch.landsystem.model.Product;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ProductDAO {

    private static final String INSERT_EARTH_SQL = "INSERT INTO products" + "(pname,pdesc,price,image,user_id) VALUES " + " (?,?,?,?,?);";


    public void insertProd(Product product){
        try(Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_EARTH_SQL)){
            preparedStatement.setString(1, product.getPname());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setString(3,product.getPrice());
            preparedStatement.setBlob(4, (InputStream) product.getPart());
            preparedStatement.setInt(5, product.getUser_id());
            System.out.println(product);
            preparedStatement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}
