package com.kuch.landsystem.servlet;

import com.kuch.landsystem.DAO.ProductDAO;
import com.kuch.landsystem.DatabaseConnection.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@MultipartConfig
@WebServlet(name = "AddEarthServlet", value = "/AddProd")
public class AddEarthServlet extends HttpServlet {

    private ProductDAO productDAO;



    public void  init(){
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("ename");
        String category = request.getParameter("category");
        String price = request.getParameter("price");
        String description = request.getParameter("desc");
        Connection con = DBConnection.getConnection();
        HttpSession session = request.getSession();
        Part part = request.getPart("image");
        if (part != null) {
            try {
                PreparedStatement pst = con.prepareStatement("INSERT INTO products(pname,pdesc,price,image,user_id,category) values (?,?,?,?,?,?) ");
                InputStream is = part.getInputStream();
                pst.setString(1, name);
                pst.setString(2, description);
                pst.setString(3, price);
                pst.setBlob(4, is);
                pst.setInt(5, (Integer)  request.getSession().getAttribute("id"));
                pst.setString(6, category);
                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    session.setAttribute("status","success");
                    response.sendRedirect("profile.jsp");
                } else {
                    request.setAttribute("status", "failed");
                    response.sendRedirect("profile.jsp");
                }
                pst.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
