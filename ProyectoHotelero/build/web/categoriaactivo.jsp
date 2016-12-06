<%-- 
    Document   : categoriacondiciones
    Created on : 4/12/2016, 03:51:46 PM
    Author     : Denisse
--%>
<%
    if (session.getAttribute("Rol") == null || !session.getAttribute("Rol").equals("Administrador")) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="<%= application.getContextPath()+"/css/categoriaactivo.css"%>">   
        <title>Transacciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="categoria-activo">

            <div id="div-agregar-activo">
                <p>Agregar Activo</p>
                <form method="POST" id="form-nuevo-categoria" action="<%= application.getContextPath() + "/backjsp/agregarcategoriaactivo.jsp"%>">
                    <select name="select-id-agregar-activo" class="selectpicker form-control">
                        <%
                        try {
                            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                            db.conectar();
                            String sql = "select IdActivo, Nombre from Activos ";
                            db.prepare(sql);
                            db.query.execute();
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {

                    %>
                    <option value="<%= rs.getString(1) %>"><%= rs.getString(2) %></option>
                        <%
                        }
                        db.desconectar();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %> 
                    </select>
                     <label >Cantidad:</label>
                      <input  name="num-cantidad-agregar-activo" type="number" min="1" class="form-control"/>
                     <input name="text-id-categoria-activo" type="text" value="<%=request.getParameter("text-id-categoria-activo")%>" style="display: none;">
                    <button name="button-agregar-activo" type="submit" class="btn btn-success btn-circle">+</button>

                </form>
                <br>
            </div>

            <h5>Activos Actuales</h5>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Id Servicio</th>
                        <th>Nombre</th>
                        <th>Cantidad</th>
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
                            String sql = "select IdActivo, Nombre, Cantidad from Activos join CategoriaCondiciones"
                                    + " on CategoriaCondiciones.IdActivo=Activos.IdActivo where CategoriaCondiciones.IdCategoria=?";
                            db.prepare(sql);
                            db.query.setString(1, request.getParameter("text-id-categoria-activo"));
                            db.query.execute();
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {

                    %>
                    <tr > 
                        <td><%=rs.getString(1)%></td> 
                        <td><%=rs.getString(2)%></td> 
                        <td><%=rs.getString(3)%></td>
                <form method="POST" action="<%= application.getContextPath() + "/backjsp/eliminarcategoriaactivo.jsp"%>">
                    <input name="text-id-categoria-activo" type="text" value="<%=request.getParameter("text-id-categoria-activo")%>" style="display: none;">
                    <input name="text-cantidad-eliminar-activo" type="text" value="<%=rs.getString(3)%>" style="display: none;">
                    <input name="text-id-eliminar-activo" type="text" value="<%=rs.getString(1)%>" style="display: none;">
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
        <jsp:include page="footer.jsp"/>
    </body>
</html>

