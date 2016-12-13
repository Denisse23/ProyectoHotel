<%-- 
    Document   : reportes
    Created on : 29/11/2016, 02:21:16 PM
    Author     : Denisse
--%>
<%@page import="graficos.GenerarGraficoPromociones"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="graficos.GenerarGraficoInventario"%>
<%@page import="graficos.GenerarGraficoFinanciero"%>
<%
    if (session.getAttribute("Rol") == null || session.getAttribute("Rol").equals("Cliente")) {
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
        <link rel="stylesheet" type="text/css" href="./css/reportes.css">
        <title>Administrar Información</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>


        <div class="reports">
            <div class="container">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Promociones</a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div style="width:50%; margin:0 auto">
                                <form id="form-reporte-promociones" action="reportes.jsp" method="POST">
                                     <label >Seleccione una categoría:</label>
                                        <select name="select-id-categoria" class="selectpicker form-control">
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                                                db.conectar();
                                                String sql ="select IdCategoria, Nombre from Categoria";
                                                db.prepare(sql);
                                                db.query.execute();
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {

                                        %>
                                            <option value="<%= rs.getString(1)%>"><%= rs.getString(2)%></option>
                                        <%
                                            }db.desconectar();
                                            }catch(Exception e){}
                                        %>
                                        </select>
                                        <br>
                                        <input type="submit" name="button-reporte-promociones" value="Visualizar" class="btn btn-primary"/>
                                    </form>
                                </div>
                                    <br>
                                    <br>
                                    <br>
                                    <center>
                                       <%
                                        if (request.getParameter("button-reporte-promociones") != null) {
                                            ServletContext context = session.getServletContext();
                                            String realContextPath = context.getRealPath(request.getContextPath());
                                            String path = realContextPath.substring(0, realContextPath.length() - 17) + "\\graficos\\reportepromociones.jpg";
                                            String pathdb =  realContextPath.substring(0, realContextPath.length() - 17) + "\\Hotel.mdb";
                                            GenerarGraficoPromociones GGP = new GenerarGraficoPromociones(path, request.getParameter("select-id-categoria"), pathdb);
                                            GGP.crear();
                                    %>
                                        <img src="./graficos/reportepromociones.jpg" class="img-rounded" alt="Cinque Terre" width="600" height="400">
                                    <%
                                        }
                                    %>
                                     
                                    </center>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">Reportes Financieros</a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div style="width:50%; margin:0 auto">
                                    <form id="form-reporte-financiero" action="reportes.jsp" method="POST">
                                        <label >Introduzca Inicio de periodo:</label>
                                        <input class="form-control" type="date"  name="date-inicio-periodo" value=""  >
                                        <label >Introduzca Fin de periodo:</label>
                                        <input class="form-control" type="date"  name="date-fin-periodo" value=""  >
                                        <br>
                                        <input type="submit" name="button-reporte-financiero" value="Visualizar" class="btn btn-primary"/>
                                    </form>
                                    <br>
                                    <br>
                                    <br>
                                    </div>
                                <center>
                                    <%
                                        if (request.getParameter("button-reporte-financiero") != null) {
                                            ServletContext context = session.getServletContext();
                                            String realContextPath = context.getRealPath(request.getContextPath());
                                            String path = realContextPath.substring(0, realContextPath.length() - 17) + "\\graficos\\reportefinanciero.jpg";
                                            String pathdb =  realContextPath.substring(0, realContextPath.length() - 17) + "\\Hotel.mdb";
                                            GenerarGraficoFinanciero GG = new GenerarGraficoFinanciero(path, request.getParameter("date-inicio-periodo")+" a "+request.getParameter("date-fin-periodo"), pathdb);
                                            GG.crear();
                                    %>
                                        <img src="./graficos/reportefinanciero.jpg" class="img-rounded" alt="Cinque Terre" width="600" height="400">
                                    <%
                                        }
                                    %>
                                    
                                </center>

                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">Inventario Activos</a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse in">
                            <div class="panel-body">
                                
                                <center >
                                    <%
                                            ServletContext context = session.getServletContext();
                                            String realContextPath = context.getRealPath(request.getContextPath());
                                            String path = realContextPath.substring(0, realContextPath.length() - 17) + "\\graficos\\reporteinventario.jpg";
                                            String pathdb =  realContextPath.substring(0, realContextPath.length() - 17) + "\\Hotel.mdb";
                                            GenerarGraficoInventario GGI = new GenerarGraficoInventario(path, pathdb);
                                            GGI.crear();
                                    %>
                                        <img src="./graficos/reporteinventario.jpg" class="img-rounded" alt="Cinque Terre" width="600" height="400">
                                    
                                </center>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
