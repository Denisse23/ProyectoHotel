<%-- 
    Document   : administrarinformacion
    Created on : 29/11/2016, 12:22:35 PM
    Author     : Denisse
--%>
<%
   if(session.getAttribute("Rol")==null || !session.getAttribute("Rol").equals("Administrador")){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%= application.getContextPath()+"/css/adinformacion.css"%>">
        <script type="text/javascript" src="<%= application.getContextPath()+"/js/adinformacion.js"%>"></script
        <title>Administrar Información</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
            
        <div class="adinfo">
            <div class="container">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Activos</a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse in">
                            <div class="panel-body">
                            <div id="div-nuevo-activo">
                                    <p>Nuevo Activo</p>
                                    <form method="POST" id="form-nuevo-activo" action="<%= application.getContextPath()+"/backjsp/agregaractivo.jsp"%>">
                                    <div class="form-group">
                                        <label >Nombre:</label>
                                        <input id="text-nombre-nuevo-activo" name="text-nombre-nuevo-activo",type="text" class="form-control" ><span id="span-nombre-nuevo-activo"></span>
                                        <label >Cantidad Disponible:</label>
                                        <input id="num-cantidad-nuevo-activo" name="num-cantidad-nuevo-activo" type="number" min="1" class="form-control"/><span id="span-cantidad-nuevo-activo"></span>
                                        <br>
                                        <input id="button-agregar-activo"  type="button" class="btn btn-primary" value="Agregar" />
                                    </div>
                                    </form>
                                    <br>
                                </div>
                                <div id="div-modificar-activo">
                                    <p>Modificar Activo</p>
                                    <form method="POST" id="form-modificar-activo" action="<%= application.getContextPath()+"/backjsp/modificaractivo.jsp"%>">
                                    <div class="form-group">
                                        <label >IdActivo:</label>
                                        <input id="text-id-modificar-activo" name="text-id-modificar-activo",type="text" class="form-control" readonly>
                                        <label >Nombre:</label>
                                        <input id="text-nombre-modificar-activo" name="text-nombre-modificar-activo",type="text" class="form-control" ><span id="span-nombre-modificar-activo"></span>
                                        <label >Cantidad Disponible:</label>
                                        <input id="num-cantidad-modificar-activo" name="num-cantidad-modificar-activo" type="number" min="0" class="form-control"/><span id="span-cantidad-modificar-activo"></span>
                                        <label >Cantidad En Uso:</label>
                                        <input id="text-cantidaduso-modificar-activo" name="text-cantidaduso-modificar-activo",type="text" class="form-control" readonly>
                                        <br>
                                        <input id="button-modificar-activo"  type="button" class="btn btn-primary" value="Modificar" />
                                    </div>
                                    </form>
                                    <br>
                                </div>
                                 <button id="button-nuevo-activo" name="button-nuevo-activo" type="button" class="btn btn-success btn-circle">+</button>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>IdActivo</th>
                                            <th>Nombre</th>
                                            <th>Cantidad disponible</th>
                                            <th>Cantidad en uso</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql ="select IdActivo, Nombre, CantidadDisponibles, CantidadEnUso "
                                                        + "from Activos";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {

                                        %>
                                        <tr > 
                                            <td><%=rs.getString(1)%></td> 
                                            <td><%=rs.getString(2)%></td> 
                                             <td><%=rs.getString(3)%></td>
                                            <td><%=rs.getString(4)%></td >
                                            <td><button type="button" class="btn btn-primary btn-circle" onclick="modificarActivo(<%= rs.getString(1) %>,'<%= rs.getString(2) %>',<%= rs.getString(3) %>,<%= rs.getString(4) %>)" >M</button></td>
                                            <% if(rs.getInt(4)==0){ %>
                                                <form method="POST" action="<%= application.getContextPath()+"/backjsp/eliminaractivo.jsp"%>">
                                                    <input name="text-id-eliminar-activo" type="text" value="<%=rs.getString(1)%>" style="display: none;">
                                                    <td><button type="submit" class="btn btn-danger btn-circle" >X</button></td>
                                                </form>
                                            <%}%>
                                            
                                        </tr>         
                                                
                                        <%
                                                }
                                                db.desconectar();
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %> 
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">Categorías</a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <div class="panel-body">.............</div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">Habitaciones</a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse">
                            <div class="panel-body">.............</div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">Servicios</a>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse">
                            <div class="panel-body">.............</div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse5">Promociones y Descuentos</a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse">
                            <div class="panel-body">

                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse6">Información Hotel</a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse">
                            <div class="panel-body">
                            <div id="div-hotel-informacion">
                                <form method="POST" id="form-hotel-informacion" action="<%= application.getContextPath()+"/backjsp/modificarinformacionhotel.jsp"%>">
                                    <div class="form-group">
                                     <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql ="select Nombre, Mision, Vision, Telefono, Email, Pais, Ciudad, Ubicacion from Informacion";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {
                                        %>
                                        <label >Nombre:</label>
                                        <input id="text-nombre-hotel-informacion" name="text-nombre-hotel-informacion",type="text" value="<%= rs.getString(1) %>" class="form-control" ><span id="span-nombre-hotel-informacion"></span>
                                        <label >Misión:</label>
                                        <textarea id="text-mision-hotel-informacion" name="text-mision-hotel-informacion" class="form-control" ><%= rs.getString(2) %></textarea><span id="span-mision-hotel-informacion"></span>
                                        <label >Visión:</label>
                                        <textarea id="text-vision-hotel-informacion" name="text-vision-hotel-informacion",type="text" class="form-control" ><%= rs.getString(3) %></textarea><span id="span-vision-hotel-informacion"></span>
                                        <label >Teléfono:</label>
                                        <input id="text-tel-hotel-informacion" name="text-tel-hotel-informacion",type="text" value="<%= rs.getString(4) %>" class="form-control" placeholder="(504) 99999999"  ><span id="span-tel-hotel-informacion"></span>
                                        <label >Email:</label>
                                        <input id="text-email-hotel-informacion" name="text-email-hotel-informacion",type="text" value="<%= rs.getString(5) %>" class="form-control" placeholder="hotel@gmail.com" ><span id="span-email-hotel-informacion"></span>
                                        <label >País:</label>
                                        <input id="text-pais-hotel-informacion" name="text-pais-hotel-informacion",type="text" value="<%= rs.getString(6) %>" class="form-control" ><span id="span-pais-hotel-informacion"></span>
                                        <label >Ciudad:</label>
                                        <input id="text-ciudad-hotel-informacion" name="text-ciudad-hotel-informacion",type="text" value="<%= rs.getString(7) %>" class="form-control" ><span id="span-ciudad-hotel-informacion"></span>
                                        <label >Ubicación:</label>
                                        <textarea id="text-ubicacion-hotel-informacion" name="text-ubicacion-hotel-informacion",type="text" class="form-control" ><%= rs.getString(3) %></textarea><span id="span-ubicacion-hotel-informacion"></span>
                                        <br>
                                        <input id="button-hotel-informacion"  type="button" class="btn btn-primary" value="Guardar Cambios" />
                                        <% }
                                            db.desconectar();
                                           }catch(Exception e){}
                                        %>
                                    </div>
                                 </form>
                                    <br>
                                </div>
                                <div id="div-hotel-informacion-imagenes">
                                    <form method="POST" action="<%= application.getContextPath()+"/imageneshotel.jsp"%>">
                                    <input type="submit" value="Gestionar Imágenes" class="btn btn-primary"/>
                                    </form>
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
  