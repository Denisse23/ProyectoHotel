<%-- 
    Document   : index
    Created on : 28/11/2016, 05:53:29 PM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    if(request.getParameter("user")!=null){
        session.setAttribute("Rol", request.getParameter("user").toString());
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
            <img src="./images/hotel/entrada.jpg"/>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
