$(function () {
     $("#button-registrarse").click(function () {
        $("#span-identidad-cliente").text("");
        $("#span-primernombre-cliente").text("");
        $("#span-segundonombre-cliente").text("");
        $("#span-primerapellido-cliente").text("");
        $("#span-segundoapellido-cliente").text("");
        $("#span-nacimiento-cliente").text("");
        $("#span-pais-cliente").text("");
        $("#span-ciudad-cliente").text("");
        $("#span-email-cliente").text("");
        $("#span-telefono-cliente").text("");
        var cont_errores = 0;
        if ($("#text-identidad-cliente").val() === "") {
            $("#span-identidad-cliente").text("Identidad no puede ser vacío");
            cont_errores++;
        }else if(!isValidIdentidad($("#text-identidad-cliente").val())){
            $("#span-identidad-cliente").text("Identidad incorrecta");
            cont_errores++;
        }
        if ($("#text-primernombre-cliente").val() === "") {
            $("#span-primernombre-cliente").text("Primer nombre no puede ser vacío");
            cont_errores++;
        } else if(!isValidNombre($("#text-primernombre-cliente").val())){
            $("#span-primernombre-cliente").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if ($("#text-primerapellido-cliente").val() === "") {
            $("#span-primerapellido-cliente").text("Primer apellido no puede ser vacío");
            cont_errores++;
        } else if(!isValidNombre($("#text-primerapellido-cliente").val())){
            $("#span-primerapellido-cliente").text("Solo puede ingresar letras");
            cont_errores++;
        }
        
        if(!isValidNombre($("#text-segundonombre-cliente").val())){
            $("#span-segundonombre-cliente").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if(!isValidNombre($("#text-segundoapellido-cliente").val())){
            $("#span-segundoapellido-cliente").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if ($("#text-nacimiento-cliente").val() === "") {
            $("#span-nacimiento-cliente").text("Fecha de nacimiento no puede ser vacío");
            cont_errores++;
        } 
         if ($("#text-pais-cliente").val() === "") {
            $("#span-pais-cliente").text("País no puede ser vacío");
            cont_errores++;
        } else if(!isValidNombre($("#text-pais-cliente").val())){
            $("#span-pais-cliente").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if ($("#text-ciudad-cliente").val() === "") {
            $("#span-ciudad-cliente").text("Ciudad no puede ser vacío");
            cont_errores++;
        }  else if(!isValidNombre($("#text-ciudad-cliente").val())){
            $("#span-ciudad-cliente").text("Solo puede ingresar letras");
            cont_errores++;
        }
         if ($("#text-email-cliente").val() === "") {
            $("#span-email-cliente").text("Email no puede ser vacío");
            cont_errores++;
        } else if(!isValidEmail($("#text-email-cliente").val())){
            $("#span-email-cliente").text("Email incorrecto");
            cont_errores++;
        } 
        if ($("#text-telefono-cliente").val() === "") {
            $("#span-telefono-cliente").text("Teléfono no puede ser vacío");
            cont_errores++;
        }else if(!isValidTel($("#text-telefono-cliente").val())){
            $("#span-telefono-cliente").text("Teléfono incorrecto");
            cont_errores++;
        } 
        
        if (cont_errores === 0) {
            var sinCifrar =$('#text-password').val(); 
            $('#text-password').val(hex_md5(sinCifrar));
            $('#form-registrarse').submit();
        }
    });
});

function isValidIdentidad(id){
    return /^([0-9]){13,13}$/.test(id);
}


function isValidNombre(n){
    return /^[a-zA-z]*$/.test(n);
}

function isValidEmail(mail){
    return /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(mail);
}

function isValidTel(tel){
    return /^\([0-9]{3,3}\)[0-9]{8,8}$/.test(tel);
}
