<%-- 
    Document   : login
    Created on : 28/11/2016, 06:04:33 PM
    Author     : Denisse
--%>
<%
   if(session.getAttribute("Rol")!=null){
       out.write("<script>window.location.href='"+application.getContextPath()+"/index.jsp';</script>");
   }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <jsp:include page="head.jsp"/>
    <head>
         <link rel="stylesheet" type="text/css" href="./css/login.css">   
        <title>Home</title>
    </head>
   
    <body>
         <jsp:include page="header.jsp"/>
         <div class="login">
             <form method="POST" action="index.jsp">
                 <div class="form-group">
                     <label >Usuario:</label>
                     <input type="text" class="form-control" name="user">
                      <label >Password:</label>
                     <input type="password" class="form-control"  >
                     <br>
                     <input type="submit" class="btn btn-primary" value="Entrar" />
                 </div>
             </form>
         </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
