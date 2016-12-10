<%-- 
    Document   : agregarpromocion
    Created on : 8/12/2016, 03:55:38 PM
    Author     : Denisse
--%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
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
                    String sql = "insert into CategoriaDescuentoPromocion (IdCategoria,Tipo,Porcentaje, FechaInicio, FechaFin) values"
                            + "(?,?,?,?,?)";
                    db.prepare(sql);
                    db.query.setString(1, request.getParameter("select-id-categoria-agregar-promocion"));
                    db.query.setString(2, request.getParameter("select-tipo-agregar-promocion"));
                    db.query.setString(3, request.getParameter("text-porcentaje-agregar-promocion"));
                    db.query.setString(4, request.getParameter("date-fecha-inicio-promocion").toString() + " 00:00:00");
                    db.query.setString(5, request.getParameter("date-fecha-fin-promocion").toString()+" 00:00:00");
                    int contador = db.query.executeUpdate();
                    if (contador == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','CategoriaDescuentoPromocion'"
                                + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                        out.print("<script>alert('La Promoción o Descuento se agregó correctamente');</script>");
                    }
                    db.commit();
                    db.desconectar();

                } catch (Exception e) {
                    out.print("<script>alert('La promoción o descuento ya existe para esta categoría en el rango de fechas específicado');</script>");
                }
            out.write("<script>setTimeout(function(){window.location.href='" + application.getContextPath() + "/administrarinformacion.jsp'},300);</script>");

        %>

        <jsp:include page="../footer.jsp"/>
    </body>
</html>