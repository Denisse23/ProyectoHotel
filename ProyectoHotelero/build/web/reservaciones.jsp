<%-- 
    Document   : reservaciones
    Created on : 29/11/2016, 01:27:41 PM
    Author     : Denisse
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
   if(session.getAttribute("Rol")==null || !session.getAttribute("Rol").equals("Administrador")){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/reservaciones.css">
        <script type="text/javascript" src="<%= application.getContextPath()+"/js/reservaciones.js"%>"></script>
        <title>Reservaciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="revs">
        <%  if(request.getParameter("button-checkin-reservaciones")!=null){
            try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql2 = "insert into FichaCliente (IdReservacion,FechaIngreso) values(?,?)";
            db.prepare(sql2);
            db.query.setString(1,  request.getParameter("text-id-reservaciones-checkin"));
            DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date1 = new Date();
            db.query.setString(2,dateFormat1.format(date1) );
            int contador1 =db.query.executeUpdate();
            if (contador1 == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','FichaCliente'"
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
        }
            try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "update Reservacion set Estado='Checkin' where IdReservacion=?";
            db.prepare(sql);
            
            db.query.setString(1, request.getParameter("text-id-reservaciones-checkin"));
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
        }
           }
            if(request.getParameter("text-id-reservaciones")!=null){
             try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "update Reservacion set Estado=? where IdReservacion=?";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("select-estado-reservaciones"));
            db.query.setString(2, request.getParameter("text-id-reservaciones"));
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
            <form  method="POST">
                <table class="table table-striped">
                    <thead >
                        <tr>
                            <th>Id Reservación</th>
                            <th>Cliente</th>
                            <th>Habitación</th>
                            <th>Fecha Reservación</th>
                            <th>Fecha LLegada</th>
                            <th>Fecha Salida</th>
                            <th>Estado Actual</th>
                            <th>Opciones de Estado</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                          <%
                 try {
                       Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                        db.conectar();
                         String sql ="select IdReservacion, PrimerNombre, PrimerApellido, IdHabitacion,FechaReservacion, FechaIngreso"
                                 + ", FechaSalida, Estado from Reservacion join Cliente on Reservacion.IdCliente=Cliente.IdCliente ";
                         db.prepare(sql);
                         db.query.execute();
                         ResultSet rs = db.query.getResultSet();
                         while (rs.next()) {
%>             
                        
                        <tr>
                            <td><%= rs.getString(1) %></td>
                            <td><%= rs.getString(2)+" "+rs.getString(3) %></td>
                            <td><%= rs.getString(4) %></td>
                            <td><%= rs.getString(5) %></td>
                            <td><%= rs.getString(6) %></td>
                            <td><%= rs.getString(7) %></td>
                            <td><%= rs.getString(8) %></td>
                             <td>
                             <form  action="reservaciones.jsp" method="POST">
                              <input type="text" value="<%=rs.getString(1)%>"name="text-id-reservaciones" style="display: none;" />
                            <select id="select-estado-reservaciones" name="select-estado-reservaciones" class="selectpicker form-control"  onchange="this.form.submit()">
                            <%if(rs.getString(8).equals("Confirmada")){%>
                                     <option value=""></option>
                                    <option value="Cancelada">Cancelada</option>
                            <%}else if(rs.getString(8).equals("Espera")){%>
                                    <option value=""></option>
                                    <option value="Confirmada">Confirmada</option>
                                    <option value="Cancelada">Cancelada</option>
                                    <option value="Rechazada">Rechazada</option>
                            <%}else{%>
                                 <option value=""></option>
                            <%}%>
                            </select></form></td>
                            <td>
                            <form action="reservaciones.jsp" method="POST">
                             <%if(rs.getString(8).equals("Confirmada")){
                                 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                 Date today = new Date();
                                 Date fechasalida = format.parse(rs.getString(7));
                                 if(!(fechasalida.compareTo(today)<0)){ %>
                                  <input type="text" value="<%=rs.getString(1)%>"name="text-id-reservaciones-checkin" style="display: none;" />
                                  <input type="submit" name="button-checkin-reservaciones"value="Checkin" class="btn btn-primary"/>
                             <%}}%></form></td>
                           
                            
                        
                        <% }%>
                           
                           </tr>
                           
                       <%    db.desconectar();
                            }catch(Exception e){
                            }
                        
                        %>
                    </tbody>
                </table>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
