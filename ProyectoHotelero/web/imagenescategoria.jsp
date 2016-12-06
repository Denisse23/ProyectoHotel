<%-- 
    Document   : imagenescategoria
    Created on : 4/12/2016, 05:41:21 PM
    Author     : Denisse
--%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileWriter"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%
    if (session.getAttribute("Rol") == null || !session.getAttribute("Rol").equals("Administrador")) {
        out.write("<script>window.location.href='" + application.getContextPath() + "/index.jsp';</script>");
    }
%>
<%
         String cate="";  
        if(request.getParameter("text-nombre-categoria-imagen")!=null){
                 cate = request.getParameter("text-nombre-categoria-imagen");
        }else if(request.getAttribute("text-nombre-categoria-imagen")!=null){
                
            cate = request.getAttribute("text-nombre-categoria-imagen").toString();
        }
        %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="<%= application.getContextPath() + "/css/imagenescategoria.css"%>">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="imagenes-categoria">
            <form name="form1" action="<%= application.getContextPath()+"/backjsp/subirimagencategoria.jsp"%>" method="POST" enctype="MULTIPART/FORM-DATA">
                <input name="text-nombre-categoria-imagen" type="text" value="<%=cate%>" style="display: none;">
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
                File file = new File(realContextPath.substring(0, realContextPath.length() - 17) + "/images/"+cate+".txt");
                FileInputStream fis = new FileInputStream(file);

                BufferedReader br = new BufferedReader(new InputStreamReader(fis));

                String line = null;
                while ((line = br.readLine()) != null) {
            %>
            <form action="<%= application.getContextPath()+"/backjsp/eliminarimagencategoria.jsp"%>" method="POST">
                <input type="text" name="text-nombre-categoria-imagen" style="display: none;" value="<%=cate%>"  />
                <%= line%>
                <input type="text" name="linkimagen" style="display: none;" value='<%=line%>'  />
                <br>
                <input  type="submit" class="btn btn-danger" name="Eliminar" value="Eliminar" />
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


