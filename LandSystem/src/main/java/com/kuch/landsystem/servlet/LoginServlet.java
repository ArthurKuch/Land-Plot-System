package com.kuch.landsystem.servlet;

import com.kuch.landsystem.DAO.LoginDao;
import com.kuch.landsystem.model.Users;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String login = request.getParameter("userlogin");
        String password = request.getParameter("userpassword");

        Users users = new Users();
        users.setLogin(login);
        users.setPass(password);
        HttpSession session = request.getSession();
        LoginDao loginDao = new LoginDao();
        int id = 0;
        try {
            String userValidate = loginDao.authenticateUser(users);

            if(userValidate.equals("Admin_Role")){
                id = loginDao.getUserID(login);
                users.setId(id);
                session.setAttribute("id",users.getId());
                session.setAttribute("role", "ADMIN");
                response.sendRedirect("admin.jsp");
            }
            else if(userValidate.equals("User_Role")){
                id = loginDao.getUserID(login);
                users.setId(id);
                session.setAttribute("id",users.getId());
                session.setAttribute("role", "USER");
                response.sendRedirect("profile.jsp");
            }else{
                session.setAttribute("statusz", "failed");
                response.sendRedirect("home.jsp");
            }

        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
