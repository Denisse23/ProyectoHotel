<%-- 
    Document   : eliminaractivo.jsp
    Created on : 3/12/2016, 12:56:22 PM
    Author     : Denisse
--%>
<%@page import="java.util.Date"%>
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
            String sql = "delete from Activos where IdActivo=?";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-id-eliminar-activo"));
            int contador = db.query.executeUpdate();
            if (contador == 1) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('delete','Activos'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                out.print("<script>alert('El activo se eliminó correctamente');</script>");
            }
            db.commit();
            db.desconectar();

        } catch (Exception e) {
            out.print("<script>alert('Error: El activo está siendo usado en una o más categorías');</script>");
        }
        out.write("<script>setTimeout(function(){window.location.href='"+application.getContextPath()+"/administrarinformacion.jsp'},300);</script>");

%>

 <jsp:include page="../footer.jsp"/>
    </body>
</html>