package com.kuch.landsystem.servlet;

import com.kuch.landsystem.DAO.ProductDAO;
import com.kuch.landsystem.DAO.UsersDao;
import com.kuch.landsystem.model.Users;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/update")
public class UpdateProfileServlet extends HttpServlet {

    private UsersDao usersDao;
    private ProductDAO productDAO;



    public void  init(){
        usersDao = new UsersDao();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean flag;
        HttpSession session = request.getSession();
        try {
            flag = updateUser(request);
            if(flag)
                session.setAttribute("status","success");
            else
                session.setAttribute("status","failed");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("profile.jsp");
    }


    private boolean updateUser(HttpServletRequest request)
            throws SQLException {
        int id = (int) request.getSession().getAttribute("id");
        String name = request.getParameter("name");
        String surname = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        Users users = new Users(name,surname,id,phone,city);
        return usersDao.updateUser(users);
    }





}
