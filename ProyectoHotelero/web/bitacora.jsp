<%-- 
    Document   : bitcora
    Created on : 29/11/2016, 03:08:43 PM
    Author     : Denisse
--%>
<%
   if(session.getAttribute("Rol")==null || !session.getAttribute("Rol").equals("Gerente")){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/bitacora.css">   
        <title>Transacciones</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="tabla">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Acción</th>
                        <th>Tabla</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Rol</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                            db.conectar();
                            String sql = "select ID, Tabla, Fecha, Usuario, Rol "
                                    + "from Bitacora";
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
                        <td><%=rs.getString(5)%></td >
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
