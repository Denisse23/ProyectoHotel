<%-- 
    Document   : eliminarimagencategoria
    Created on : 4/12/2016, 08:18:52 PM
    Author     : Denisse
--%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../head.jsp"/>
    <body>
     <jsp:include page="../header.jsp"/>
<%
        ServletContext context = session.getServletContext();
        String realContextPath = context.getRealPath(request.getContextPath());
        File file = new File(realContextPath.substring(0, realContextPath.length() - 17) + "/images/"+request.getParameter("text-nombre-categoria-imagen")+".txt");
        FileInputStream fis = new FileInputStream(file);

        BufferedReader br = new BufferedReader(new InputStreamReader(fis));

        String line = null;
        String content = "";
        while ((line = br.readLine()) != null) {
            if (!line.equals(request.getParameter("linkimagen").toString())) {
                content += line + "\n";
            }
        }
        br.close();
        FileWriter f2 = new FileWriter(file, false);
        f2.write(content);
        f2.close();
        out.print("<script>alert('La imagen se eliminó correctamente');</script>");
        request.getRequestDispatcher("../imagenescategoria.jsp").forward( request, response );

%>

 <jsp:include page="../footer.jsp"/>
    </body>
</html>