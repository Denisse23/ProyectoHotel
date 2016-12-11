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
         <script type="text/javascript" src="<%= application.getContextPath()+"/js/md5.js"%>"></script>
         <script type="text/javascript" src="<%= application.getContextPath()+"/js/login.js"%>"></script>
        <title>Home</title>
    </head>
   
    <body>
         <jsp:include page="header.jsp"/>
         <div class="login">
             <form method="POST" action="autenticar.jsp" id="form-login">
                 <div class="form-group">
                     <label >Usuario:</label>
                     <input type="text" class="form-control" id="text-usuario-login" name="text-usuario-login"><span id="span-usuario-login"></span>
                      <label >Password:</label>
                     <input type="password" class="form-control" id="text-pass-login" name="text-pass-login" ><span id="span-pass-login"></span>
                     
                     <br>
                     <input type="button" name="button-entrar-login" id="button-entrar-login" class="btn btn-primary" value="Entrar" />
                 </div>
             </form>
         </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
