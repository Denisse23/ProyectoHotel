<%-- 
    Document   : reservarAd
    Created on : 29/11/2016, 12:16:00 PM
    Author     : Denisse
--%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <script type="text/javascript" src="<%= application.getContextPath()+"/js/reservarAd.js"%>"></script
        <title>Reservar</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="reservar">
            <div class="requerimientos">
                        <form id="form-categoria-reservar" method="POST" action="reservarAd.jsp">
                                <label>Categoría:</label>
                                <select name="select-categoria-reservar" class="selectpicker form-control" onchange="changeCategoria()">
                                    <%
                                        
                                        try {
                                            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql = "select IdCategoria, Nombre from Categoria ";
                                            db.prepare(sql);
                                            db.query.execute();
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {

                                    %>
                                    <% if(request.getParameter("select-categoria-reservar")!=null){ 
                                        if(rs.getString(1).equals(request.getParameter("select-categoria-reservar"))){
                                    %>
                                        <option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option> 
                                     <%}else{%>
                                          <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
                                     <%}%>
                                        
                                        
                                    <%}else{ %>
                                        <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
                                    <% }%>
                                    <%   }
                                            db.desconectar();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    %> 
                                </select>
                                <% 
                                    if(request.getParameter("date-fecha-llegada")!=null){ %>
                                        <input type="date"  name="date-fecha-llegada" value="<%=request.getParameter("date-fecha-llegada")%>" style="display: none;" >
                                    <%  } %>
                                        
                                 <%   if(request.getParameter("date-fecha-salida")!=null){ %>
                                 <input type="date" name="date-fecha-salida" value="<%=request.getParameter("date-fecha-salida")%>" style="display: none;" >
                                 <input name="text-activar-div-habitaciones" type="text" value="SI" style="display: none;">
                                <% }%>
                                 <textarea name="textarea-habitaciones-list-at" id="textarea-habitaciones-list-at" style="display: none;"></textarea>  
                                 
                            </form>
                                <br>
                                <% if (session.getAttribute("Rol") != null) { %>
                                <form id="form-relizar-busqueda" action="reservarAd.jsp" method="POST">
                                <label >Fecha de llegada:</label>
                                <% 
                                    if(request.getParameter("date-fecha-llegada")!=null){ %>
                                        <input type="date" class="form-control" id="date-fecha-llegada" name="date-fecha-llegada" value="<%=request.getParameter("date-fecha-llegada")%>" ><span id="span-fecha-llegada"></span> 
                                <% }else{%>
                                <input type="date" class="form-control" id="date-fecha-llegada" name="date-fecha-llegada"  ><span id="span-fecha-llegada"></span>
                                <% } %>
                                <label >Fecha de salida:</label>
                                <% 
                                    if(request.getParameter("date-fecha-salida")!=null){ %>
                                 <input type="date" class="form-control" id="date-fecha-salida" name="date-fecha-salida" value="<%=request.getParameter("date-fecha-salida")%>" ><span id="span-fecha-salida"></span> 
                                <% }else{%>
                                    <input type="date" class="form-control" id="date-fecha-salida" name="date-fecha-salida" ><span id="span-fecha-salida"></span>
                                <% } %>
                                
                                <input name="text-activar-div-habitaciones" type="text" value="SI" style="display: none;">
                                <%  String cateinputtext = "";
                                    if(request.getParameter("select-categoria-reservar")!=null){
                                        cateinputtext = request.getParameter("select-categoria-reservar");
                                    }else{
                                       try {

                                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql1 = "select IdCategoria from Categoria limit 1";
                                            db.prepare(sql1);
                                            db.query.execute();
                                            ResultSet rs1 = db.query.getResultSet();
                                            while (rs1.next()) {
                                                cateinputtext = rs1.getString(1);
                                            }
                                            db.desconectar();
                                    }catch(Exception e){} 
                                    }
                                %>   
                               
                                <input name="select-categoria-reservar" type="text" value="<%=cateinputtext%>" style="display: none;">
                                
                                <br>
                                <input type="button" id="button-realizar-busqueda" value="Realizar búsqueda" class="btn btn-primary"/>
                                <br>
                                <br>
                                </form>
                                <%if(request.getParameter("text-activar-div-habitaciones")!=null){ %>
                                <div id="div-escoger-habitaciones">
                                Presionar las habitaciones a reservar:
                                Dispoible: verde,
                                Ocupada: rojo,
                                Otra categoría: azul
                                <br>
                                <table border="0" class="diagrama">
                                    <tbody>
                                <%    try {

                                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql = "select IdHabitacion, IdCategoria from Habitacion where"
                                                    + " Habilitada=1";
                                            db.prepare(sql);
                                            db.query.execute();
                                            ResultSet rs = db.query.getResultSet();
                                            int contadorrows = 0;
                                            while (rs.next()) {
                                             
                                      %>
                                        <%if(contadorrows==0){%><tr><%}%>
                                        <%if(request.getParameter("select-categoria-reservar").equals(rs.getString(2))){
                                            String sql1 = "select FechaIngreso, FechaSalida, Estado from Reservacion where"
                                                    + " IdHabitacion="+rs.getString(1);
                                            db.prepare(sql1);
                                            db.query.execute();
                                            ResultSet rs1 = db.query.getResultSet();
                                            boolean habitaciondisponible = true;
                                            while(rs1.next()){
                                                if(rs1.getString(3).equals("Confirmada") || rs1.getString(3).equals("Checkin")){
                                                    
                                                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                                    Date fechallegadare = format.parse(request.getParameter("date-fecha-llegada").toString());
                                                    Date fechasalidare = format.parse(request.getParameter("date-fecha-salida").toString());
                                                    Date fechallegadarow = format.parse(rs1.getString(1));
                                                    Date fechasalidarow = format.parse(rs1.getString(2));
                                                    if((fechallegadare.compareTo(fechasalidarow)<0) && (fechasalidare.compareTo(fechallegadarow)>0)){
                                                        habitaciondisponible = false;
                                                        break;
                                                    }
                                                }
                                            }
                                                if(habitaciondisponible){
                                        %>
                                            <td><input type="button" value="<%=rs.getString(1)%>" class="btn btn-success" onclick="agregarHabitacion(<%=rs.getString(1)%>)"/></td>
                                        <% }else{%>
                                            <td><input type="button" value="<%=rs.getString(1)%>" class="btn btn-danger" disabled/></td>
                                        <% } %>
                                        <%}else{%>
                                            <td><input type="button" value="<%=rs.getString(1)%>" class="btn btn-info"   disabled/></td>
                                        <%}%>
                                        <%if(contadorrows==4){ contadorrows=0;%></tr><%}%>
                                      
                                       <%contadorrows++;} db.desconectar();}catch(Exception e){}%>
                                        
                                    </tbody>
                                </table>
                                <br>
                                <br>
                                <form method="POST" action="backjsp/crearreservacion.jsp" id="form-reserva-clientes-aceptar">
                                Habitaciones agregadas:
                                <br>
                                <ul class="list-group" id="list-habitaciones-agregadas" name="list-habitaciones-agregadas">
                                <% if(request.getParameter("textarea-habitaciones-list-at")!=null){   
                                    String[] habitaciones = request.getParameter("textarea-habitaciones-list-at").split(",");
                                    for(String h: habitaciones){%>
                                          <li class="list-group-item" value="<%=h%>"><%=h%></li>
                                 <% }}%>
                                </ul>
                                 <textarea name="textarea-habitaciones-list" id="textarea-habitaciones-list" style="display: none;"></textarea>    
                                 <input name="text-fecha-llegada-reserva" type="text" value="<%=request.getParameter("date-fecha-llegada")%>" style="display: none;">
                                 <input name="text-fecha-salida-reserva" type="text" value="<%=request.getParameter("date-fecha-salida")%>" style="display: none;">
                                 Cliente:
                                 <select name="select-id-cliente-reservarAd" class="selectpicker form-control" >
                                    <%
                                        
                                        try {
                                            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql = "select IdCliente, PrimerNombre,PrimerApellido from Cliente ";
                                            db.prepare(sql);
                                            db.query.execute();
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {

                                    %>
                                        <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)+" "+rs.getString(3)%></option>
                                    
                                    <%   }
                                            db.desconectar();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    %> 
                                </select>
                                <br>
                                <input type="button"id="button-reserva-clientes-aceptar" name="button-reserva-clientes-aceptar" value="Aceptar" class="btn btn-primary"/>
                                </form>
                                </div>
                        
                                <% }//fin if activar div habitaciones
                                    } else {%>
                                <form action="login.jsp" method="POST">
                                    <input type="submit" value="Iniciar Sesión" class="btn btn-primary"/>
                                </form>
                                <% }%>
                            
                    </div>
                    <div class="caracteristicas-fotos">
                            <div class="panel panel-default">
                                <label>Características:</label>
                                <ul class="list">
                                <% String Cate="";
                                   int idCate=0;
                                   String precio ="";
                                    try {

                                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql1 = "select IdCategoria, Nombre,Precio from Categoria limit 1";
                                            db.prepare(sql1);
                                            db.query.execute();
                                            ResultSet rs1 = db.query.getResultSet();
                                            while (rs1.next()) {
                                                Cate = rs1.getString(2);
                                                idCate = rs1.getInt(1);
                                                precio = rs1.getString(3);
                                            }
                                            db.desconectar();
                                    }catch(Exception e){}
                                    if(request.getParameter("select-categoria-reservar")!=null){ 
                                    try {
                                            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql1 = "select Nombre, Precio from Categoria where IdCategoria="+request.getParameter("select-categoria-reservar");
                                            db.prepare(sql1);
                                            db.query.execute();
                                            ResultSet rs1 = db.query.getResultSet();
                                            while (rs1.next()) {
                                                Cate = rs1.getString(1);%>
                                                    <li>Precio habitación: <%=rs1.getString(2) %></li>
                                               <%
                                            }
                                            String sql = "select Nombre, Cantidad from  CategoriaCondiciones join"
                                                    + " Activos on CategoriaCondiciones.idActivo=Activos.IdActivo"
                                                    + " where CategoriaCondiciones.IdCategoria=?";
                                            db.prepare(sql);
                                            db.query.setString(1, request.getParameter("select-categoria-reservar"));
                                            db.query.execute();
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {
                                %>
                                     <li><%=rs.getString(2)+" "+rs.getString(1) %></li>
                                <% }
                                    db.desconectar();
                                    }catch(Exception e){

                                   }
                                    }else{%>
                                        <li>Precio habitación: <%=precio %></li>
                                    <%
                                        try {

                                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                            db.conectar();
                                            String sql = "select Nombre, Cantidad from  CategoriaCondiciones join"
                                                    + " Activos on CategoriaCondiciones.idActivo=Activos.IdActivo"
                                                    + " where CategoriaCondiciones.IdCategoria="+idCate;
                                            db.prepare(sql);
                                            db.query.execute();
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {
                                      %>
                                          <li><%=rs.getString(2)+" "+rs.getString(1) %></li>
                                <%}db.desconectar();}catch(Exception e){}}%>
                                </ul>
                            </div>
                <div class="panel panel-default">
                 <label>Promociones y descuentos en las reservaciones de hoy:</label>
                 <ul class="list">
                 <%
                    String idCategoriaPromocion="";
                    if(request.getParameter("select-categoria-reservar")!=null){ 
                        idCategoriaPromocion=request.getParameter("select-categoria-reservar");
                    }else{
                        idCategoriaPromocion=idCate+"";
                    }
                    try{
                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                    db.conectar();
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
                    Date todaypromocion = new Date();
                    String sql = "select Tipo,Porcentaje from CategoriaDescuentoPromocion"
                            + " where IdCategoria="+idCategoriaPromocion+" and FechaInicio<='"
                            + format.format(todaypromocion)+"' and FechaFin>='"+format.format(todaypromocion)+"'";
                    db.prepare(sql);
                    db.query.execute();
                    ResultSet rs = db.query.getResultSet();
                    String tipop="Promoción";
                    while (rs.next()) {
                        if(rs.getInt(1)==1)
                            tipop="Descuento";
                    %>
                        <li><%="Tipo:"+tipop+", "+rs.getString(2)+"% menos en el precio de la habitación" %></li>
                    <%}
                    db.desconectar();
                    }catch(Exception e){
                        out.print("<script>alert('"+e.toString()+"');</script>");
                    }
                   
                 %>
                 </ul>
                 </div>
                 <div id="myCarousel" class="carousel slide" data-ride="carousel">
                 <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    
            <%
                ServletContext context = session.getServletContext();
                String realContextPath = context.getRealPath(request.getContextPath());
                File file = new File(realContextPath.substring(0, realContextPath.length() - 17) + "/images/"+Cate+".txt");
                FileInputStream fis = new FileInputStream(file);

                BufferedReader br = new BufferedReader(new InputStreamReader(fis));

                String line = null;
                int cont=0;
                while ((line = br.readLine()) != null) {
                    if(cont==0){
                        
                    
            %>
                <div class="item active">
                        <%= line%>
                </div>
            <%          }else{%>
                <div class="item">
                        <%= line%>
                    </div>
                
                <% }cont++;} %>
            </div>
            </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>

</html>
