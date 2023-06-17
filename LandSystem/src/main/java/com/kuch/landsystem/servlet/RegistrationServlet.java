package com.kuch.landsystem.servlet;

import com.kuch.landsystem.DatabaseConnection.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "RegistrationServlet", value = "/register")
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("home.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        String uname = request.getParameter("uname");
        String usurname = request.getParameter("usurname");
        String ulogin = request.getParameter("ulogin");
        String uemail = request.getParameter("uemail");
        String upwd = request.getParameter("upass");
        HttpSession session = request.getSession();
        try{
            con = DBConnection.createConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO users(uname,usurname,uemail,ulogin,upass,role) values (?,?,?,?,?,?) ");
            PreparedStatement ps  = con.prepareStatement("SELECT * FROM users WHERE uemail = " + "'"+uemail + "'");
            PreparedStatement ps1  = con.prepareStatement("SELECT * FROM users WHERE ulogin = " + "'"+ulogin + "'");
            ResultSet rs = ps.executeQuery();
            int n = 0;
            if(rs.next()){
                n = rs.getInt(1);
            }
            rs = ps1.executeQuery();
            if(rs.next())
                n = 2;
            if(n == 0) {
                pst.setString(1, uname);
                pst.setString(2, usurname);
                pst.setString(3, uemail);
                pst.setString(4, ulogin);
                pst.setString(5, upwd);
                pst.setString(6, "USER");
                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                      session.setAttribute("status","success");
                      response.sendRedirect("home.jsp");
                }
            }else if(n==2){
                session.setAttribute("status","failedlogin");
                response.sendRedirect("home.jsp");
            }else{
                session.setAttribute("status","failed");
                response.sendRedirect("home.jsp");
            }
            pst.close();
        }catch (Exception e){
            try {
                con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }

    }
}
