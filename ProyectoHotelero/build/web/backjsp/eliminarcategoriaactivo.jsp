<%-- 
    Document   : eliminarcategoriaactivo
    Created on : 4/12/2016, 04:08:37 PM
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
            String sql = "delete from CategoriaCondiciones where IdCategoria=? and IdActivo=?";
            db.prepare(sql);
            db.query.setString(1, request.getParameter("text-id-categoria-activo"));
            db.query.setString(2, request.getParameter("text-id-eliminar-activo"));
            int contador = db.query.executeUpdate();
            if (contador == 1) {
                String sql2 = "select IdHabitacion from Habitacion where IdCategoria=? and Habilitada=1";
                db.prepare(sql2);
                db.query.setString(1,request.getParameter("text-id-categoria-activo") );
                db.query.execute();
                ResultSet rs = db.query.getResultSet();
                int cantidadfinal = 0;
                while(rs.next()){
                    cantidadfinal+= Integer.parseInt(request.getParameter("text-cantidad-eliminar-activo").toString());
                }
                String sql5 ="select CantidadDisponibles from Activos where IdActivo=?";
                db.prepare(sql5);
                db.query.setString(1, request.getParameter("text-id-eliminar-activo"));
                db.query.execute();
                ResultSet rs1 = db.query.getResultSet();
                while(rs1.next()){
                    cantidadfinal+=rs1.getInt(1);
                }
                String sql3 = "update Activos set CantidadDisponibles=? where IdActivo=?";
                db.prepare(sql3);
                db.query.setInt(1, cantidadfinal);
                db.query.setString(2,request.getParameter("text-id-eliminar-activo") );
                db.query.executeUpdate();
                
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('delete','CategoriaCondiciones'"
                                       + ",?,?,?)";
                        db.prepare(sql1);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
               String sql4 =  "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('update','Activos'"
                                + ",?,?,?)";
               db.prepare(sql4);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                        
            }
            db.commit();
            db.desconectar();

        } catch (Exception e) {
            out.print("<script>alert('"+e.toString()+"');</script>");
        }
        request.getRequestDispatcher("../categoriaactivo.jsp").forward( request, response );
%>

