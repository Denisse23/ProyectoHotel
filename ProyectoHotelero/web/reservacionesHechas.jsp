<%-- 
    Document   : reservacionesHechas
    Created on : 28/11/2016, 11:51:13 PM
    Author     : Denisse
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
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
        
        <% 
            if(request.getParameter("button-agregar-servicioareservacion")!=null){
             try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "insert into FichaClienteServicio (IdFichaCliente, IdServicio, Fecha) values ((select"
                    + " IdFichaCliente from FichaCliente where IdReservacion=?),?,?)";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-id-reservacionesHechas-servicios"));
            db.query.setString(2, request.getParameter("text-id-servicio") );
            DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
            Date date1 = new Date();
            db.query.setString(3, dateFormat1.format(date1));
            int contador= db.query.executeUpdate();
            if (contador == 1) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','FichaClienteServicio'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        out.print("<script>alert('El servicio se agregó correctamente');</script>");
            }
            db.commit();
            db.desconectar();
            
        } catch (Exception e) {
            out.print("<script>alert('El servició ya se agregó para este día');</script>");
        }}
            
        %>
        <% 
            if(request.getParameter("button-cancelar-reservacion")!=null){
             try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "update Reservacion set Estado='Cancelada' where IdReservacion=?";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-id-reservacionesHechas"));
            int contador= db.query.executeUpdate();
            if (contador == 1) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('update','Reservacion'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
            }
            db.commit();
            db.desconectar();
            
        } catch (Exception e) {
            out.print("<script>alert('" + e.toString() + "');</script>");
        }}
            
        %>

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
                            <td><form action="reservacionesHechas.jsp" method="POST">
                               <input type="text" value="<%=rs.getString(1)%>"name="text-id-reservacionesHechas" style="display: none;" />    
                                <input type="submit" name="button-cancelar-reservacion" value="Cancelar" class="btn btn-primary"/>
                                </form>
                            </td>
                            <%} else{%>
                            <td></td>
                            <%}%>
                             <% if(rs.getString(6).equals("Checkin")){ %>
                             <td><form action="reservacionesHechas.jsp" method="POST">
                                 <input type="text" value="<%=rs.getString(1)%>"name="text-id-reservacionesHechas-servicios" style="display: none;" />   
                                 <input type="submit" name="button-agregar-servicios-reservaciones" value="Agregar Servicios" class="btn btn-primary"/></form></td>
                            <%} else{%>
                            <td></td>
                            <%}%>
                        </tr>
                        <%
                           }
                           db.desconectar();
                            }catch(Exception e){

                            }
                        
                        %>
                    </tbody>
                </table>
            </form>
        </div>

        <% if (request.getParameter("button-agregar-servicios-reservaciones") != null) {
        %>
        <div class="servicios">
            <h4>Añadiendo Serivicios a la reservación <%=request.getParameter("text-id-reservacionesHechas-servicios")%></h4> 
            <table border="1" class="table table-striped">
                <thead>
                    <tr>
                        <th>Servicio</th>
                        <th>Precio</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                  <%  try {
                       Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                        db.conectar();
                         String sql ="select IdServicio,Nombre,Precio from Servicio join CategoriaServicio"
                                 + " on Servicio.IdServicio=CategoriaServicio.IdServicio where CategoriaServicio.IdCategoria="
                                 + "(select IdCategoria from Habitacion join Reservacion on Habitacion.IdHabitacion="
                                 + " Reservacion.IdHabitacion where Reservacion.IdReservacion="+request.getParameter("text-id-reservacionesHechas-servicios")+")";
                         db.prepare(sql);
                         db.query.execute();
                         ResultSet rs = db.query.getResultSet();
                         while (rs.next()) {    %>
                    <tr>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(3)%></td>
                        <td><form action="reservacionesHechas.jsp" method="POST">
                                <input type="text" value="<%=request.getParameter("text-id-reservacionesHechas-servicios")%>" name="text-id-reservacionesHechas-servicios" style="display: none;" /> 
                                <input type="text" value="<%=rs.getString(1)%>" name="text-id-servicio" style="display: none;" />
                                <input type="text" value="Agregar Servicios" name="button-agregar-servicios-reservaciones" style="display: none;" />
                                
                                <input type="submit" name="button-agregar-servicioareservacion"value="Agregar" class="btn btn-primary"/>
                            </form>
                        </td>
                    </tr>
                    <%
                           } 
                           db.desconectar();
                            }catch(Exception e){
                                out.print("<script>alert('"+e.getMessage()+"');</script>");
                            }
                        
                        %>
                </tbody>
            </table>

        </div>
        <%
            }
        %>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
