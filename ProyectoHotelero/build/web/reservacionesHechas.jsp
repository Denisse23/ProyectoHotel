<%-- 
    Document   : reservacionesHechas
    Created on : 28/11/2016, 11:51:13 PM
    Author     : Denisse
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
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
                            <th>Id Reservación</th>
                            <th>Id Habitación</th>
                            <th>Fecha Reservación</th>
                            <th>Fecha LLegada</th>
                            <th>Fecha Salida</th>
                            <th>Estado Actual</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
   <%
                 try {
                       Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                        db.conectar();
                         String sql ="select IdReservacion,IdHabitacion,FechaReservacion, FechaIngreso"
                                 + ", FechaSalida, Estado from Reservacion where IdCliente="+
                                 "(select IdCliente from Cliente where IdUsuario="+session.getAttribute("Id-Usuario").toString()+")";
                         db.prepare(sql);
                         db.query.execute();
                         ResultSet rs = db.query.getResultSet();
                         while (rs.next()) {
%>                     
                        <tr>
                            <td><%= rs.getString(1) %></td>
                            <td><%= rs.getString(2) %></td>
                            <td><%= rs.getString(3) %></td>
                            <td><%= rs.getString(4) %></td>
                            <td><%= rs.getString(5) %></td>
                            <td><%= rs.getString(6) %></td>
                            <% if(rs.getString(6).equals("Espera") || rs.getString(6).equals("Confirmada")){ %>
                            <td><input type="button" value="Cancelar" class="btn btn-primary"/></td>
                            <%} else{%>
                            <td></td>
                            <%}%>
                             <% if(rs.getString(6).equals("Checkin")){ %>
                            <td><input type="submit" name="aservicios" value="Agregar Servicios" class="btn btn-primary"/></td>
                            <%} else{%>
                            <td></td>
                            <%}%>
                        </tr>
                        <%
                           }
                            }catch(Exception e){

                            }
                        
                        %>
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
