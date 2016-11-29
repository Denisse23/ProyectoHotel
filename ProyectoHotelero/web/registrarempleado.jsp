<%-- 
    Document   : registrarempleado
    Created on : 29/11/2016, 11:59:11 AM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/registraempleado.css">
        <title>Registro Empleados</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="registrarE">
            <form method="POST" >
                <div class="form-group">
                    <label >Primer Nombre:</label>
                    <input type="text" class="form-control" >
                    <label >Segundo Nombre:</label>
                    <input type="text" class="form-control" >
                     <label >Primer Apellido:</label>
                    <input type="text" class="form-control" >
                     <label >Segundo Apellido:</label>
                    <input type="text" class="form-control" >
                    <label >Rol:</label>
                    <input type="text" class="form-control" >
                    <br>
                    <input type="submit" class="btn btn-primary" value="Registrar" />
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>

    </body>
</html>
