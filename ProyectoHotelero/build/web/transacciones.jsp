<%-- 
    Document   : transacciones
    Created on : 29/11/2016, 02:18:11 PM
    Author     : Denisse
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>


<%
    if (session.getAttribute("Rol") == null || !session.getAttribute("Rol").equals("Administrador")) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="./css/transacciones.css">   
         <script type="text/javascript" src="<%= application.getContextPath()+"/js/transacciones.js"%>"></script
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
                                                <th>Id Ficha</th>
                                                <th>Cliente</th>
                                                <th>Habitación</th>
                                                <th>Fecha Ingreso</th>
                                                 <th>Fecha Salida</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try {
                                                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                    db.conectar();
                                                    String sql = "select IdFichaCliente, PrimerNombre, PrimerApellido, IdHabitacion, FechaIngreso, FechaSalida"
                                                            + " from FichaCliente join Reservacion on FichaCliente.IdReservacion=Reservacion.IdReservacion join Cliente on "
                                                            + " Reservacion.IdCliente=Cliente.IdCliente where Reservacion.Estado='Checkin'";
                                                    db.prepare(sql);
                                                    db.query.execute();
                                                    ResultSet rs = db.query.getResultSet();
                                                    while (rs.next()) {
                                            %>             

                                            <tr>
                                                <td><%= rs.getString(1)%></td>
                                                 <input type="text" value="<%=rs.getString(1)%>"name="text-id-reservacion-transacciones" style="display: none;" />  
                                                <td><%= rs.getString(2) + " " + rs.getString(3)%></td>
                                                <td><%= rs.getString(4)%></td>
                                                <td><%= rs.getString(5)%></td>
                                                <%if(rs.getString(6)==null){%>
                                                <td></td>
                                                <td><input type="submit" name="checkout" value="Checkout" class="btn btn-primary"/></td>
                                        
                                                <%}else{%>
                                                    <td><%= rs.getString(6)%></td>
                                                <%}%>
                                            </tr>
                                            <%  } db.desconectar();
                                                }catch(Exception e){
                            }

                                            %>
                                        </tbody>
                                    </table>
                                </form>
                                <%if (request.getParameter("checkout") != null) {
                                    Double subtotal = 0.0;
                                    String enviardoc="";
                                    Double costoHabitacion = 0.0;
                                    try {
                                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        Date date = new Date();
                                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                        db.conectar();
                                        String sql = "select PrimerNombre, PrimerApellido, IdHabitacion, datediff('d',FichaCliente.FechaIngreso,#"+dateFormat.format(date)+"#)"
                                                     + ",Precio, IdCategoria, FechaReservacion, IdFichaCliente from Reservacion join FichaCliente on FichaCliente.IdReservacion=Reservacion.IdReservacion join Cliente on "
                                                     + " Reservacion.IdCliente=Cliente.IdCliente join Habitacion on Reservacion.IdHabitacion=Habitacion.IdHabitacion"
                                                + "  join Categoria on Habitacion.IdCategoria=Categoria.IdCategoria where FichaCliente.IdFichaCliente="+request.getParameter("text-id-reservacion-transacciones");
                                        db.prepare(sql);
                                        db.query.execute();
                                        ResultSet rs = db.query.getResultSet();
                                        while (rs.next()) {
                                %>
                                <h4>Realizar Pago</h4>
                                    <br>
                                    <label >FACTURA</label>
                                    <%enviardoc+="<!DOCTYPE html><html><head><meta charset='UTF-8'></head><body><br><label>FACTURA</label><br><br>";%>
                                    <br>
                                    <br>
                                    <label >FECHA: <%= dateFormat.format(date)%></label>
                                    <br>
                                    <%enviardoc+="<label>FECHA: "+dateFormat.format(date)+"</label><br>";%>
                                    <label >Cliente: <%= rs.getString(1) +" "+rs.getString(2)%></label>
                                    <br>
                                    <%enviardoc+="<label>Cliente: "+rs.getString(1)+" "+rs.getString(2)+"</label><br>";%>
                                    <label >Habitación: <%= rs.getString(3)%></label>
                                    <br>
                                    <%enviardoc+="<label>Habitacion: "+rs.getString(3)+"</label><br>";%>
                                    <label >Días: <%= rs.getString(4)%> </label>
                                    <br>
                                    <%enviardoc+="<label>Dias: "+rs.getString(4)+"</label><br>";%>
                                    <label >Costo Total Habitación:‎  <%= "$"+rs.getDouble(5)+"*$"+rs.getInt(4)%> = <%= "$"+rs.getDouble(5)*rs.getDouble(4)%> <%subtotal+=rs.getDouble(5)*rs.getDouble(4); costoHabitacion=subtotal;%></label>
                                    <br>
                                    <br>
                                    <%enviardoc+="<label>Costo Total Habitacion:$"+rs.getDouble(5)+"*$"+rs.getInt(4)+" = "+"$"+(rs.getDouble(5)*rs.getDouble(4))+"</label><br><br>";%>
                                    <label >Servicios Adquiridos: </label>
                                    <br>
                                    <%enviardoc+="<label>Servicios Adquiridos:</label><br>";%>
                                    <%String sql1 = "select Nombre, Precio, Fecha from FichaClienteServicio join Servicio on FichaClienteServicio.IdServicio="
                                            + " Servicio.IdServicio where IdFichaCliente="+request.getParameter("text-id-reservacion-transacciones");
                                    
                                        db.prepare(sql1);
                                        db.query.execute();
                                        ResultSet rs1 = db.query.getResultSet();
                                        while(rs1.next()){
                                            
                                        subtotal+= rs1.getDouble(2);
                                    %>
                                        <label ><%="-            "%><%=rs1.getString(1)%> Fecha:<%=rs1.getString(3).substring(0,10)%> Costo:<%="$"+rs1.getDouble(2)%></label>
                                        <br>
                                        <%enviardoc+="<label>-"+rs1.getString(1)+" Fecha:"+rs1.getString(3).substring(0,10)+" Costo:$"+rs1.getDouble(2)+"</label><br>";%>
                                    <%} %>
                                    <br>
                                    <label >Sub Total: <%="$"+subtotal%></label>
                                    <br>
                                    <br>
                                    <%enviardoc+="<br><label>Sub Total:$"+subtotal+"</label><br><br>";%>
                                    <label >Promocionnes Y Descuentos:</label>
                                    <br>
                                    <%enviardoc+="<label>Promocionnes Y Descuentos:</label><br>";%>
                                    <%String sql2 = "select Tipo, Porcentaje from CategoriaDescuentoPromocion "
                                            + " where IdCategoria="+rs.getString(6)+" and FechaInicio<='"+rs.getString(7)+"' and FechaFin>='"+rs.getString(7)+"'";
                                    
                                        db.prepare(sql2);
                                        db.query.execute();
                                        ResultSet rs2 = db.query.getResultSet();
                                        String tipopromocion="Promocion";
                                        while(rs2.next()){
                                            if(rs2.getInt(1)==1)
                                                tipopromocion="Descuento";
                                    %>
                                    <label ><%=tipopromocion%> Porcentaje:<%=rs2.getDouble(2)+"%"%>  Monto:<%=costoHabitacion*(rs2.getDouble(2)/100.00)%> <%subtotal-=costoHabitacion*(rs2.getDouble(2)/100.00);%></label>
                                    <br>
                                    <%enviardoc+="<label>"+tipopromocion+" Porcentaje:"+rs2.getDouble(2)+"%"+" Monto:"+costoHabitacion*(rs2.getDouble(2)/100.00)+"</label><br>";%>
                                    <%} %>
                                    <br>
                                    <label >Monto total a pagar: <%="$"+subtotal%></label>
                                    <br>
                                    <br>
                                    <%enviardoc+="<br><label>Monto total a pagar:$"+subtotal+"</label><br></body></html>";%>
                                    <label >Forma de Pafo:</label>
                                    <select id="select-formapago"  class="selectpicker form-control" onchange="formaPago()">
                                        <option value="0">Efectivo</option>
                                        <option value="1">Tarjeta de Credito</option>
                                    </select>
                                    <div id="tarjeta">
                                    <label >Número de Tarjeta:</label>
                                    <input type="text" name="" value="" class="form-control texto"/>
                                    <br>
                                    <button type="button" class="btn btn-primary btn-circle">?</button> Comprobar
                                    </div>
                                    <br>
                                    <br>
                                    <br>
                                    <form action="factura.jsp" method="POST">
                                         <input type="text" value="<%=dateFormat.format(date)%>" name="text-fechasalida" style="display: none;" /> 
                                        <input type="text" value="<%=rs.getString(8)%>" name="text-idfichacliente" style="display: none;" /> 
                                        <input type="text" value="<%=enviardoc%>"name="text-enviardoc" style="display: none;" /> 
                                        <input type="submit" name="button-generarfactura" value="Generar Factura" class="btn btn-primary"/>
                                    </form>
                                <%
                                      } db.desconectar();
                                    }catch(Exception e){
                                    
                                        out.print("<script>alert('"+e.toString()+"');</script>");
                                     }
                                        
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
