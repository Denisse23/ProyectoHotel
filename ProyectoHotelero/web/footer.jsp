<%-- 
    Document   : footer
    Created on : 28/11/2016, 04:13:41 PM
    Author     : Denisse
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<footer>
    <%
        try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "select Nombre from Informacion";
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
    %>
    <p>Copyright © 2016 <%= rs.getString(1) %>. All Rights Reserved </p>
    <% }
        db.desconectar();
        } catch (Exception e) {
        }
    %>
</footer>