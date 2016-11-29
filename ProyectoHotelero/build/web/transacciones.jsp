<%-- 
    Document   : transacciones
    Created on : 29/11/2016, 02:18:11 PM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="./css/transacciones.css">   
        <title>Transacciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="Trans">


            <div class="container">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Pagos Clientes</a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <h4>Fichas Clientes</h4>
                                <br>
                                <form  method="POST" action="transacciones.jsp#collapse1">
                                    <table class="table table-striped">
                                        <thead >
                                            <tr>
                                                <th>Cliente</th>
                                                <th>Habitación</th>
                                                <th>Fecha Ingreso</th>
                                                <th>Fecha Salida</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Osvaldo Flores</td>
                                                <td>15</td>
                                                <td>10-12-2016</td>
                                                <td>12-12-2016</td>
                                                <td><input type="submit" name="checkout" value="Checkout" class="btn btn-primary"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                                <%
                                    if (request.getParameter("checkout") != null) {
                                %>
                                <h4>Realizar Pago</h4>
                                <form  method="POST" >
                                    <label >Cliente: ...........</label>
                                    <br>
                                    <label >Habitación: .......</label>
                                    <br>
                                    <label >Monto: .......</label>
                                    <br>
                                    <label >Forma de Pafo:</label>
                                    <select  class="selectpicker form-control">
                                        <option>Efectivo</option>
                                        <option>Tarjeta de Credito</option>
                                    </select>
                                    <label >Número de Tarjeta:</label>
                                    <input type="text" name="" value="" class="form-control texto"/>
                                    <br>
                                    <button type="button" class="btn btn-primary btn-circle">?</button> Comprobar
                                    <br>
                                    <br>
                                    <br>
                                    <input type="standar"  value="Generar Factura" class="btn btn-primary"/>
                                </form>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">Abrir/Cierre Caja</a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Movimiento:
                                    </div>
                                    <div class="col-md-4">
                                        Cierre
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Fecha:
                                    </div>
                                    <div class="col-md-4">
                                        10-12-2016
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Hora Inicio:
                                    </div>
                                    <div class="col-md-4">
                                        08:00
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Hora cierre:
                                    </div>
                                    <div class="col-md-4">
                                        17:00
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Cantidad Inicial:
                                    </div>
                                    <div class="col-md-4">
                                        ......
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Cantidad Cierre:
                                    </div>
                                    <div class="col-md-4">
                                        ........
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        <input type="button" value="Aceptar" class="btn btn-primary"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div> 
            </div>

        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
