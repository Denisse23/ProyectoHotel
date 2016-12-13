<%-- 
    Document   : factura
    Created on : 9/12/2016, 05:25:09 PM
    Author     : Denisse
--%>
<%@page import="mpq.EnviadorMailArchivo"%>
<%@page import="javax.activation.FileDataSource"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%
    if (session.getAttribute("Rol") == null || !session.getAttribute("Rol").equals("Administrador")) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
    }
%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.StringReader"%>
<%@page import="com.lowagie.text.html.simpleparser.HTMLWorker"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/factura.css"> 
        <title>Factura</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="factura">
            <%
                if (request.getParameter("button-enviar mail") != null) {
                    String mail="";
                    String namehotel="";
                    try {
                        Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                        db.conectar();
                        String sql = "select Email from Cliente join Reservacion on Cliente.IdCliente=Reservacion.IdCliente join FichaCliente on"
                                + " Reservacion.IdReservacion=FichaCliente.IdReservacion where FichaCliente.IdFichaCliente="+request.getParameter("text-idfichacliente");
                        db.prepare(sql);
                        db.query.execute();
                        ResultSet rs = db.query.getResultSet();
                        while(rs.next()){
                            mail = rs.getString(1);
                        }
                        String sql1 = "select Nombre from Informacion";
                        db.prepare(sql1);
                        db.query.execute();
                        ResultSet rs1 = db.query.getResultSet();
                        while(rs1.next()){
                            namehotel = rs1.getString(1);
                        }
                        db.desconectar();
                    }catch(Exception e){
                         out.print("<script>alert('" + e.toString() + "');</script>");
                    }
                        
                        ServletContext context = session.getServletContext();
                        String realContextPath = context.getRealPath(request.getContextPath());
                        String path = realContextPath.substring(0, realContextPath.length() - 17) + "\\facturas\\" + request.getParameter("text-idfichacliente") + ".pdf";
                        FileDataSource fds = new FileDataSource(path);
                        EnviadorMailArchivo enviadormail = new EnviadorMailArchivo(mail, "Factura "+namehotel, "Se adjunta la factura.", fds);
                         out.print("<script>alert('Se ha enviado la factura al email proporcionado por el cliente');</script>");
                        
                    }

                    ////////////////////////////////////////////////////
                    if (request.getParameter("button-generarfactura") != null) {
                        try {
                            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                            db.conectar();
                            String sql = "delete from FichaClienteServicio where IdFichaCliente=" + request.getParameter("text-idfichacliente");
                            db.prepare(sql);
                            int contador = db.query.executeUpdate();
                            if (contador == 1) {
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                Date date = new Date();
                                String sql1 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('delete','FichaClienteServicio'"
                                        + ",?,?,?)";
                                db.prepare(sql1);
                                db.query.setString(1, session.getAttribute("Usuario").toString());
                                db.query.setString(2, dateFormat.format(date));
                                db.query.setString(3, session.getAttribute("Rol").toString());
                                db.query.executeUpdate();
                            }
                            String sql1 = "update FichaCliente set FechaSalida='" + request.getParameter("text-fechasalida") + "'"
                                    + " where IdFichaCliente=" + request.getParameter("text-idfichacliente");
                            db.prepare(sql1);
                            int contador1 = db.query.executeUpdate();
                            if (contador1 == 1) {
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                Date date = new Date();
                                String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('update','FichaCliente'"
                                        + ",?,?,?)";
                                db.prepare(sql2);
                                db.query.setString(1, session.getAttribute("Usuario").toString());
                                db.query.setString(2, dateFormat.format(date));
                                db.query.setString(3, session.getAttribute("Rol").toString());
                                db.query.executeUpdate();
                            }
                            String sql2 = "update Reservacion set Estado='Checkout'"
                                    + " where IdReservacion=(select IdReservacion from FichaCliente where IdFichaCliente=" + request.getParameter("text-idfichacliente") + ")";
                            db.prepare(sql2);
                            int contador2 = db.query.executeUpdate();
                            if (contador2 == 1) {
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                Date date = new Date();
                                String sql3 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('update','Reservacion'"
                                        + ",?,?,?)";
                                db.prepare(sql3);
                                db.query.setString(1, session.getAttribute("Usuario").toString());
                                db.query.setString(2, dateFormat.format(date));
                                db.query.setString(3, session.getAttribute("Rol").toString());
                                db.query.executeUpdate();
                            }
                            String sql3 = "insert into PagoCliente (IdFichaCliente, Monto, IdCaja) values(?,?,?)";
                            db.prepare(sql3);
                            db.query.setString(1, request.getParameter("text-idfichacliente"));
                            db.query.setString(2, request.getParameter("text-totalpago"));
                            db.query.setString(3, session.getAttribute("idcaja").toString());
                            int contador3 = db.query.executeUpdate();
                            if (contador3 == 1) {
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                Date date = new Date();
                                String sql4 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','PagoCliente'"
                                        + ",?,?,?)";
                                db.prepare(sql4);
                                db.query.setString(1, session.getAttribute("Usuario").toString());
                                db.query.setString(2, dateFormat.format(date));
                                db.query.setString(3, session.getAttribute("Rol").toString());
                                db.query.executeUpdate();
                            }
                            db.commit();
                            db.desconectar();

                        } catch (Exception e) {
                            out.print("<script>alert('Error: El activo está siendo usado en una o más categorías');</script>");
                        }
            %>
            <%
                    try {
                        //crear y abrir documento tipo pdf
                        ServletContext context = session.getServletContext();
                        String realContextPath = context.getRealPath(request.getContextPath());
                        String path = realContextPath.substring(0, realContextPath.length() - 17) + "\\facturas\\" + request.getParameter("text-idfichacliente") + ".pdf";
                        File file = new File(path);
                        FileOutputStream oFile = new FileOutputStream(file, false);
                        Document documentoPDF = new Document();
                        PdfWriter.getInstance(documentoPDF, oFile);
                        documentoPDF.open();

                        //algunos parametros
                        documentoPDF.addAuthor(session.getAttribute("Usuario").toString());
                        documentoPDF.addCreator(session.getAttribute("Usuario").toString());
                        documentoPDF.addSubject("Factura");
                        documentoPDF.addCreationDate();
                        documentoPDF.addTitle("Factura");

                        //insertar html
                        HTMLWorker htmlWorker = new HTMLWorker(documentoPDF);
                        String str = request.getParameter("text-enviardoc");

                        htmlWorker.parse(new StringReader(str));

                        // cerrar el documento
                        documentoPDF.close();

                    } catch (DocumentException de) {
                        out.print("<script>alert('" + de.toString() + "');</script>");
                        throw new IOException(de.getMessage());
                    }
                } %>

            <% out.print("<object data='" + application.getContextPath() + '/' + "facturas" + "/"
                + request.getParameter("text-idfichacliente") + ".pdf" + "' width='700' height='500'></object>");%>
            <br><br>
            <form  method="POST" action="factura.jsp">
                <input type="text" value="<%= request.getParameter("text-idfichacliente")%>" name="text-idfichacliente" style="display: none;" />  
                <input type="submit" name="button-enviar mail" value="Enviar email" class="btn btn-primary"/>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>