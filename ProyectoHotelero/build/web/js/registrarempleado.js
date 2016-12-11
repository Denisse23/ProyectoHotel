$(function () {
     $("#button-registrarseempledo").click(function () {
        $("#span-primernombre-empleado").text("");
        $("#span-segundonombre-empleado").text("");
        $("#span-primerapellido-empleado").text("");
        $("#span-segundoapellido-empleado").text("");
         $("#span-email-empleado").text("");
        var cont_errores = 0;
        if ($("#text-primernombre-empleado").val() === "") {
            $("#span-primernombre-empleado").text("Primer nombre no puede ser vacío");
            cont_errores++;
        } else if(!isValidNombre($("#text-primernombre-empleado").val())){
            $("#span-primernombre-empleado").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if ($("#text-primerapellido-empleado").val() === "") {
            $("#span-primerapellido-empleado").text("Primer apellido no puede ser vacío");
            cont_errores++;
        } else if(!isValidNombre($("#text-primerapellido-empleado").val())){
            $("#span-primerapellido-empleado").text("Solo puede ingresar letras");
            cont_errores++;
        }
        
        if(!isValidNombre($("#text-segundonombre-empleado").val())){
            $("#span-segundonombre-empleado").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if(!isValidNombre($("#text-segundoapellido-empleado").val())){
            $("#span-segundoapellido-empleado").text("Solo puede ingresar letras");
            cont_errores++;
        }
        if ($("#text-email-empleado").val() === "") {
            $("#span-email-empleado").text("Email no puede ser vacío");
            cont_errores++;
        } else if(!isValidEmail($("#text-email-empleado").val())){
            $("#span-email-empleado").text("Email incorrecto");
            cont_errores++;
        } 
        if (cont_errores === 0) {
            var sinCifrar =$('#text-password').val(); 
            $('#text-password').val(hex_md5(sinCifrar));
            $('#form-registrarempleado').submit();
        }
    });
});

function isValidEmail(mail){
    return /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(mail);
}


function isValidNombre(n){
    return /^[a-zA-z]*$/.test(n);
}
