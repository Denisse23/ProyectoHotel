<%-- 
    Document   : struc
    Created on : 27/11/2016, 11:22:22 PM
    Author     : Denisse
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<div class="line-cafe"></div>
<div class="line-black"><a class="ubicacion-h" href="ubicacion.jsp">Ubicación</a></div>
<header class="Principal_header">
    <%
        try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "select Nombre from Informacion";
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
    %>
    <h2> <%= rs.getString(1).toUpperCase() %></h2>
    <% }
        db.desconectar();
        } catch (Exception e) {
        }
    %>
    <% if (session.getAttribute("Rol") == null) {%>
    <div class="header-content">
        <ul class="nav nav-pills">
            <li><a href="<%= application.getContextPath() + "/index.jsp"%>" title="Home">Home</a></li>
            <li><a href="<%= application.getContextPath() + "/informacion.jsp"%>" title="Acerca de Nosotros">Hotel</a></li>
            <li><a href="<%= application.getContextPath() + "/reservar.jsp"%>" title="Reservaciones">Reservar</a></li>
            <li><a href="<%= application.getContextPath() + "/login.jsp"%>" title="Entrar">Iniciar Sesión</a></li>
            <li><a href="<%= application.getContextPath() + "/registrarse.jsp"%>" title="Registrarse">Registrarse</a></li>
        </ul>
    </div>
    <% } else if (session.getAttribute("Rol").equals("Cliente")) {%>
    <div class="header-content">
        <ul class="nav nav-pills">
            <li><a href="<%= application.getContextPath() + "/index.jsp"%>" title="Home">Home</a></li>
            <li><a href="<%= application.getContextPath() + "/informacion.jsp"%>" title="Acerca de Nosotros">Hotel</a></li>
            <li><a href="<%= application.getContextPath() + "/reservar.jsp"%>" title="Reservaciones">Reservar</a></li>
            <li><a href="<%= application.getContextPath() + "/reservacionesHechas.jsp"%>" title="Mis Reservaciones">Mis Reservaciones</a></li>
            <li><a href="<%= application.getContextPath() + "/cerrarsesion.jsp"%>" title="Salir">Salir</a></li>
        </ul>
    </div>
    <% } else if (session.getAttribute("Rol").equals("Administrador")) {%>
    <div class="header-content-admin">
        <ul class="nav nav-pills" >
            <li><a href="<%= application.getContextPath() + "/registrarempleado.jsp"%>" title="Registrar Empleado">Registrar Empleado</a></li>
            <li><a href="<%= application.getContextPath() + "/reservarAd.jsp"%>" title="Reservar">Reservar</a></li>
            <li><a href="<%= application.getContextPath() + "/reservaciones.jsp"%>" title="Reservaciones">Reservaciones</a></li>
            <li><a href="<%= application.getContextPath() + "/transacciones.jsp"%>" title="Transacciones">Transacciones</a></li>
            <li><a href="<%= application.getContextPath() + "/reportes.jsp"%>" title="Reportes">Reportes</a></li>
            <li><a href="<%= application.getContextPath() + "/administrarinformacion.jsp"%>" title="Administrar Información">Administrar Información</a></li>
            <li><a href="<%= application.getContextPath() + "/cerrarsesion.jsp"%>" title="Salir">Salir</a></li>
        </ul>
    </div>
    <% } else if (session.getAttribute("Rol").equals("Gerente")) {%>
    <div class="header-content-gerente">
        <ul class="nav nav-pills" >
            <li><a href="<%= application.getContextPath() + "/reportes.jsp"%>" title="Reportes">Reportes</a></li>
            <li><a href="<%= application.getContextPath() + "/bitacora.jsp"%>" title="Bitacora">Bitacora</a></li>
            <li><a href="<%= application.getContextPath() + "/cerrarsesion.jsp"%>" title="Salir">Salir</a></li>
        </ul>
    </div>
    <% } else {%>

    <div class="header-content">
        <ul class="nav nav-pills">
            <li><a href="<%= application.getContextPath() + "/index.jsp"%>" title="Home">Home</a></li>
            <li><a href="<%= application.getContextPath() + "/informacion.jsp"%>" title="Acerca de Nosotros">Hotel</a></li>
            <li><a href="<%= application.getContextPath() + "/reservar.jsp"%>" title="Reservaciones">Reservar</a></li>
            <li><a href="<%= application.getContextPath() + "/login.jsp"%>" title="Entrar">Iniciar Sesión</a></li>
            <li><a href="<%= application.getContextPath() + "/registrarse.jsp"%>" title="Registrarse">Registrarse</a></li>
        </ul>
    </div>
    <% }%>
</header>

