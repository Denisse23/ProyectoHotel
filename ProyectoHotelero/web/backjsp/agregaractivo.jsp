<%-- 
    Document   : agregaractivo.jsp
    Created on : 2/12/2016, 05:11:56 PM
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
        ///////////////////agregar nuevo-activo
            int cont = 0;
            try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String sql=("select IdActivo, Nombre from Activos where Nombre=?");
                db.prepare(sql);
                db.query.setString(1, request.getParameter("text-nombre-nuevo-activo"));
                db.query.execute();
                ResultSet rs = db.query.getResultSet();

                while (rs.next()) {
                    cont++;
                }
                db.desconectar();

            } catch (Exception e) {
            }
            if (cont == 0) {
                try {
                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                    db.conectar();
                    String sql = "insert into Activos (Nombre, CantidadDisponibles) values"
                                 + "(?,?)";
                    db.prepare(sql);
                    db.query.setString(1, request.getParameter("text-nombre-nuevo-activo"));
                    db.query.setString(2,request.getParameter("num-cantidad-nuevo-activo"));
                    int contador=db.query.executeUpdate();
                    if (contador == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Activos'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                        out.print("<script>alert('El activo se agregó correctamente');</script>");
                    }
                    db.commit();
                    db.desconectar();

                } catch (Exception e) {
                    out.print("<script>alert('" + e.toString() + "');</script>");
                }
            } else {
                out.print("<script>alert('El nombre del activo no puede ser duplicado');</script>");
            }
            out.write("<script>setTimeout(function(){window.location.href='" + application.getContextPath() + "/administrarinformacion.jsp'},300);</script>");

        %>

        <jsp:include page="../footer.jsp"/>
    </body>
</html>