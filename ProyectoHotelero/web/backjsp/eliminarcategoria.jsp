<%-- 
    Document   : eliminarcategoria
    Created on : 4/12/2016, 12:35:57 PM
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
            String sql = "delete from Categoria where IdCategoria=?";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-id-eliminar-categoria"));
            int contador = db.query.executeUpdate();
            if (contador == 1) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('delete','Categoria'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                out.print("<script>alert('La categoria se eliminó correctamente');</script>");
            }
            db.commit();
            db.desconectar();

        } catch (Exception e) {
            out.print("<script>alert('Error: La categoria está siendo usado en una o más habitaciones o tiene asignados activos y servicios');</script>");
        }
        out.write("<script>setTimeout(function(){window.location.href='"+application.getContextPath()+"/administrarinformacion.jsp'},300);</script>");

%>

 <jsp:include page="../footer.jsp"/>
    </body>
</html>
