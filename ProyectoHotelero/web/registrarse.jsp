<%-- 
    Document   : registrarse
    Created on : 28/11/2016, 06:32:40 PM
    Author     : Denisse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <head>
        <link rel="stylesheet" type="text/css" href="./css/registrarse.css"> 
        <title>Registrase</title>
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <div class="registro">
            <form method="POST">
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <label >Identidad:</label>
                            <input type="text" class="form-control"  >
                            <label >Primer Nombre:</label>
                            <input type="text" class="form-control" >
                            <label >Segundo Nombre:</label>
                            <input type="text" class="form-control"  >
                            <label >Primer Apellido:</label>
                            <input type="text" class="form-control"  >
                            <label >Segundo Apellido:</label>
                            <input type="text" class="form-control"  >

                        </div>
                        <div class="col-md-4">
                            <label >Fecha Nacimiento:</label>
                            <input type="date" class="form-control"  >
                            <label >País:</label>
                            <input type="text" class="form-control"  >
                            <label >Ciudad:</label>
                            <input type="text" class="form-control"  >
                            <label >Correo Electrónico:</label>
                            <input type="email" class="form-control"  >
                            <label >Teléfono:</label>
                            <input type="text" class="form-control" >
                        </div>
                    </div>
                    <br>
                    <div class="row">

                        <input type="submit" class="btn btn-primary" value="Registrarse" />
                    </div>
                </div>
        </div>
    </form>

</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
