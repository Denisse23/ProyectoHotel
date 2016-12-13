<%-- 
    Document   : ubicacion
    Created on : 10/12/2016, 04:20:48 PM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
         <script type="text/javascript"src="https://maps.google.com/maps/api/js?key=AIzaSyCN2Yl_aHhVqCtOMsg2feV5VEhHOqAo02w"></script>
         <script type="text/javascript" src="<%= application.getContextPath()+"/js/ubicacion.js"%>"></script> 
         <link rel="stylesheet" type="text/css" href="./css/informacion.css">
        <title>Ubicación</title>
    </head>
    <body onload="mostrar_mapa(0)">
        <jsp:include page="header.jsp"/>
        <div class="info">
            
           <center>
            <br><br>
            <div id="mapa" style="width: 500px; height: 300px; border: 5px groove #006600;"></div>
            <br>
            
            <input type="button" value="Ubicación Hotel" class="btn btn-primary" onclick="mostrar_mapa(1)"/>
            <input type="button" value="Limpiar ubicacion" class="btn btn-primary" onclick="mostrar_mapa(0)"/>
            <a class="btn btn-primary" role="button" href="https://www.google.com/maps/place/14.075904,-87.199396/">Save</a>
        
    </center> 
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
