<%-- 
    Document   : administrarinformacion
    Created on : 29/11/2016, 12:22:35 PM
    Author     : Denisse
--%>
<%
    if (session.getAttribute("Rol") == null || !session.getAttribute("Rol").equals("Administrador")) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
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
        <link rel="stylesheet" type="text/css" href="<%= application.getContextPath() + "/css/adinformacion.css"%>">
        <script type="text/javascript" src="<%= application.getContextPath() + "/js/adinformacion.js"%>"></script>
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
                                    <form method="POST" id="form-nuevo-activo" action="<%= application.getContextPath() + "/backjsp/agregaractivo.jsp"%>">
                                        <div class="form-group">
                                            <label >Nombre:</label>
                                            <input id="text-nombre-nuevo-activo" name="text-nombre-nuevo-activo" type="text" class="form-control" ><span id="span-nombre-nuevo-activo"></span>
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
                                    <form method="POST" id="form-modificar-activo" action="<%= application.getContextPath() + "/backjsp/modificaractivo.jsp"%>">
                                        <div class="form-group">
                                            <label >Id Activo:</label>
                                            <input id="text-id-modificar-activo" name="text-id-modificar-activo" type="text" class="form-control" readonly>
                                            <label >Nombre:</label>
                                            <input id="text-nombre-modificar-activo" name="text-nombre-modificar-activo" type="text" class="form-control" ><span id="span-nombre-modificar-activo"></span>
                                            <label >Cantidad Disponible:</label>
                                            <input id="num-cantidad-modificar-activo" name="num-cantidad-modificar-activo" type="number" min="0" class="form-control"/><span id="span-cantidad-modificar-activo"></span>
                                            <label >Cantidad En Uso:</label>
                                            <input id="text-cantidaduso-modificar-activo" name="text-cantidaduso-modificar-activo" type="text" class="form-control" readonly>
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
                                            <th>Id Activo</th>
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
                                                String sql = "select IdActivo, Nombre, CantidadDisponibles, CantidadEnUso "
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
                                            <td><button type="button" class="btn btn-primary btn-circle" onclick="modificarActivo(<%= rs.getString(1)%>, '<%= rs.getString(2)%>',<%= rs.getString(3)%>,<%= rs.getString(4)%>)" >M</button></td>
                                            <% if (rs.getInt(4) == 0) {%>
                                    <form method="POST" action="<%= application.getContextPath() + "/backjsp/eliminaractivo.jsp"%>">
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
                            <div class="panel-body">
                                <div id="div-nuevo-categoria">
                                    <p>Nueva Categoría</p>
                                    <form method="POST" id="form-nuevo-categoria" action="<%= application.getContextPath() + "/backjsp/agregarcategoria.jsp"%>">
                                        <div class="form-group">
                                            <label >Nombre:</label>
                                            <input id="text-nombre-nuevo-categoria" name="text-nombre-nuevo-categoria",type="text" class="form-control" ><span id="span-nombre-nuevo-categoria"></span>
                                            <label >Precio:</label>
                                            <input id="text-precio-nuevo-categoria" name="text-precio-nuevo-categoria" type="textber" min="1" class="form-control"/><span id="span-precio-nuevo-categoria"></span>
                                            <br>
                                            <input id="button-agregar-categoria"  type="button" class="btn btn-primary" value="Agregar" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                                <div id="div-modificar-categoria">
                                    <p>Modificar Categoría</p>
                                    <form method="POST" id="form-modificar-categoria" action="<%= application.getContextPath() + "/backjsp/modificarcategoria.jsp"%>">
                                        <div class="form-group">
                                            <label >Id Categoría:</label>
                                            <input id="text-id-modificar-categoria" name="text-id-modificar-categoria",type="text" class="form-control" readonly>
                                            <label >Nombre:</label>
                                            <input id="text-nombre-modificar-categoria" name="text-nombre-modificar-categoria",type="text" class="form-control" ><span id="span-nombre-modificar-categoria"></span>
                                            <label >Precio:</label>
                                            <input id="text-precio-modificar-categoria" name="text-precio-modificar-categoria" type="textber" min="0" class="form-control"/><span id="span-precio-modificar-categoria"></span>
                                            <br>
                                            <input id="button-modificar-categoria"  type="button" class="btn btn-primary" value="Modificar" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                                <button id="button-nuevo-categoria" name="button-nuevo-categoria" type="button" class="btn btn-success btn-circle">+</button>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Id Categoría</th>
                                            <th>Nombre</th>
                                            <th>Precio</th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql = "select IdCategoria, Nombre, Precio from Categoria";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {

                                        %>
                                        <tr > 
                                            <td><%=rs.getString(1)%></td> 
                                            <td><%=rs.getString(2)%></td> 
                                            <td><%=rs.getString(3)%></td>


                                            <td><button type="button" class="btn btn-primary btn-circle" onclick="modificarCategoria(<%= rs.getString(1)%>, '<%= rs.getString(2)%>',<%= rs.getString(3)%>)" >M</button></td>
                                            <td> <form method="POST" action="<%= application.getContextPath() + "/backjsp/eliminarcategoria.jsp"%>">
                                                    <input name="text-id-eliminar-categoria" type="text" value="<%=rs.getString(1)%>" style="display: none;">
                                                    <button type="submit" class="btn btn-danger btn-circle" >X</button>
                                                </form></td>
                                            <td><form method="POST" action="<%= application.getContextPath() + "/categoriaactivo.jsp"%>">
                                                    <input name="text-id-categoria-activo" type="text" value="<%=rs.getString(1)%>" style="display: none;">
                                                    <button type="submit" class="btn btn-primary"  >Condiciones</button>
                                                </form></td>
                                            <td><form method="POST" action="<%= application.getContextPath() + "/categoriaservicio.jsp"%>">
                                                    <input name="text-id-categoria-servicio" type="text" value="<%=rs.getString(1)%>" style="display: none;">
                                                    <button type="submit" class="btn btn-primary"  >Servicios</button>
                                                </form></td>
                                            <td>  <form method="POST" action="<%= application.getContextPath() + "/imagenescategoria.jsp"%>">
                                                    <input name="text-nombre-categoria-imagen" type="text" value="<%=rs.getString(2)%>" style="display: none;">
                                                    <input type="submit" value="Imágenes" class="btn btn-primary"/>
                                                </form></td>



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
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">Habitaciones</a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div id="div-nuevo-habitacion">
                                    <p>Nueva Habitacion</p>
                                    <form method="POST" id="form-nuevo-habitacion" action="<%= application.getContextPath() + "/backjsp/agregarhabitacion.jsp"%>">
                                        <div class="form-group">
                                            <label >Id Habitación:</label>
                                            <input id="text-id-nuevo-habitacion" name="text-id-nuevo-habitacion" type="text" class="form-control" ><span id="span-id-nuevo-habitacion"></span>
                                            <label >Categoría:</label>
                                            <select name="select-id-agregar-categoria" class="selectpicker form-control">
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
                                                <option value="<%= rs.getString(1)%>"><%= rs.getString(2)%></option>
                                                <%
                                                        }
                                                        db.desconectar();
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    }
                                                %> 
                                            </select>
                                            <br>
                                            <input id="button-agregar-habitacion"  type="button" class="btn btn-primary" value="Agregar" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                                <button id="button-nuevo-habitacion" name="button-nuevo-habitacion" type="button" class="btn btn-success btn-circle">+</button>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Id Habitacion</th>
                                            <th>Nombre Categoría</th>
                                            <th>Precio</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql = "select IdHabitacion,IdCategoria, Nombre, Precio from Habitacion join Categoria on Habitacion.IdCategoria="
                                                        + "Categoria.IdCategoria where Habitacion.Habilitada=1";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {

                                        %>
                                        <tr > 
                                            <td><%=rs.getString(1)%></td>  
                                            <td><%=rs.getString(3)%></td> 
                                            <td><%=rs.getString(4)%></td>
                                            <td> <form method="POST" action="<%= application.getContextPath() + "/backjsp/eliminarhabitacion.jsp"%>">
                                                    <input name="text-id-eliminar-habitacion" type="text" value="<%=rs.getString(1)%>" style="display: none;">
                                                    <input name="text-categoria-eliminar-habitacion" type="text" value="<%=rs.getString(2)%>" style="display: none;">
                                                    <button type="submit" class="btn btn-danger btn-circle" >X</button>
                                                </form></td>

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
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">Servicios</a>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div id="div-nuevo-servicio">
                                    <p>Nuevo Servicio</p>
                                    <form method="POST" id="form-nuevo-servicio" action="<%= application.getContextPath() + "/backjsp/agregarservicio.jsp"%>">
                                        <div class="form-group">
                                            <label >Nombre:</label>
                                            <input id="text-nombre-nuevo-servicio" name="text-nombre-nuevo-servicio",type="text" class="form-control" ><span id="span-nombre-nuevo-servicio"></span>
                                            <label >Precio:</label>
                                            <input id="text-precio-nuevo-servicio" name="text-precio-nuevo-servicio" type="textber" min="1" class="form-control"/><span id="span-precio-nuevo-servicio"></span>
                                            <br>
                                            <input id="button-agregar-servicio"  type="button" class="btn btn-primary" value="Agregar" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                                <div id="div-modificar-servicio">
                                    <p>Modificar Servicio</p>
                                    <form method="POST" id="form-modificar-servicio" action="<%= application.getContextPath() + "/backjsp/modificarservicio.jsp"%>">
                                        <div class="form-group">
                                            <label >Id Servicio:</label>
                                            <input id="text-id-modificar-servicio" name="text-id-modificar-servicio",type="text" class="form-control" readonly>
                                            <label >Nombre:</label>
                                            <input id="text-nombre-modificar-servicio" name="text-nombre-modificar-servicio",type="text" class="form-control" ><span id="span-nombre-modificar-servicio"></span>
                                            <label >Precio:</label>
                                            <input id="text-precio-modificar-servicio" name="text-precio-modificar-servicio" type="textber" min="0" class="form-control"/><span id="span-precio-modificar-servicio"></span>
                                            <br>
                                            <input id="button-modificar-servicio"  type="button" class="btn btn-primary" value="Modificar" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                                <button id="button-nuevo-servicio" name="button-nuevo-servicio" type="button" class="btn btn-success btn-circle">+</button>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Id Servicio</th>
                                            <th>Nombre</th>
                                            <th>Precio</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql = "select IdServicio, Nombre, Precio "
                                                        + "from Servicio";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {

                                        %>
                                        <tr > 
                                            <td><%=rs.getString(1)%></td> 
                                            <td><%=rs.getString(2)%></td> 
                                            <td><%=rs.getString(3)%></td>
                                            <td><button type="button" class="btn btn-primary btn-circle" onclick="modificarServicio(<%= rs.getString(1)%>, '<%= rs.getString(2)%>',<%= rs.getString(3)%>)" >M</button></td>
                                    <form method="POST" action="<%= application.getContextPath() + "/backjsp/eliminarservicio.jsp"%>">
                                        <input name="text-id-eliminar-servicio" type="text" value="<%=rs.getString(1)%>" style="display: none;">
                                        <td><button type="submit" class="btn btn-danger btn-circle" >X</button></td>
                                    </form>


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
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse5">Promociones y Descuentos</a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div id="div-nuevo-promocion">
                                    <p>Nuevo Promocion</p>
                                    <form method="POST" id="form-nuevo-promocion" action="<%= application.getContextPath() + "/backjsp/agregarpromocion.jsp"%>">
                                        <div class="form-group">
                                            <label >Categoría:</label>
                                            <select name="select-id-categoria-agregar-promocion" class="selectpicker form-control">
                                                <%
                                                    try {
                                                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                        db.conectar();
                                                        String sql = "select IdCategoria, Nombre from Categoria";
                                                        db.prepare(sql);
                                                        db.query.execute();
                                                        ResultSet rs = db.query.getResultSet();
                                                        while (rs.next()) {

                                                %>
                                                <option value="<%= rs.getString(1)%>"><%= rs.getString(2)%></option>
                                                <%
                                                        }
                                                        db.desconectar();
                                                    } catch (Exception e) {
                                                    }
                                                %>
                                            </select>
                                            <label >Tipo:</label>
                                            <select name="select-tipo-agregar-promocion" class="selectpicker form-control">
                                                <option value="0">Promocion</option>
                                                <option value="1">Descuento</option>
                                            </select>
                                            <label >Pocentaje:</label>
                                            <input id="text-porcentaje-agregar-promocion" name="text-porcentaje-agregar-promocion",type="text" class="form-control" placeholder="99.99"><span id="span-porcentaje-agregar-promocion"></span>
                                            <label >Fecha Inicio:</label>
                                            <input type="date" class="form-control" id="date-fecha-inicio-promocion" name="date-fecha-inicio-promocion"  ><span id="span-fecha-inicio-promocion"></span>
                                            <label >Fecha Fin:</label>
                                            <input type="date" class="form-control" id="date-fecha-fin-promocion" name="date-fecha-fin-promocion"  ><span id="span-fecha-fin-promocion"></span>
                                            <br>
                                            <input id="button-agregar-promocion"  type="button" class="btn btn-primary" value="Agregar" />
                                        </div>
                                    </form>
                                    <br>
                                </div>
                                <button id="button-nuevo-promocion" name="button-nuevo-promocion" type="button" class="btn btn-success btn-circle">+</button>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Categoria</th>
                                            <th>Tipo</th>
                                            <th>Porcentaje</th>
                                            <th>Fecha Inicio</th>
                                            <th>Fecha Fin</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql = "select Nombre,Tipo,Porcentaje,FechaInicio,FechaFin  "
                                                        + "from CategoriaDescuentoPromocion join Categoria on CategoriaDescuentoPromocion.IdCategoria=Categoria.IdCategoria";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {

                                        %>
                                        <tr > 
                                            <td><%=rs.getString(1)%></td> 
                                            <%if (rs.getInt(2) == 0) {%>
                                            <td>Promoción</td> 
                                            <%} else {%>
                                            <td>Descuento</td> 
                                            <%}%>
                                            <td><%=rs.getString(3)%></td>
                                            <td><%=rs.getString(4)%></td>
                                            <td><%=rs.getString(5)%></td>

                                        </tr>         

                                        <%
                                                }
                                                db.desconectar();
                                            } catch (Exception e) {

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
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse6">Información Hotel</a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div id="div-hotel-informacion">

                                    <br>
                                    <form method="POST" id="form-hotel-informacion" action="<%= application.getContextPath() + "/backjsp/modificarinformacionhotel.jsp"%>">
                                        <div class="form-group">
                                            <%
                                                try {
                                                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                    db.conectar();
                                                    String sql = "select Nombre, Mision, Vision, Telefono, Email, Pais, Ciudad, Ubicacion from Informacion";
                                                    db.prepare(sql);
                                                    db.query.execute();
                                                    ResultSet rs = db.query.getResultSet();
                                                    while (rs.next()) {
                                            %>
                                            <label >Nombre:</label>
                                            <input id="text-nombre-hotel-informacion" name="text-nombre-hotel-informacion",type="text" value="<%= rs.getString(1)%>" class="form-control" ><span id="span-nombre-hotel-informacion"></span>
                                            <label >Misión:</label>
                                            <textarea id="text-mision-hotel-informacion" name="text-mision-hotel-informacion" class="form-control" ><%= rs.getString(2)%></textarea><span id="span-mision-hotel-informacion"></span>
                                            <label >Visión:</label>
                                            <textarea id="text-vision-hotel-informacion" name="text-vision-hotel-informacion",type="text" class="form-control" ><%= rs.getString(3)%></textarea><span id="span-vision-hotel-informacion"></span>
                                            <label >Teléfono:</label>
                                            <input id="text-tel-hotel-informacion" name="text-tel-hotel-informacion",type="text" value="<%= rs.getString(4)%>" class="form-control" placeholder="(504) 99999999"  ><span id="span-tel-hotel-informacion"></span>
                                            <label >Email:</label>
                                            <input id="text-email-hotel-informacion" name="text-email-hotel-informacion",type="text" value="<%= rs.getString(5)%>" class="form-control" placeholder="hotel@gmail.com" ><span id="span-email-hotel-informacion"></span>
                                            <label >País:</label>
                                            <input id="text-pais-hotel-informacion" name="text-pais-hotel-informacion",type="text" value="<%= rs.getString(6)%>" class="form-control" ><span id="span-pais-hotel-informacion"></span>
                                            <label >Ciudad:</label>
                                            <input id="text-ciudad-hotel-informacion" name="text-ciudad-hotel-informacion",type="text" value="<%= rs.getString(7)%>" class="form-control" ><span id="span-ciudad-hotel-informacion"></span>
                                            <label >Ubicación:</label>
                                            <textarea id="text-ubicacion-hotel-informacion" name="text-ubicacion-hotel-informacion",type="text" class="form-control" ><%= rs.getString(8)%></textarea><span id="span-ubicacion-hotel-informacion"></span>
                                            <br>
                                            <input id="button-hotel-informacion"  type="button" class="btn btn-primary" value="Guardar Cambios" />
                                            <% }
                                                    db.desconectar();
                                                } catch (Exception e) {
                                                }
                                            %>
                                        </div>
                                    </form>
                                    <br>

                                </div>
                                <div id="div-hotel-informacion-imagenes">
                                    <form method="POST" action="<%= application.getContextPath() + "/imageneshotel.jsp"%>">
                                        <input type="submit" value="Gestionar Imágenes" class="btn btn-primary"/>
                                    </form>
                                </div>


                            </div>
                        </div>
                    </div>

                </div> 
            </div>
             <br>
            <center>
            <form method="POST" action="<%= application.getContextPath() + "/backjsp/exportar.jsp"%>">
                <input type="submit" name="button-exporta" value="Exportar Configuración XML" class="btn btn-primary exportar"/>
            </form>
            </center>

        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
