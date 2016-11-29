<%-- 
    Document   : reservar
    Created on : 28/11/2016, 09:38:07 PM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/reservar.css">
        <title>Reservaciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="reservar-img">
            <img src="./images/hotel/habitaciones.jpg"/>
        </div>
        <div class="reservar">
            <form method="POST" action="reservacionesHechas.jsp">
                <div class="row">
                    <div class="col-md-6">
                        <label>Categoría:</label>
                        <select name="categoria" class="selectpicker form-control">
                            <option>Normal</option>
                            <option>Ejecutiva</option>
                            <option>VIP</option>
                        </select>
                        <label >Fecha de llegada:</label>
                        <input type="date" class="form-control"  >
                        <label >Fecha de salida:</label>
                        <input type="date" class="form-control"  >
                    </div>
                    <div class="col-md-6">
                        <label>Características:</label>
                        <ul class="list-group">
                            <li class="list-group-item">Dos camas matrimoniales</li>
                            <li class="list-group-item">Televisor</li>
                            <li class="list-group-item">Aire acondicionado</li>
                            <li class="list-group-item">Secador</li>
                        </ul>
                    </div>
                </div>
                
                 <div class="row">
                    <div class="col-md-6">
                        <input type="button" value="Realizar búsqueda" class="btn btn-primary"/>
                    </div>
                     <div class="col-md-6">
                       Habitaciones agregadas:
                    </div>
                 </div>
                <br>
                <div class="row">
                    <div class="col-md-6">
                        Presionar las habitaciones a reservar:
                        Dispoible: verde,
                        Ocupada: rojo,
                        Otra categoría: azul
                    </div>
                    <div class="col-md-6">
                       <select  class="selectpicker form-control">
                            <option>15</option>
                            <option>69</option>
                        </select>
                    </div>
                 </div>
                <br>
                <div class="row">
                    <div class="col-md-6">
                        <table border="1">
                           <tbody>
                                <tr>
                                    <td><input type="button" value="17" class="btn btn-success"/></td>
                                    <td><input type="button" value="28" class="btn btn-info"/></td>
                                    <td><input type="button" value="36" class="btn btn-danger"/></td>
                                    <td><input type="button" value="44" class="btn btn-danger"/></td>
                                    <td><input type="button" value="55" class="btn btn-info"/></td>
                                    <td><input type="button" value="67" class="btn btn-success"/></td>
                                    <td><input type="button" value="71" class="btn btn-info"/></td>
                                    <td><input type="button" value="89" class="btn btn-info"/></td>
                                    <td><input type="button" value="93" class="btn btn-info"/></td>
                                    <td><input type="button" value="10" class="btn btn-success"/></td>
                                </tr>
                                 <tr>
                                    <td><input type="button" value="11" class="btn btn-danger"/></td>
                                    <td><input type="button" value="12" class="btn btn-info"/></td>
                                    <td><input type="button" value="13" class="btn btn-info"/></td>
                                    <td><input type="button" value="14" class="btn btn-danger"/></td>
                                    <td><input type="button" value="15" class="btn btn-success"/></td>
                                    <td><input type="button" value="16" class="btn btn-success"/></td>
                                    <td><input type="button" value="17" class="btn btn-success"/></td>
                                    <td><input type="button" value="18" class="btn btn-info"/></td>
                                    <td><input type="button" value="19" class="btn btn-success"/></td>
                                    <td><input type="button" value="20" class="btn btn-success"/></td>
                                </tr>
                                 <tr>
                                    <td><input type="button" value="11" class="btn btn-danger"/></td>
                                    <td><input type="button" value="12" class="btn btn-info"/></td>
                                    <td><input type="button" value="13" class="btn btn-info"/></td>
                                    <td><input type="button" value="14" class="btn btn-danger"/></td>
                                    <td><input type="button" value="15" class="btn btn-success"/></td>
                                    <td><input type="button" value="16" class="btn btn-success"/></td>
                                    <td><input type="button" value="17" class="btn btn-success"/></td>
                                    <td><input type="button" value="18" class="btn btn-info"/></td>
                                    <td><input type="button" value="19" class="btn btn-success"/></td>
                                    <td><input type="button" value="20" class="btn btn-success"/></td>
                                </tr>
                                 <tr>
                                    <td><input type="button" value="15" class="btn btn-success"/></td>
                                    <td><input type="button" value="23" class="btn btn-info"/></td>
                                    <td><input type="button" value="33" class="btn btn-danger"/></td>
                                    <td><input type="button" value="42" class="btn btn-danger"/></td>
                                    <td><input type="button" value="50" class="btn btn-info"/></td>
                                    <td><input type="button" value="63" class="btn btn-success"/></td>
                                    <td><input type="button" value="72" class="btn btn-info"/></td>
                                    <td><input type="button" value="84" class="btn btn-info"/></td>
                                    <td><input type="button" value="99" class="btn btn-info"/></td>
                                    <td><input type="button" value="10" class="btn btn-success"/></td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                    <div class="col-md-6">
                        
                        <input type="submit" value="Aceptar" class="btn btn-primary"/>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
