<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="DatabaseConnection.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="Users.Users" %>
<%@ page import="DAO.UsersDao" %>


<%
    if(session.getAttribute("role") == null || session.getAttribute("role").toString().isEmpty())
        response.sendRedirect("home.jsp");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css'>
    <style>
        <%@include file="/css/products.css" %>
    </style>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <title>Products</title>
</head>
<body onload="check()">
    <ul class="social">
        <li class="liz"><a href="home.jsp">Головна</a></li>
        <li class="liz"><a href="map.jsp">Мапа</a></li>
        <li class="liz"><a href="#">Землі</a></li>
        <% if(session.getAttribute("role").equals("ADMIN")){ %>
            <li class="liz" style="float:right"><a href ="admin.jsp">Особистий кабінет</a></li>
        <% }else{%>
            <li class="liz" style="float:right"><a href ="profile.jsp">Особистий кабінет</a></li>
        <% } %>
      </ul>
      <div class="container">
          <%
              try{
              Connection connection = DBConnection.createConnection();
              Statement statement = connection.createStatement();
              ResultSet retriveProduct = statement.executeQuery("SELECT * FROM products");
              Connection con = DBConnection.createConnection();
              Statement st = con.createStatement();
              ResultSet getUser = null;
              while (retriveProduct.next()) {

          %>
        <div class="col-xs-12 col-md-6">
            <!-- First product box start here-->
            <div class="prod-info-main prod-wrap clearfix">
                <div class="row">
                        <div class="col-md-5 col-sm-12 col-xs-12">
                            <div class="product-image">
                                <%
                                    String idp = null;
                                    try {
                                        idp = retriveProduct.getString("id");
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                %>
                                <img src="getImage.jsp?id=<%=idp%>" class="img-responsive" style="width: 200px;height: 200px;">
                            </div>
                        </div>
                        <div class="col-md-7 col-sm-12 col-xs-12">
                        <div class="product-deatil">
                                <h5 class="name">
                                    <a href="#">
                                       <%=retriveProduct.getString("pname")%>
                                    </a>
                                    <a href="#">
                                        <span><%=retriveProduct.getString("category")%></span>
                                    </a>                            
        
                                </h5>
                                <p class="price-container">
                                    <span><%=retriveProduct.getString("price")%></span>
                                </p>
                                <span class="tag1"></span> 
                        </div>
<%--                            <input type="text" name="userlogin" class="form-control" placeholder="<%=getUser.getString("uname")%>" required>--%>
                        <div class="product-info smart-form">
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="button" data-toggle="modal" data-target="#view-modal" id="<%=retriveProduct.getInt("user_id")%>" class="btn btn-sm btn-success"  value="<%=retriveProduct.getString("pdesc")%>">Повна інформація</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="view-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display:none; ">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <input type="hidden" id="<%=retriveProduct.getString("pdesc")%>" name="custId" class="cust">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h4 class="modal-title">
                                    Інформація
                                </h4>
                        </div>
                        <div class="modal-body">
                            <div id="show-data"></div>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                function check() {
                    $(document).ready(function () {
                        $('.btn-success').click(function () {
                            var id = $(this).attr("id");
                            var des =$(this).attr("value");
                            $.ajax({
                                url: "getData.jsp",
                                type: "post",
                                data: {"uid": id,
                                      "description": des},
                                success: function (data) {
                                    $("#show-data").html(data);
                                },
                            });
                        });
                    });
                }
            </script>
            <!-- end product -->
        </div>
          <%
                      }}catch (Exception e){
                            e.printStackTrace();
                      }
          %>
        </div>
    <footer>
        <div class="socialicon">
            <a class="social-icon" href="https://www.instagram.com/arsingular/" target="_blank" style="text-decoration:none;"><ion-icon name="logo-instagram"></ion-icon></a>
            <a class="social-icon" href="https://www.linkedin.com/in/arthur-kuch-317054224/" target="_blank"><ion-icon name="logo-linkedin"></ion-icon></a>
            <a class="social-icon" href="https://github.com/ArthurKuch" target="_blank"><ion-icon name="logo-github"></ion-icon></a>
        </div>
    </footer>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>