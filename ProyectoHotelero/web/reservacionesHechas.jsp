<%-- 
    Document   : reservacionesHechas
    Created on : 28/11/2016, 11:51:13 PM
    Author     : Denisse
--%>
<%
   if(session.getAttribute("Rol")==null || !session.getAttribute("Rol").equals("Cliente")){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/reserHechas.css">
        <title>Reservaciones Realizdas</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>


        <div class="revs">
            <form action="reservacionesHechas.jsp" method="POST">
                <table class="table table-striped">
                    <thead >
                        <tr>
                            <th>Habitación</th>
                            <th>Fecha LLegada</th>
                            <th>Fecha Salida</th>
                            <th>Estado</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>15</td>
                            <td>10-12-2016</td>
                            <td>12-12-2016</td>
                            <td>Checkin</td>
                            <td><input type="button" value="Cancelar" class="btn btn-primary"/></td>
                            <td><input type="submit" name="aservicios" value="Agregar Servicios" class="btn btn-primary"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>

        <% if (request.getParameter("aservicios") != null) {
        %>
        <div class="servicios">
            <h4>Añadiendo Serivicios</h4>
            <table border="1" class="table table-striped">
                <thead>
                    <tr>
                        <th>Servicio</th>
                        <th>Precio</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Internet</td>
                        <td>42</td>
                        <td><input type="button" value="Agregar" class="btn btn-primary"/></td>
                    </tr>
                </tbody>
            </table>

        </div>
        <%
            }
        %>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
