<%-- 
    Document   : struc
    Created on : 27/11/2016, 11:22:22 PM
    Author     : Denisse
--%>

<div class="line-cafe"></div>
<div class="line-black"></div>
<header class="Principal_header">
    <h2> HOTEL NACIONAL</h2>
    <% if (session.getAttribute("Rol") == null) { %>
    <div class="header-content">
        <ul class="nav nav-pills">
            <li><a href="index.jsp" title="Home">Home</a></li>
            <li><a href="informacion.jsp" title="Acerca de Nosotros">Hotel</a></li>
            <li><a href="reservar.jsp" title="Reservaciones">Reservar</a></li>
            <li><a href="login.jsp" title="Entrar">Iniciar Sesión</a></li>
            <li><a href="registrarse.jsp" title="Registrarse">Registrarse</a></li>
        </ul>
    </div>
    <% } else if (session.getAttribute("Rol").equals("Cliente")) { %>
    <div class="header-content">
        <ul class="nav nav-pills">
            <li><a href="index.jsp" title="Home">Home</a></li>
            <li><a href="informacion.jsp" title="Acerca de Nosotros">Hotel</a></li>
            <li><a href="reservar.jsp" title="Reservaciones">Reservar</a></li>
            <li><a href="reservacionesHechas.jsp" title="Mis Reservaciones">Mis Reservaciones</a></li>
            <li><a href="cerrarsesion.jsp" title="Salir">Salir</a></li>
        </ul>
    </div>
    <% } else if (session.getAttribute("Rol").equals("Administrador")) {%>
    <div class="header-content-admin">
        <ul class="nav nav-pills" >
            <li><a href="registrarempleado.jsp" title="Registrar Empleado">Registrar Empleado</a></li>
            <li><a href="reservarAd.jsp" title="Reservar">Reservar</a></li>
            <li><a href="reservaciones.jsp" title="Reservaciones">Reservaciones</a></li>
            <li><a href="transacciones.jsp" title="Transacciones">Transacciones</a></li>
            <li><a href="reportes.jsp" title="Reportes">Reportes</a></li>
            <li><a href="administrarinformacion.jsp" title="Administrar Información">Administrar Información</a></li>
            <li><a href="cerrarsesion.jsp" title="Salir">Salir</a></li>
        </ul>
    </div>
    <% } else if (session.getAttribute("Rol").equals("Gerente")) {%>
    <div class="header-content-gerente">
        <ul class="nav nav-pills" >
            <li><a href="reportes.jsp" title="Reportes">Reportes</a></li>
            <li><a href="bitacora.jsp" title="Bitacora">Bitacora</a></li>
            <li><a href="cerrarsesion.jsp" title="Salir">Salir</a></li>
        </ul>
    </div>
    <% }%>
</header>

