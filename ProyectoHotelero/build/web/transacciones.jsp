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
         <script type="text/javascript" src="<%= application.getContextPath()+"/js/transacciones.js"%>"></script>
        <title>Transacciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%
            
            if(request.getParameter("button-abrircaja")!=null){
            DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date1 = new Date();
                try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "update Caja set FechaCierre=?, CantidadCierre=? where IdCaja=?";
            db.prepare(sql);
            db.query.setString(1, dateFormat1.format(date1));
            db.query.setString(2, request.getParameter("text-monto-cierre-caja"));
            db.query.setString(3, session.getAttribute("idcaja").toString());
            int contador= db.query.executeUpdate();
            if (contador == 1) {
                
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('update','Caja'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat1.format(date1));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
            }
            String sql1 = "insert into Caja (FechaInicio, CantidadInicial) values(?,?)";
            db.prepare(sql1);
            db.query.setString(1, dateFormat1.format(date1));
            db.query.setString(2, request.getParameter("text-monto-cierre-caja"));
            int contador1= db.query.executeUpdate();
            if (contador1 == 1) {
                
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Caja'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat1.format(date1));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
            }
            String sql2 = "select Last(IdCaja) from Caja";
            db.prepare(sql2);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while(rs.next()){
                session.setAttribute("idcaja", rs.getInt(1));
            }
            db.commit();
            db.desconectar();
            

        } catch (Exception e) {
            out.print("<script>alert('" + e.toString() + "');</script>");
        }
            }
        
        %>
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
                                <%if (request.getParameter("checkout") != null ||  request.getParameter("button-comprobartarjeta")!=null) {
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
                                    <label >Costo Total Habitación:?  <%= "$"+rs.getDouble(5)+"*$"+rs.getInt(4)%> = <%= "$"+rs.getDouble(5)*rs.getDouble(4)%> <%subtotal+=rs.getDouble(5)*rs.getDouble(4); costoHabitacion=subtotal;%></label>
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
                                       <% if(request.getParameter("button-comprobartarjeta")==null){%>
                                        <option value="0">Efectivo</option>
                                        <option value="1">Tarjeta de Credito</option>
                                       <%}else{%>
                                       <option value="0">Efectivo</option>
                                        <option value="1" selected>Tarjeta de Credito</option>
                                       <%}%>
                                    </select>
                                    <form action="transacciones.jsp" method="POST">

                                    <div id="tarjeta">
                                    <label >Número de Tarjeta:</label>
                                    <input type="text" name="text-numerotarjeta" value="" class="form-control texto"/>
                                    <br>
                                     <input type="text" value="<%=subtotal%>" name="text-monto" style="display: none;" /> 
                                     <input type="text" value="<%=request.getParameter("text-id-reservacion-transacciones")%>" name="text-id-reservacion-transacciones" style="display: none;" /> 
                                    <input type="submit" name="button-comprobartarjeta"class="btn btn-primary btn-circle" value="?"/>Comprobar
                                    </div>
                                    </form>
                                    
                                    <%
                                        if(request.getParameter("button-comprobartarjeta")!=null){
                                            boolean haytarjeta=false;
                                              
    try {
	tarjetascredito.ExisteTarjeta_Service service = new tarjetascredito.ExisteTarjeta_Service();
	tarjetascredito.ExisteTarjeta port = service.getExisteTarjetaPort();
	 // TODO initialize WS operation arguments here
	java.lang.String numerotarjeta = request.getParameter("text-numerotarjeta") ;
	// TODO process result here
	haytarjeta = port.existeTarjeta(numerotarjeta);
    } catch (Exception ex) {
	
    }
        if(haytarjeta){
    boolean haymonto = false;
    try {
	tarjetascredito.DebitarMonto_Service service = new tarjetascredito.DebitarMonto_Service();
	tarjetascredito.DebitarMonto port = service.getDebitarMontoPort();
	 // TODO initialize WS operation arguments here
	java.lang.String numerotarjeta = request.getParameter("text-numerotarjeta");
	java.lang.String monto = request.getParameter("text-monto");
	// TODO process result here
	haymonto = port.dibitarMonto(numerotarjeta, monto);
    } catch (Exception ex) {
	// TODO handle custom exceptions here
    }
            if(haymonto){
                %>
                <br>
                Se debitó el monto correctamente
                <br>
                
                                    <br>
                                    <br>
                 <form action="factura.jsp" method="POST">
                                         <input type="text" value="<%=dateFormat.format(date)%>" name="text-fechasalida" style="display: none;" />
                                         <input type="text" value="<%=subtotal%>" name="text-totalpago" style="display: none;" /> 
                                        <input type="text" value="<%=rs.getString(8)%>" name="text-idfichacliente" style="display: none;" /> 
                                        <input type="text" value="<%=enviardoc%>"name="text-enviardoc" style="display: none;" /> 
                                        <input type="submit" name="button-generarfactura" value="Generar Factura" class="btn btn-primary"/>
                                    </form>
                <%
            }else{
                out.print("No hay saldo disponible para realizar el pago");
            }

        }else{
            out.print("El número de tarjeta no existe");
        }
    
   

                                        }else{
                                            %>
                                            <div id="fac">
                                                <br>
                                    <br>
                                    <br>
                                             <form action="factura.jsp" method="POST">
                                         <input type="text" value="<%=dateFormat.format(date)%>" name="text-fechasalida" style="display: none;" />
                                         <input type="text" value="<%=subtotal%>" name="text-totalpago" style="display: none;" /> 
                                        <input type="text" value="<%=rs.getString(8)%>" name="text-idfichacliente" style="display: none;" /> 
                                        <input type="text" value="<%=enviardoc%>"name="text-enviardoc" style="display: none;" /> 
                                        <input type="submit" name="button-generarfactura" value="Generar Factura" class="btn btn-primary"/>
                                    </form>
                                            </div>
                                        <%
                                        }
                                    
                                    %>
                                   
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
                            <h4>Actual Caja</h4>
                            <br>
                             <%Double monto=0.0;
                                 try {
                                 Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                  db.conectar();
                                  String sql = "select FechaInicio, CantidadInicial from Caja where IdCaja="+session.getAttribute("idcaja");
                                  db.prepare(sql);
                                  db.query.execute();
                                  ResultSet rs = db.query.getResultSet();
                                   while (rs.next()) {
                                %>  
                                    <div class="row">
                                    <div class="col-md-4 iz">
                                        Id Caja:
                                    </div>
                                    <div class="col-md-4">
                                        <%=session.getAttribute("idcaja")%>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Fecha Inicio:
                                    </div>
                                    <div class="col-md-4">
                                        <%=rs.getString(1)%>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Cantidad Inicial:
                                    </div>
                                    <div class="col-md-4">
                                       <%=rs.getDouble(2)%>
                                    </div>
                                </div>
                          <%
                                String sql1 = "select Monto from PagoCliente where IdCaja="+session.getAttribute("idcaja");
                                  db.prepare(sql1);
                                  db.query.execute();
                                  ResultSet rs1 = db.query.getResultSet();
                                  
                                  while (rs1.next()) {
                                     monto+=rs1.getDouble(1);
                                  }
                                   monto+=rs.getDouble(2);
                           %>  
                                <div class="row">
                                    <div class="col-md-4 iz">
                                        Cantidad Cierre:
                                    </div>
                                    <div class="col-md-4">
                                       <%="$"+monto%>
                                    </div>
                                </div>
                                <br>
                                <% } db.desconectar();
                                     }catch(Exception e){
                                    }

                                 %>
                                
                                <div class="row">
                                    <div class="col-md-4 iz">
                                    <form action="transacciones.jsp" method="POST">
                                    <input type="text" value="<%=monto%>"name="text-monto-cierre-caja" style="display: none;" />  
                                        <input type="submit" name="button-abrircaja" value="Abrir Caja" class="btn btn-primary"/>
                                     </form>   
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  