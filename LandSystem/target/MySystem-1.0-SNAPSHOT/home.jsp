<%@ page contentType="text/html;charset=UTF-8" %>

<%--<%--%>
<%--    if(session.getAttribute("role") == null || session.getAttribute("role").toString().isEmpty())--%>
<%--        response.sendRedirect("home.jsp");--%>
<%--%>>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">  
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css'>
    <style>
        <%@include file="/css/home.css" %>
    </style>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <title>Home</title>
</head>
<body>
    <ul class="social">
        <li class="liz"><a href="home.jsp">Головна</a></li>
        <li class="liz"><a href="map.jsp">Мапа</a></li>
        <li class="liz"><a href="products.jsp">Землі</a></li>
        <% if(session.getAttribute("role") == null){ %>
        <li style="float:right"><a class="btn btn-primary btn-lg show-modal" id="logged" data-toggle="modal" data-target="#myModal" >Увійти</a></li>
        <% }else if(session.getAttribute("role").equals("ADMIN")){ %>
         <li class="liz" style="float:right"><a href ="admin.jsp">Особистий кабінет</a></li>
        <% }else if(session.getAttribute("role").equals("USER")){ %>
        <li class="liz" style="float:right"><a href ="profile.jsp">Особистий кабінет</a></li>
        <% } %>
      </ul>
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  data-toggle="modal" >
        <div class="modal-dialog" role="document">
            <div class="modal-content clearfix">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <div class="modal-body">
                    <h3 class="title">Авторизація</h3>
                    <p class="description">Введіть ваш логін та пароль</p>
                    <form class="form-group" method="post" action="login">
                        <span class="input-icon"><i class="fa fa-user"></i></span>
                        <input type="text" name="userlogin" class="form-control" placeholder="Введіть логін" required>
                        <span class="input-icon"><i class="fas fa-key"></i></span>
                        <input type="password" name="userpassword" class="form-control" placeholder="Введіть пароль" required>
                        <button type="submit" class="btn" style="color:black ; margin-left: 37%;">Увійти</button>
                        <input type="hidden" id="statusz" value="<%=session.getAttribute("statusz")%>">
                        <script type="text/javascript">
                            let statusz = document.getElementById("statusz").value;
                            if(statusz == "failed"){
                                swal({
                                    title: "Помилка!",
                                    text: "Невірний логін або пароль ;(",
                                    icon: "error",
                                    type:"error",
                                    button: "Закрити",
                                });
                            }
                            <% session.removeAttribute("statusz"); %>
                        </script>
                    </form>
                    <a  id="myBtn" class="btn" data-toggle="modal1" data-target="#mymodal1" data-dismiss="modal">Ще немаєте акаунту?Зареєструйтесь</a>
                </div>
            </div>
        </div>
    </div>


    <div id="mymodal" class="modal1"  data-dismiss="modal" data-target="#modal2">
        <div class="modal1-content">
            <span class="close1">&times;</span>
          <div class="modal1-body">
            <h3 class="title">Реєстрація</h3>
            <p class="description">Введіть ваше ім'я, прізвище, пошту,логін та пароль</p>
            <form class="form-group" autocomplete="off" method="POST" action="register">
              <input type="text" name="uname" class="form-control" placeholder="Введіть ім'я" required>
              <input type="text" name="usurname" class="form-control" placeholder="Введіть прізвище" required>
                <input type="email" name="uemail" class="form-control" placeholder="Введіть пошту" required>
                <input type="text" name="ulogin" class="form-control" placeholder="Введіть логін" required>
                <input type="password" name="upass" class="form-control" placeholder="Введіть пароль" required>
                <button type="submit" class="btn" id="regist" style="color:black; margin-left: 28% ;">Зареєструватись</button>
                <input type="hidden" id="status" value="<%=request.getSession().getAttribute("status")%>">
                <script type="text/javascript">
                    let status = document.getElementById("status").value;
                    if(status === "success"){
                        swal({
                            title: "Успіх!",
                            text: "Ви були успішно зареєстровані",
                            icon: "success",
                            type:"success",
                            button: "Закрити",

                        });
                    }else if(status === "failed"){
                        swal({
                            title: "Помилка!",
                            text: "Користувач з такою поштою вже існує ;(",
                            icon: "error",
                            type:"error",
                            button: "Закрити",
                        });
                        status = "";
                    }else if(status ==="failedlogin") {
                        swal({
                            title: "Помилка!",
                            text: "Користувач з таким логіном вже існує ;(",
                            icon: "error",
                            type:"error",
                            button: "Закрити",
                        });
                    }
                    <% session.removeAttribute("status"); %>
                </script>
            </form>
          </div>
        </div>
      
      </div>
      
      <script>
      // Get the modal
      var modal = document.getElementById("mymodal");
      
      // Get the button that opens the modal
      var btn = document.getElementById("myBtn");
      
      // Get the <span> element that closes the modal
      var span = document.getElementsByClassName("close1")[0];

      
      // When the user clicks the button, open the modal 
      btn.onclick = function() {
        modal.style.display = "block";
      }
      
      // When the user clicks on <span> (x), close the modal
      span.onclick = function() {
        modal.style.display = "none";
      }
      
      // When the user clicks anywhere outside of the modal, close it
      window.onclick = function(event) {
        if (event.target == modal) {
          modal.style.display = "none";
        }
      }
      </script>
    
      <div class="text-info">
          <p>Система оцінювання земельних ділянок</p>
          <!-- <p style="font-size:30px; margin-left: 200px;">Зручний онлайн сервіс</p> -->
          <% if(session.getAttribute("role") == null){ %>
            <p><button class="startBtn" data-toogle="modal" data-target="#myModal" ><a class="btn btn-primary btn-lg show-modal" id="logged" data-toggle="modal" data-target="#myModal" style="background-color: inherit; !important; ">Розпочати</a></button></p>
          <% }else if(session.getAttribute("role").equals("ADMIN")){ %>
            <p><button class="startBtn" ><a  href="admin.jsp" style="text-decoration: none;">Розпочати</a></button></p>
          <!--<li style="float:right"><a class="btn btn-primary btn-lg show-modal" id="logged" data-toggle="modal" data-target="#myModal" >Увійти</a></li> -->
          <% }else if(session.getAttribute("role").equals("USER")){ %>
             <p><button class="startBtn" ><a  href="products.jsp" style="text-decoration: none;;">Розпочати</a></button></p>
          <%}%>
          <div class="myImg">
              <img src="images\zemelni-dilyanki.png" alt="" style=" width: 663px;
  height: 400px;">
          </div>
      </div>
    <div class="infoblock">
        <strong style="text-align:center ;"><p>Про сервіс</p></strong>
        <div class="portfolio-wrap">
            <div class="portfolio-item">
                <div class="portfolio-item-wrap">
                    <img style="height:400px ;" src="images\usercabinet.jpg ">
                    <div class="portfolio-item-inner">
                        <div class="portfolio-heading">
                            <h3>Особистий кабінет</h3>
                        </div>
                        <ul>
                            Для користування ресурсом потрібен доступ до особистого кабінету
                            <li>Особиста інформація</li>
                            <li>Додавання земель</li>
                            <li>Редагування інформації</li>
                        </ul>
                    </div>
                    </a>
                </div>
            </div>

            <div class="portfolio-item">
                <div class="portfolio-item-wrap">
                    <img style="height:400px ;" src="images\map.jpg ">
                    <div class="portfolio-item-inner">
                        <div class="portfolio-heading">
                            <h3>Інтерактивна мапа</h3>
                        </div>
                        <ul>
                            Використання api мапи для аналізу земельних ділянок
                            <li>Виділення областей</li>
                            <li>Знаходження площі</li>
                            <li>Зручний дизайн</li>
                        </ul>
                    </div>
                    </a>
                </div>
            </div>

            <div class="portfolio-item">
                <div class="portfolio-item-wrap">
                    <img style="height:400px ;" src="images/Bg.jpg">
                    <div class="portfolio-item-inner">
                        <div class="portfolio-heading">
                            <h3>Землі</h3>
                        </div>
                        <ul>
                            Зараєстровані корстувачі матимуть змогу додавати, переглядати та оцінювати земельні ресурси
                            <li>Перегляд земельних ділянок</li>
                            <li>Повна інформація від власника</li>
                        </ul>
                    </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
      <footer>
        <div class="socialicon">
            <a class="social-icon" href="https://www.instagram.com/arsingular/" target="_blank" style="text-decoration:none;"><ion-icon name="logo-instagram"></ion-icon></a>
            <a class="social-icon" href="https://www.linkedin.com/in/arthur-kuch-317054224/" target="_blank"><ion-icon name="logo-linkedin"></ion-icon></a>
            <a class="social-icon" href="https://github.com/ArthurKuch" target="_blank"><ion-icon name="logo-github"></ion-icon></a>
        </div>
    </footer>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.0.min.js"></script><script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>