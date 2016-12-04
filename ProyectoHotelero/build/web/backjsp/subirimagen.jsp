<%-- 
    Document   : subirimagen
    Created on : 3/12/2016, 10:49:49 PM
    Author     : Denisse
--%>
<%@page import="java.io.FileWriter"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../head.jsp"/>
    <body>
     <jsp:include page="../header.jsp"/>
<%
        String dir = "";
            //clase para subir archivos a disco
            ServletFileUpload fu = new ServletFileUpload(new DiskFileItemFactory()); //apache 7 

            List items = fu.parseRequest(new ServletRequestContext(request)); //apache 814 en adelante
            // Iteramos por cada elemento del Request
            Iterator i = items.iterator();

            String fileName = "";
            File fichero = null;
            long siize=0;
            while (i.hasNext()) {
                FileItem ff = (FileItem) i.next();
                //verificamos si el elemento es un archivo
                if (!ff.isFormField()) {
                    long a = ff.getSize();
                    siize = a;
                    //verificamos si el tamano del archivo es mayor a 0 bites
                    if (a > 0) {
                        fileName = ff.getName();
                        fichero = new File(fileName);
                        // escribimos el fichero en la carpeta que corresponde
                        fichero = new File(application.getRealPath("") + "\\images\\hotel\\", fichero.getName());
                        ff.write(fichero);
                      
                        String file = application.getRealPath("") + "\\images\\" + "imghotel.txt";
                FileWriter txt_file = new FileWriter(file, true);
                int centinela = 0;

                if (ff.getContentType().equals("image/jpeg")
                        || ff.getContentType().equals("image/png")
                        || ff.getContentType().equals("image/gif")
                        || ff.getContentType().equals("image/pjpeg")) {
                    txt_file.write("<img alt=\"imagen\" width=\"600px\" src=\""
                            + application.getContextPath()  + "/images/hotel/" 
                            + fichero.getName() + "\" style=\"border:white solid 5px;\"/>\n");
                    centinela = 1;
 
                txt_file.close();

            
                        

                    }
                } 
                
            }
            }
            if(siize>0){
            
out.print("<script>alert('La imagen se agregó correctamente');</script>");}
        out.write("<script>setTimeout(function(){window.location.href='"+application.getContextPath()+"/imageneshotel.jsp'},300);</script>");

        %>
 <jsp:include page="../footer.jsp"/>
    </body>
</html>
