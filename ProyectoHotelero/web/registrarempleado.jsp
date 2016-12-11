<%-- 
    Document   : registrarempleado
    Created on : 29/11/2016, 11:59:11 AM
    Author     : Denisse
--%>
<%@page import="mpq.EnviadorMail"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="generadores.PassGen"%>
<%@page import="generadores.RandomString"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%
    if (session.getAttribute("Rol") == null || !session.getAttribute("Rol").equals("Administrador")) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/registraempleado.css">
        <script type="text/javascript" src="<%= application.getContextPath() + "/js/registrarempleado.js"%>"></script>
        <script type="text/javascript" src="<%= application.getContextPath()+"/js/md5.js"%>"></script>
        <title>Registro Empleados</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="registrarE">
            <% 
                if(request.getParameter("text-primernombre-empleado")!=null){
             
                try {
                    RandomString rs = new RandomString();
                    String user = rs.randomstring();
                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                    db.conectar();
                    String sql1 = "insert into Usuario (Usuario, Password,Rol) values(?,?,?)";
                    db.prepare(sql1);
                    db.query.setString(1, user);
                    db.query.setString(2,request.getParameter("text-password"));
                    db.query.setString(3, request.getParameter("select-rol-empleado"));
                    int contador1=db.query.executeUpdate();
                    if (contador1 == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Usuario'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                         EnviadorMail enviadormail = new EnviadorMail(request.getParameter("text-email-empleado"),"Registro Hotel LQ","Usted se ha registrado en Hotel LQ\n"+"Sus datos son:\n"+"Usuario:"+user+"\nPassword:"+request.getParameter("text-password-sincifrar")+"\nSi usted no ha realizado está acción, por favor ignorar el mensaje.");
                    }
                    String sql = "insert into Empleado (PrimerNombre,SegundoNombre,PrimerApellido,SegundoApellido,Email,"
                            + " IdUsuario) values"
                                 + "(?,?,?,?,?,(select Last(IdUsuario) from Usuario ))";
                    db.prepare(sql);
                    db.query.setString(1,request.getParameter("text-primernombre-empleado"));
                    db.query.setString(2,request.getParameter("text-segundonombre-empleado"));
                    db.query.setString(3,request.getParameter("text-primerapellido-empleado"));
                    db.query.setString(4,request.getParameter("text-segundoapellido-empleado"));
                    db.query.setString(5,request.getParameter("text-email-empleado"));
                    
                    int contador=db.query.executeUpdate();
                    if (contador == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Empleado'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, session.getAttribute("Usuario").toString());
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, session.getAttribute("Rol").toString());
                        db.query.executeUpdate();
                        db.commit();
                        out.print("<script>alert('Se ha enviado un correo al empleado con su nombre de usuario y contraseña');</script>");
                    }
                    db.commit();
                    db.desconectar();

                } catch (Exception e) {
                    out.print("<script>alert('" + e.toString() + "');</script>");
                }
                }
                
            %>
            <form method="POST" action="registrarempleado.jsp" id="form-registrarempleado">
                <div class="form-group">
                    <label >Primer Nombre:</label>

                    <input type="text" class="form-control" id="text-primernombre-empleado" name="text-primernombre-empleado" ><span id="span-primernombre-empleado"></span>
                    <label >Segundo Nombre:</label>
                    <input type="text" class="form-control" id="text-segundonombre-empleado" name="text-segundonombre-empleado" ><span id="span-segundonombre-empleado"></span>
                    <label >Primer Apellido:</label>
                    <input type="text" class="form-control" id="text-primerapellido-empleado" name="text-primerapellido-empleado" ><span id="span-primerapellido-empleado"></span>
                    <label >Segundo Apellido:</label>
                    <input type="text" class="form-control" id="text-segundoapellido-empleado" name="text-segundoapellido-empleado" ><span id="span-segundoapellido-empleado"></span>
                    <label >Correo Electrónico:</label>
                    <input type="email" class="form-control" id="text-email-empleado" name="text-email-empleado" ><span id="span-email-empleado"></span>
                    <label >Rol:</label>
                    <select name="select-rol-empleado" class="selectpicker form-control">
                        <option value="Administrador">Administrador</option> 
                        <option value="Gerente">Gerente</option> 
                    </select>
                    <%PassGen pg = new PassGen();
                                String pass=pg.generatePassword();
                            %>
                             <input type="text" id="text-password" name="text-password" value="<%=pass%>" style="display: none;" />
                             <input type="text" id="text-password-sincifrar" name="text-password-sincifrar" value="<%=pass%>" style="display: none;" />
                    <br>
                    <input type="button" class="btn btn-primary" value="Registrar" id="button-registrarseempledo" id="button-registrarseempledo"/>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>

    </body>
</html>
