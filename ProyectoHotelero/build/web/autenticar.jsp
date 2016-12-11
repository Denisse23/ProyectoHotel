<%-- 
    Document   : autenticar
    Created on : 11/12/2016, 03:06:34 PM
    Author     : Denisse
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%
    if (session.getAttribute("Rol") != null) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <body>
        <jsp:include page="header.jsp"/>

        <% if (request.getParameter("text-usuario-login") != null) {
                try {
                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                    db.conectar();
                    String sql = ("select Rol from Usuario where Usuario=? and Password=?");
                    db.prepare(sql);
                    db.query.setString(1, request.getParameter("text-usuario-login"));
                    db.query.setString(2, request.getParameter("text-pass-login"));

                    db.query.execute();
                    ResultSet rs = db.query.getResultSet();
                    String rol = "";
                    while (rs.next()) {
                        rol = rs.getString(1);
                    }

                    if (!rol.equals("")) {
                        if (rol.equals("Administrador")) {
                           
                                String sql1 = "select Last(IdCaja) from Caja";
                                db.prepare(sql1);
                                db.query.execute();
                                ResultSet rs1 = db.query.getResultSet();
                                while (rs1.next()) {
                                    session.setAttribute("idcaja", rs1.getInt(1));

                                }
                        }
                        session.setAttribute("Usuario",request.getParameter("text-usuario-login"));
                        session.setAttribute("Rol", rol);
                        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
                        
                    }else{
                        out.print("<script>alert('El usuario o contraseña estan incorrectos');</script>");
                        out.write("<script>setTimeout(function(){window.location.href='" + application.getContextPath() + "/login.jsp'},300);</script>");
                    }
                    db.desconectar();

                } catch (Exception e) {
                }
            }

        %>
        <jsp:include page="footer.jsp"/>
    </body>
</html>