<%-- 
    Document   : eliminarhabitacion
    Created on : 4/12/2016, 11:17:30 PM
    Author     : Denisse
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../head.jsp"/>
    <body>
        <jsp:include page="../header.jsp"/>
        
        <%
            try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String sql = "select IdActivo, Cantidad from CategoriaCondiciones where IdCategoria=?";
                db.prepare(sql);
                db.query.setString(1, request.getParameter("text-categoria-eliminar-habitacion"));
                db.query.execute();
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
                    String sql1 = "select CantidadDisponibles, CantidadEnUso from Activos where IdActivo="+rs.getString(1);
                    db.prepare(sql1);
                    db.query.execute();
                    ResultSet rs1 = db.query.getResultSet();
                    while(rs1.next()){
                        int cantidaddis = rs1.getInt(1) + rs.getInt(2);
                        int cantidaduso = rs1.getInt(2)- rs.getInt(2);
                        String sql2 = "update Activos set CantidadDisponibles="+cantidaddis+", CantidadEnUso="+cantidaduso+" where IdActivo="+rs.getString(1);
                        db.prepare(sql2);
                        db.query.executeUpdate();
                        db.commit();
                    }
                }
                
                db.desconectar();
            }catch(Exception e){
                    
                    }

        %>
        <%
            try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String sql = "update Habitacion set Habilitada=0 where IdHabitacion=?";
                db.prepare(sql);
                db.query.setString(1, request.getParameter("text-id-eliminar-habitacion"));
                int contador = db.query.executeUpdate();
                if (contador == 1) {
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date date = new Date();
                    String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('delete','Habitacion'"
                            + ",?,?,?)";
                    db.prepare(sql1);
                    db.query.setString(1, session.getAttribute("Usuario").toString());
                    db.query.setString(2, dateFormat.format(date));
                    db.query.setString(3, session.getAttribute("Rol").toString());
                    db.query.executeUpdate();
                    db.commit();
                    out.print("<script>alert('La Habitación se eliminó correctamente');</script>");
                }
                db.commit();
                db.desconectar();

            } catch (Exception e) {
            }
            out.write("<script>setTimeout(function(){window.location.href='" + application.getContextPath() + "/administrarinformacion.jsp'},300);</script>");

        %>

        <jsp:include page="../footer.jsp"/>
    </body>
</html>
