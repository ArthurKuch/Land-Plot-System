<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="DatabaseConnection.DBConnection"%>
<%@ page import="java.sql.*"%>

<%
    if(session.getAttribute("role").toString().isEmpty() || !session.getAttribute("role").toString().equals("USER"))
        response.sendRedirect("home.jsp");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css'>
    <style>
        <%@include file="/css/profile.css" %>
    </style>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <title>Profile</title>
</head>
<body>
<%
    Connection connection = DBConnection.createConnection();
    Statement statement = connection.createStatement();
    String id = session.getAttribute("id").toString();
    ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE id = " + "'"+id + "'");
    while(true){
        try {
            if (!resultSet.next()) break;
        } catch (SQLException e) {
            e.printStackTrace();
        }
%>
    <ul class="social">
        <li class="liz"><a href="home.jsp">Головна</a></li>
        <li class="liz"><a href="#news">Про сервіс</a></li>
        <li class="liz"><a href="map.jsp">Мапа</a></li>
        <li class="liz"><a href="products.jsp">Землі</a></li>
        <li class="liz" style="float:right"><a href ="#">Особистий кабінет</a></li>
      </ul>

      <div class="container rounded bg-white mt-5 mb-5">
        <div class="row">
            <div class="col-md-5 border-right">
                <form action="update" method="post">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Особистий кабінет</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6"><label class="labels">Ім'я</label><input name="name" type="text" class="form-control" placeholder= "Введіть ім'я" value="<%= resultSet.getString("uname")%>" required></div>
                        <div class="col-md-6"><label class="labels">Прізвище</label><input name="lastname" type="text" class="form-control" value="<%= resultSet.getString("usurname")%>" placeholder="Введіть прізвище" required></div>
                    </div>
                    <div class="row mt-3">
                        <% String number = "";
                            try {
                                if(resultSet.getString("phone") == null)
                                    number = "Ваш номер";
                                else
                                    number = resultSet.getString("phone");
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                        <div class="col-md-12"><label class="labels">Номер телефону</label><input name="phone" type="text" class="form-control" placeholder="Введіть номер" value="<%= number %>" required></div>
                        <% String city = "";
                            try {
                                if(resultSet.getString("city") == null)
                                    city = "Ваше місто";
                                else
                                    city = resultSet.getString("city");
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                        <div class="col-md-12"><label class="labels">Місто</label><input name="city" type="text" class="form-control" placeholder="Введіть місто " value="<%= city %> "  ></div>
                    </div>
                    <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Змінити</button></div>
                    <input type="hidden" id="status" value="<%=request.getSession().getAttribute("status")%>">
                    <script type="text/javascript">
                        let status = document.getElementById("status").value;
                        if(status === "success"){
                            swal({
                                title: "Успіх!",
                                text: "Зміни були успішно внесені",
                                icon: "success",
                                type:"success",
                                button: "Закрити",
                            });}
                    </script>
                </div>
                </form>
            </div>
            <div class="col-md-4 border-right">
                <div class="p-3 py-5">
                    <h4>Керування землями</h4>
                    <div class="d-flex justify-content-between align-items-center experience"><span>Додати землю</span></div><br>
                    <form action="AddProd" method="post" enctype='multipart/form-data'>
                        <div class="col-md-12"><label class="labels">Назва</label>
                        <input name="ename" type="text"  class="form-control" placeholder="Назва" value=""></div> <br>
                        <div class="col-md-12"><label class="labels">Категорія</label><input name="category" type="text"  class="form-control" placeholder="Категорія" value=""></div>
                        <div class="col-md-12"><label class="labels">Ціна</label><input name="price" type="text"  class="form-control" placeholder="Ціна" value=""></div>
                        <div class="col-md-12"><label class="labels">Опис</label><textarea name="desc" class="form-control"  placeholder="Опис"></textarea> </div>
                        <div class="col-md-12"><label class="labels">Зображення</label><input type="file" name="image" class="form-control" placeholder="Зображення" value=""></div>
                        <% if(number.equals("Ваш номер")) { %>
                        <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="button" onclick="error()">Додати</button></div>
                        <script>
                            function  error() {
                                swal({
                                    title: "Помилка!",
                                    text: "Заповніть поле з вашим номером ;(",
                                    icon: "error",
                                    type: "error",
                                    button: "Закрити",
                                });
                            }
                        </script>
                        <%}else{ %>
                        <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Додати</button></div>
                        <% }%>
                    </form>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 py-5">
                    <h4>Ваші землі</h4>
                    <%
                        Connection con = null;
                        Statement st =null;
                        ResultSet rs = null;
                        try{
                            con = DBConnection.getConnection();
                            st=con.createStatement();
                            String sql ="SELECT * FROM products WHERE user_id = " + "'"+id + "'";
                            rs = st.executeQuery(sql);
                            int i=0;
                            while(rs.next()){
                    %>
                    <div class="col-xs-12 col-md-12">
                        <!-- First product box start here-->
                        <div class="prod-info-main prod-wrap clearfix">
                            <div class="row">
                                <div class="col-md-7 col-sm-12 col-xs-12">
                                    <div class="product-deatil">
                                        <h5 class="name">
                                                <%=rs.getString("pname")%>
                                        </h5>
                                        <p class="price-container">
                                            <span><%=rs.getString("price")%></span>
                                        </p>
                                        <span class="tag1"></span>
                                    </div>
                                    <div class="product-info smart-form">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <div class="mt-2 text-center"><a href="delete.jsp?id=<%=rs.getInt("id") %>"><button class="btn btn-primary profile-button" type="button">Видалити</button></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end product -->
                    </div>
                    <%
                        i++;
                        }
                        }catch (Exception e){
                            e.printStackTrace();
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
    </div>
<div class="mt-2 text-center" style="padding-bottom: 100px;"><a href="logout.jsp"><button class="btn btn-primary profile-button " type="button" style="background-color: #00ccff;">Вийти</button></a></div>
    </div>
    <footer>
        <div class="socialicon">
            <a class="social-icon" href="https://www.instagram.com/arsingular/" target="_blank" style="text-decoration:none;"><ion-icon name="logo-instagram"></ion-icon></a>
            <a class="social-icon" href="https://www.linkedin.com/in/arthur-kuch-317054224/" target="_blank"><ion-icon name="logo-linkedin"></ion-icon></a>
            <a class="social-icon" href="https://github.com/ArthurKuch" target="_blank"><ion-icon name="logo-github"></ion-icon></a>
        </div>
    </footer>
    <% }%>
<%session.removeAttribute("status");%>
</body>
</html>