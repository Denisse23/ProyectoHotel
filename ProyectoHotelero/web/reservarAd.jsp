<%-- 
    Document   : reservarAd
    Created on : 29/11/2016, 12:16:00 PM
    Author     : Denisse
--%>
<%
   if(session.getAttribute("Rol")==null || !session.getAttribute("Rol").equals("Administrador")){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/reservar.css">
        <title>Reservar</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="reservar">
            <table border="0"  class="division">
                <tbody>
                    <tr>
                        <td class="Info"><form method="POST" >
                                <label>Categoría:</label>
                                <select name="categoria" class="selectpicker form-control">
                                    <option>Normal</option>
                                    <option>Ejecutiva</option>
                                    <option>VIP</option>
                                </select>
                                <br>
                                <% if (session.getAttribute("Rol") != null) { %>
                                <label >Fecha de llegada:</label>
                                <input type="date" class="form-control"  >
                                <label >Fecha de salida:</label>
                                <input type="date" class="form-control"  >


                                <br>
                                <input type="button" value="Realizar búsqueda" class="btn btn-primary"/>
                                <br>
                                <br>
                                Presionar las habitaciones a reservar:
                                Dispoible: verde,
                                Ocupada: rojo,
                                Otra categoría: azul
                                <br>
                                <table border="0" class="diagrama">
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
                                <br>
                                <br>
                                Habitaciones agregadas:

                                <br>

                                <select  class="selectpicker form-control">
                                    <option>15</option>
                                    <option>69</option>
                                </select>
                                <br>
                                Cliente:
                                <select  class="selectpicker form-control">
                                    <option>Olvaldo Flores</option>
                                    <option>Maria Perez</option>
                                </select>
                                <br>


                                <input type="submit" value="Aceptar" class="btn btn-primary"/>

                                <% } else {%>
                                <input type="button" value="Iniciar Sesión" class="btn btn-primary"/>
                                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

                                <% }%>
                            </form></td>
                        <td >
                            <div class="panel panel-default">
                                <label>Características:</label>
                                <ul class="list">
                                    <li >Dos camas matrimoniales</li>
                                    <li>Televisor</li>
                                    <li >Aire acondicionado</li>
                                    <li >Secador</li>
                                </ul>
                            </div>
                            <img src="./images/hotel/habitaciones.jpg"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>

</html>
