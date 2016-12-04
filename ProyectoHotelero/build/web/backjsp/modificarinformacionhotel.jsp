<%-- 
    Document   : modificarinformacionhotel
    Created on : 3/12/2016, 08:18:35 PM
    Author     : Denisse
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
            String sql = "update Informacion set Nombre=?, Mision=?, Vision=?, Telefono=?, Email=?,Pais=?, Ciudad=?, Ubicacion=? ";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-nombre-hotel-informacion"));
            db.query.setString(2, request.getParameter("text-mision-hotel-informacion"));
            db.query.setString(3, request.getParameter("text-vision-hotel-informacion"));
            db.query.setString(4, request.getParameter("text-tel-hotel-informacion"));
            db.query.setString(5, request.getParameter("text-email-hotel-informacion"));
            db.query.setString(6, request.getParameter("text-pais-hotel-informacion"));
            db.query.setString(7, request.getParameter("text-ciudad-hotel-informacion"));
            db.query.setString(8, request.getParameter("text-ubicacion-hotel-informacion"));
            int contador= db.query.executeUpdate();
            if (contador == 1) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('update','Informacion'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                out.print("<script>alert('La información del hotel se modificó correctamente');</script>");
            }
            db.commit();
            db.desconectar();

        } catch (Exception e) {
            out.print("<script>alert('" + e.toString() + "');</script>");
        }
    out.write("<script>setTimeout(function(){window.location.href='"+application.getContextPath()+"/administrarinformacion.jsp'},300);</script>");

%>

 <jsp:include page="../footer.jsp"/>
    </body>
</html>