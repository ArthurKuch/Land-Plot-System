<%@ page contentType="text/html;charset=UTF-8" %>

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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" crossorigin="anonymous">  
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
    <title>Map</title>
    <style>
        <%@include file="/css/map.css" %>
    </style>
    <style>
        html,
        body,
        #viewDiv {
          padding: 0;
          margin: 0;
          height: 100%;
          width: 100%;
        }
  
        #measurements {
          padding: 4px 8px;
          font-size: 16px;
          bottom: 15px;
          left: 50%;
          margin-right: -50%;
          transform: translate(-50%,-50%);
        }
      </style>
      <link rel="stylesheet" href="style.css">
      <link rel="stylesheet" href="https://js.arcgis.com/4.23/esri/themes/light/main.css">
      <script src="https://js.arcgis.com/4.23/"></script>
      <script>
          require([
            "esri/config",
            "esri/Map",
            "esri/views/MapView",
    
            "esri/widgets/ScaleBar",
            "esri/widgets/Sketch",
            "esri/Graphic",
            "esri/layers/GraphicsLayer",
            "esri/geometry/geometryEngine",
              
          ], (
            esriConfig,
            Map,
            MapView,
  
          ScaleBar,
          Sketch,
          Graphic,
          GraphicsLayer,
          geometryEngine,
    
          ) => {
            esriConfig.apiKey = "AAPK2ee84781cf584062bfd28828b398c923nbgkCTofU3oV9mEPrMOYykbqc8EOxJCQYRn0I6bUf31BIuvC3DVsjLYdfiNTPxBO";
  
            const map = new Map({
              basemap: "arcgis-topographic", // Basemap layer service
            });
    
            const view = new MapView({
              container: "viewDiv",
              map: map,
              center: [-10, 30],
              zoom: 3,
            });
  
            const scalebar = new ScaleBar({
            view: view,
            unit: "metric"
          });
  
          view.ui.add(scalebar, "bottom-right");
  
          const graphicsLayer = new GraphicsLayer();
          map.add(graphicsLayer);
  
          const sketch = new Sketch({
            layer: graphicsLayer,
            view: view,
            availableCreateTools: ["polyline", "polygon", "rectangle"],
            creationMode: "update",
            updateOnGraphicClick: true,
            visibleElements: {
              createTools: {
                point: false,
                circle: false
              },
              selectionTools:{
                "lasso-selection": false,
                "rectangle-selection":false,
              },
              settingsMenu: false,
              undoRedoMenu: false
            }
          });
  
          view.ui.add(sketch, "top-right");
  
          const measurements = document.getElementById("measurements");
          view.ui.add(measurements, "manual");
  
          const polygon = {
              type: "polygon",
              spatialReference: {
                wkid: 3857,
              },
              rings: [
                [
                  [-4508069.082189632, 3599936.936171892],
                  [-4508069.082189632, 5478453.343307884],
                  [-2629552.6750536393, 5478453.343307884],
                  [-2629552.6750536393, 3599936.936171892],
                  [-4508069.082189632, 3599936.936171892],
                ],
              ],
            };
  
            const simplePolygonSymbol = {
              type: "simple-fill",
              outline: {
                color: [200, 0, 0],
                width: 2,
              },
            };
  
            const polygonGraphic = new Graphic({
              geometry: polygon,
              symbol: simplePolygonSymbol
            });
  
          graphicsLayer.add(polygonGraphic);
  
          view.when(() => {
            sketch.update(polygonGraphic);
            getArea(polygonGraphic.geometry);
          });
  
          sketch.on("update", (e) => {
            const geometry = e.graphics[0].geometry;
          
            if (e.state === "start") {
              switchType(geometry);
            }
  
            if (e.state === "complete") {
              graphicsLayer.remove(graphicsLayer.graphics.getItemAt(0));
              measurements.innerHTML = null;
              document.getElementById('gsquare').value = "";
              document.getElementById('psquare').value = "";
              document.getElementById('gline').value = "";
              document.getElementById('pline').value = "";
            }
  
            if (
              e.toolEventInfo &&
              (e.toolEventInfo.type === "scale-stop" ||
                e.toolEventInfo.type === "reshape-stop" ||
                e.toolEventInfo.type === "move-stop")
            ) {
              switchType(geometry);
            }
  
          });
  
  
          function getArea(polygon) {
            const geodesicArea = geometryEngine.geodesicArea(polygon, "square-kilometers");
            const planarArea = geometryEngine.planarArea(polygon, "square-kilometers");
            document.getElementById('gsquare').value = geodesicArea.toFixed(2) + "km\xB2";
            document.getElementById('psquare').value = planarArea.toFixed(2) + " km\xB2";          }
  
          function getLength(line) {
            const geodesicLength = geometryEngine.geodesicLength(line, "kilometers");
            const planarLength = geometryEngine.planarLength(line, "kilometers");
            document.getElementById('gline').value = geodesicLength.toFixed(2) + " km";
            document.getElementById('pline').value = planarLength.toFixed(2) + " km";
          }
  
          function switchType(geom) {
            switch (geom.type) {
              case "polygon":
                getArea(geom);
                break;
              case "polyline":
                getLength(geom);
                break;
              default:
                console.log("No value found");
            }
          }
  
          });
        </script>
</head>
<body>
    <ul class="social">
        <li class="liz"><a href="home.jsp">Головна</a></li>
        <li class="liz"><a href="#news">Про сервіс</a></li>
        <li class="liz"><a href="#">Мапа</a></li>
        <li class="liz"><a href="products.jsp">Землі</a></li>
        <li class="liz" style="float:right"><a href ="profile.jsp">Особистий кабінет</a></li>
      </ul>
      <div class="container rounded bg-white mt-5 mb-5" style="border: #000000 solid 3px; float: left;">
        <div class="myMap">
            <div id="viewDiv">
            <div id="measurements" class="esri-widget">
            </div>
          </div>
        </div>
      </div>
      <div class="container rounded bg-white mt-5 mb-5" style="float:right;">
        <div class="information">
            <form class="autrs">
                <div class="txt_field">
                    <input id="gline" type="text" placeholder="Гео лінія" readonly>
                    <span></span>
                </div>
                <div class="txt_field">
                    <input id="pline" type="text" placeholder="Лінія на площині" readonly>
                    <span></span>
                </div>
                <div class="txt_field">
                  <input id="gsquare" type="text" placeholder="Гео площа" readonly>
                  <span></span>
              </div>
              <div class="txt_field">
                <input id="psquare" type="text" placeholder="Площа на площині" readonly>
                <span></span>
            </div>
            </form>
        </div>
      </div>
      <footer>
        <div class="socialicon">
            <a class="social-icon" href="https://www.instagram.com/arsingular/" target="_blank" style="text-decoration:none;"><ion-icon name="logo-instagram"></ion-icon></a>
            <a class="social-icon" href="https://www.linkedin.com/in/arthur-kuch-317054224/" target="_blank"><ion-icon name="logo-linkedin"></ion-icon></a>
            <a class="social-icon" href="https://github.com/ArthurKuch" target="_blank"><ion-icon name="logo-github"></ion-icon></a>
        </div>
    </footer>
</body>
</html>