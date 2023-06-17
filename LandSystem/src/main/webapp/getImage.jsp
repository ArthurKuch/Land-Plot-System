<%@ page import="com.kuch.landsystem.DatabaseConnection.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.OutputStream" %>

<%
        String id = request.getParameter("id");
        Connection con = null;
    try{
        con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement("SELECT * FROM products where id=?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            Blob blob = rs.getBlob("image");
            byte byteArray[] = blob.getBytes(1, (int)blob.length());
            response.setContentType("image/gif");
            OutputStream os = response.getOutputStream();
            os.write(byteArray);
            os.flush();
            os.close();
        }
    }
    catch(Exception e){
        e.printStackTrace();
    }

%>