<%-- 
    Document   : imageneshotel
    Created on : 3/12/2016, 08:45:07 PM
    Author     : Denisse
--%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
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
        <link rel="stylesheet" type="text/css" href="<%= application.getContextPath() + "/css/imageneshotel.css"%>">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="imagenes-hotel">
            <form name="form1" action="backjsp/subirimagen.jsp" method="POST" enctype="MULTIPART/FORM-DATA">

                Archivo <input type="file" name="archivo" value="" />
                <br>
                <br>
                <%//insertamos un boton para hacer submit%>
                <input type="submit" value="Subir Imagen" name="Agregar" class="btn btn-primary" class="form-control"/>

            </form>
            <br>
            <%
                ServletContext context = session.getServletContext();
                String realContextPath = context.getRealPath(request.getContextPath());
                File file = new File(realContextPath.substring(0, realContextPath.length() - 17) + "/images/imghotel.txt");
                FileInputStream fis = new FileInputStream(file);

                BufferedReader br = new BufferedReader(new InputStreamReader(fis));

                String line = null;
                while ((line = br.readLine()) != null) {
            %>
            <form action="backjsp/eliminarimagen.jsp" method="POST">

                <%= line%>
                <input type="text" name="linkimagen" style="display: none;" value='<%=line%>'  />
                <br>
                <input  type="submit" class="btn btn-danger" name="Eliminar"value="Eliminar" />
                <br>
            </form>

            <%
                }

                br.close();
            %>

        </div>
        <br>
        <jsp:include page="footer.jsp"/>
    </body>
</html>


