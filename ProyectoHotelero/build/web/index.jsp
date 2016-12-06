<%-- 
    Document   : index
    Created on : 28/11/2016, 05:53:29 PM
    Author     : Denisse
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (request.getParameter("user") != null) {
        session.setAttribute("Rol", request.getParameter("user").toString());
        if(request.getParameter("user").equals("Administrador")){
            session.setAttribute("Id-Usuario", 2);
            session.setAttribute("Usuario", "useradmin");
        }else{
            session.setAttribute("Id-Usuario", 3);
            session.setAttribute("Usuario", "primeruser");
        }
    }
    
%>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/index.css">
        <title>Home</title>
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <div class="slides">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                 <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    
            <%
                ServletContext context = session.getServletContext();
                String realContextPath = context.getRealPath(request.getContextPath());
                File file = new File(realContextPath.substring(0, realContextPath.length() - 17) + "/images/imghotel.txt");
                FileInputStream fis = new FileInputStream(file);

                BufferedReader br = new BufferedReader(new InputStreamReader(fis));

                String line = null;
                int cont=0;
                while ((line = br.readLine()) != null) {
                    if(cont==0){
                        
                    
            %>
                <div class="item active">
                        <%= line%>
                </div>
            <%          }else{%>
                <div class="item">
                        <%= line%>
                    </div>
                
                <% }cont++;} %>
            </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
