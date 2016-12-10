<%-- 
    Document   : crearreservacion
    Created on : 5/12/2016, 05:53:40 PM
    Author     : Denisse
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%
    
    if(request.getParameter("select-id-cliente-reservarAd")!=null){
        try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String idCliente=request.getParameter("select-id-cliente-reservarAd");
                
                String[] habitaciones = request.getParameter("textarea-habitaciones-list").split(",");
                for(String h: habitaciones){
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date today = new Date();
                    String sql1="insert into Reservacion (IdCliente, IdHabitacion, FechaReservacion, FechaIngreso,"
                            + " FechaSalida, Estado) values (?,?,?,?,?,?)";
                    db.prepare(sql1);
                    db.query.setString(1, idCliente);
                    db.query.setString(2, h);
                    db.query.setString(3, dateFormat.format(today));
                    db.query.setString(4, request.getParameter("text-fecha-llegada-reserva").toString()+" 00:00:00");
                    db.query.setString(5, request.getParameter("text-fecha-salida-reserva").toString()+" 00:00:00");
                    db.query.setString(6, "Espera");
                    int contador= db.query.executeUpdate();
                    if (contador == 1) {
                        
                        DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Reservacion'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat1.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        int cont =db.query.executeUpdate();
                       
                    }
                }
                db.commit();
                db.desconectar();

            } catch (Exception e) {
                out.print("<script>alert('" + e.toString() + "');</script>");
            }
         //out.write("<script>setTimeout(function(){window.location.href='" + application.getContextPath() + "/reservacionesHechas.jsp'},300);</script>");
             out.write("<script>window.location.href='" + application.getContextPath() + "/reservaciones.jsp';</script>");
        
    }else{
         try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String sql="select IdCliente from Cliente where IdUsuario="+session.getAttribute("Id-Usuario").toString();
                db.prepare(sql);
                db.query.execute();
                ResultSet rs = db.query.getResultSet();
                String idCliente="";
                while (rs.next()) {
                    
                    idCliente = rs.getString(1);
                }
                
                String[] habitaciones = request.getParameter("textarea-habitaciones-list").split(",");
                for(String h: habitaciones){
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date today = new Date();
                    String sql1="insert into Reservacion (IdCliente, IdHabitacion, FechaReservacion, FechaIngreso,"
                            + " FechaSalida, Estado) values (?,?,?,?,?,?)";
                    db.prepare(sql1);
                    db.query.setString(1, idCliente);
                    db.query.setString(2, h);
                    db.query.setString(3, dateFormat.format(today));
                    db.query.setString(4, request.getParameter("text-fecha-llegada-reserva").toString()+" 00:00:00");
                    db.query.setString(5, request.getParameter("text-fecha-salida-reserva").toString()+" 00:00:00");
                    db.query.setString(6, "Espera");
                    int contador= db.query.executeUpdate();
                    if (contador == 1) {
                        
                        DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Reservacion'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat1.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        int cont =db.query.executeUpdate();
                       
                    }
                }
                db.commit();
                db.desconectar();

            } catch (Exception e) {
                out.print("<script>alert('" + e.toString() + "');</script>");
            }
         //out.write("<script>setTimeout(function(){window.location.href='" + application.getContextPath() + "/reservacionesHechas.jsp'},300);</script>");
             out.write("<script>window.location.href='" + application.getContextPath() + "/reservacionesHechas.jsp';</script>");
            
    }
%>