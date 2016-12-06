<%-- 
    Document   : eliminarcategoriaservicio
    Created on : 4/12/2016, 02:37:06 PM
    Author     : Denisse
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%
   
        try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "delete from CategoriaServicio where IdCategoria=? and IdServicio=?";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-id-categoria-servicio"));
            db.query.setString(2, request.getParameter("text-id-eliminar-servicio"));
            int contador = db.query.executeUpdate();
            if (contador == 1) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('delete','CategoriaServicio'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                        
            }
            db.commit();
            db.desconectar();

        } catch (Exception e) {
        }
        request.getRequestDispatcher("../categoriaservicio.jsp").forward( request, response );
%>
