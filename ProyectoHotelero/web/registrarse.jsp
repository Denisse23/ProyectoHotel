<%-- 
    Document   : registrarse
    Created on : 28/11/2016, 06:32:40 PM
    Author     : Denisse
--%>
<%@page import="mpq.EnviadorMail"%>
<%@page import="generadores.PassGen"%>
<%@page import="generadores.RandomString"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%
   if(session.getAttribute("Rol")!=null ){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
     "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/registrarse.css"> 
        <script type="text/javascript" src="<%= application.getContextPath()+"/js/registrarse.js"%>"></script>
        <script type="text/javascript" src="<%= application.getContextPath()+"/js/md5.js"%>"></script>
        <title>Registrase</title>
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <div class="registro">
            <% 
                if(request.getParameter("text-identidad-cliente")!=null){
                    int cont = 0;
            try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String sql=("select Identidad from Cliente where Identidad=?");
                db.prepare(sql);
                db.query.setString(1, request.getParameter("text-identidad-cliente"));
                db.query.execute();
                ResultSet rs = db.query.getResultSet();

                while (rs.next()) {
                    cont++;
                }
                db.desconectar();

            } catch (Exception e) {
            }
            if (cont == 0) {
                try {
                    RandomString rs = new RandomString();
                    String user = rs.randomstring();
                    Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                    db.conectar();
                    String sql1 = "insert into Usuario (Usuario, Password,Rol) values(?,?,?)";
                    db.prepare(sql1);
                    db.query.setString(1, user);
                    db.query.setString(2,request.getParameter("text-password"));
                    db.query.setString(3, "Cliente");
                    int contador1=db.query.executeUpdate();
                    if (contador1 == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Usuario'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, "UsuarioNoRegistrado");
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, "NoRol");
                        db.query.executeUpdate();
                        EnviadorMail enviadormail = new EnviadorMail(request.getParameter("text-email-cliente"),"Registro Hotel LQ","Usted se ha registrado en Hotel LQ\n"+"Sus datos son:\n"+"Usuario:"+user+"\nPassword:"+request.getParameter("text-password-sincifrar")+"\nSi usted no ha realizado está acción, por favor ignorar el mensaje.");
                    }
                    String sql = "insert into Cliente (Identidad, PrimerNombre,SegundoNombre,PrimerApellido,SegundoApellido,FechaNacimiento,Pais,Ciudad,Email,Telefono,"
                            + " IdUsuario) values"
                                 + "(?,?,?,?,?,?,?,?,?,?,(select Last(IdUsuario) from Usuario ))";
                    db.prepare(sql);
                    db.query.setString(1, request.getParameter("text-identidad-cliente"));
                    db.query.setString(2,request.getParameter("text-primernombre-cliente"));
                    db.query.setString(3,request.getParameter("text-segundonombre-cliente"));
                    db.query.setString(4,request.getParameter("text-primerapellido-cliente"));
                    db.query.setString(5,request.getParameter("text-segundoapellido-cliente"));
                    db.query.setString(6,request.getParameter("text-nacimiento-cliente").toString() + " 00:00:00");
                    db.query.setString(7,request.getParameter("text-pais-cliente"));
                    db.query.setString(8,request.getParameter("text-ciudad-cliente"));
                    db.query.setString(9,request.getParameter("text-email-cliente"));
                    db.query.setString(10,request.getParameter("text-telefono-cliente"));
                    int contador=db.query.executeUpdate();
                    if (contador == 1) {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        String sql2 = "insert into Bitacora (Accion, Tabla, Usuario, Fecha, Rol) values('insert','Cliente'"
                                       + ",?,?,?)";
                        db.prepare(sql2);
                        db.query.setString(1, "UsuarioNoRegistrado");
                        db.query.setString(2, dateFormat.format(date));
                        db.query.setString(3, "NoRol");
                        db.query.executeUpdate();
                        db.commit();
                        out.print("<script>alert('Se le ha enviado un correo con su nombre de usuario y contraseña');</script>");
                    }
                    db.commit();
                    db.desconectar();

                } catch (Exception e) {
                    out.print("<script>alert('" + e.toString() + "');</script>");
                }
            } else {
                out.print("<script>alert('El número de identidad ya existe en nuestra base de datos');</script>");
            }
                }
                
            %>
            <form method="POST" id="form-registrarse" >
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <label >Identidad:</label>
                            <input type="text" class="form-control" id="text-identidad-cliente" name="text-identidad-cliente" ><span id="span-identidad-cliente"></span>
                            <label >Primer Nombre:</label>
                            <input type="text" class="form-control" id="text-primernombre-cliente" name="text-primernombre-cliente" ><span id="span-primernombre-cliente"></span>
                            <label >Segundo Nombre:</label>
                            <input type="text" class="form-control" id="text-segundonombre-cliente" name="text-segundonombre-cliente" ><span id="span-segundonombre-cliente"></span>
                            <label >Primer Apellido:</label>
                            <input type="text" class="form-control"  id="text-primerapellido-cliente" name="text-primerapellido-cliente" ><span id="span-primerapellido-cliente"></span>
                            <label >Segundo Apellido:</label>
                            <input type="text" class="form-control" id="text-segundoapellido-cliente" name="text-segundoapellido-cliente" ><span id="span-segundoapellido-cliente"></span>

                        </div>
                        <div class="col-md-4">
                            <label >Fecha Nacimiento:</label>
                            <input type="date" class="form-control" id="text-nacimiento-cliente" name="text-nacimiento-cliente" ><span id="span-nacimiento-cliente"></span>
                            <label >País:</label>
                            <input type="text" class="form-control" id="text-pais-cliente" name="text-pais-cliente" ><span id="span-pais-cliente"></span>
                            <label >Ciudad:</label>
                            <input type="text" class="form-control" id="text-ciudad-cliente" name="text-ciudad-cliente" ><span id="span-ciudad-cliente"></span>
                            <label >Correo Electrónico:</label>
                            <input type="email" class="form-control" id="text-email-cliente" name="text-email-cliente" ><span id="span-email-cliente"></span>
                            <label >Teléfono:</label>
                            <input type="text" class="form-control" id="text-telefono-cliente" name="text-telefono-cliente" ><span id="span-telefono-cliente"></span>
                            <%PassGen pg = new PassGen();
                                String pass=pg.generatePassword();
                            %>
                             <input type="text" id="text-password" name="text-password" value="<%=pass%>" style="display: none;" />
                             <input type="text" id="text-password-sincifrar" name="text-password-sincifrar" value="<%=pass%>" style="display: none;" />
                        </div>
                    </div>
                    <br>
                    <div class="row">

                        <input type="button" id="button-registrarse"name="button-registrarse"class="btn btn-primary" value="Registrarse" />
                    </div>
                </div>
        </div>
    </form>

</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
