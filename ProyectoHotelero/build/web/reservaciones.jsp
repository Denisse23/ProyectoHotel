<%-- 
    Document   : reservaciones
    Created on : 29/11/2016, 01:27:41 PM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/reservaciones.css">
        <title>Reservaciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="revs">
            <form  method="POST">
                <table class="table table-striped">
                    <thead >
                        <tr>
                            <th>Cliente</th>
                            <th>Habitación</th>
                            <th>Fecha Reservación</th>
                            <th>Fecha LLegada</th>
                            <th>Fecha Salida</th>
                            <th>Estado Actual</th>
                            <th>Opciones de Estado</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Osvaldo Flores</td>
                            <td>15</td>
                            <td>5-12-2016</td>
                            <td>10-12-2016</td>
                            <td>12-12-2016</td>
                            <td>Espera</td>
                            <td><select name="estado" class="selectpicker form-control">
                                    <option>Aceptada</option>
                                    <option>Rechazada</option>
                                    <option>Cancelada</option>
                                    <option>Checkin</option>
                                    <option>Checkout</option>
                                </select></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
