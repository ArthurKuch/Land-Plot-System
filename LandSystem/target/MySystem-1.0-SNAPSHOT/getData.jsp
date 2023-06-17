<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="DatabaseConnection.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.util.ArrayList" %>

<%
        if(request.getParameter("uid") != null){

            int id = Integer.parseInt(request.getParameter("uid"));
            String desc = request.getParameter("description");
            try{
                Connection connection = DBConnection.getConnection();
                PreparedStatement pstm = null;
                pstm = connection.prepareStatement("SELECT * FROM users WHERE id = ?");
                pstm.setInt(1,id);
                ResultSet rs = pstm.executeQuery();
                while (rs.next()){
                    %>
                    <div class="table-responsive">

                    <table class="table table-striped table-bordered">
                    <tr>
                    <th>Власник</th>
                    <td><%=rs.getString("uname")%>  <%=rs.getString("usurname")%></td>
                    </tr>

                        <tr>
                            <th>Телефон</th>
                            <td><%=rs.getString("phone")%></td>
                        </tr>

                        <tr>
                            <th>Опис</th>
                            <td><%=desc%></td>
                        </tr>


                    </table>
                    </div>
                    <%
                }


            }catch (Exception e){
                e.printStackTrace();
            }


        }

%>