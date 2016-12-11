<%-- 
    Document   : informacion
    Created on : 28/11/2016, 07:47:02 PM
    Author     : Denisse
--%>
<%
   if(session.getAttribute("Rol")!=null && !session.getAttribute("Rol").equals("Cliente")){
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
        <link rel="stylesheet" type="text/css" href="./css/informacion.css">
        <title>Acerca de Nosotros</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="info">
            <%
                try {
                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                    db.conectar();
                    String sql = "select Nombre, Mision, Vision, Telefono, Email, Pais, Ciudad, Ubicacion from Informacion";
                    db.prepare(sql);
                    db.query.execute();
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <h3> <%= rs.getString(1).toUpperCase() %> </h3>
            <br>
            <div class="row">
                <div class="col-md-4 iz">
                    Misión:
                </div>
                <div class="col-md-8">
                    <%= rs.getString(2) %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 iz">
                    Visión:
                </div>
                <div class="col-md-8">
                    <%= rs.getString(3) %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 iz">
                    Teléfono:
                </div>
                <div class="col-md-6">
                     <%= rs.getString(4) %>
                </div>
            </div>
             <div class="row">
                <div class="col-md-4 iz">
                    Email:
                </div>
                <div class="col-md-6">
                     <%= rs.getString(5) %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 iz">
                    País:
                </div>
                <div class="col-md-6">
                   <%= rs.getString(6) %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 iz">
                    Ciudad:
                </div>
                <div class="col-md-6">
                    <%= rs.getString(7) %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 iz">
                    Ubicación:
                </div>
                <div class="col-md-8">
                    <%= rs.getString(8) %>
                </div>
            </div>
            <% }
                db.desconectar();
                } catch (Exception e) {
                }
            %>
        
            
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
