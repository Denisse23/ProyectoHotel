$(function () {
    $("#div-nuevo-activo").hide();
    $("#div-modificar-activo").hide();

    $("#button-nuevo-activo").click(function () {
        $("#div-nuevo-activo").show();
    });

    $("#button-agregar-activo").click(function () {
        $("#span-nombre-nuevo-activo").text("");
        $("#span-cantidad-nuevo-activo").text("");
        var cont_errores = 0;
        if ($("#text-nombre-nuevo-activo").val() === "") {
            $("#span-nombre-nuevo-activo").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#num-cantidad-nuevo-activo").val() === "") {
            $("#span-cantidad-nuevo-activo").text("Cantidad disponible no puede ser vacío");
            cont_errores++;
        } else if ($("#num-cantidad-nuevo-activo").val() < 1) {
            $("#span-cantidad-nuevo-activo").text("Cantidad disponible no puede ser menor a uno");
            cont_errores++;
        }
        if (cont_errores === 0) {
            $('#form-nuevo-activo').submit();
        }
    });


    $("#button-modificar-activo").click(function () {
        $("#span-nombre-modificar-activo").text("");
        $("#span-cantidad-modificar-activo").text("");
        var cont_errores = 0;
        if ($("#text-nombre-modificar-activo").val() === "") {
            $("#span-nombre-modificar-activo").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#num-cantidad-modificar-activo").val() === "") {
            $("#span-cantidad-modificar-activo").text("Cantidad disponible no puede ser vacío");
            cont_errores++;
        } else if ($("#num-cantidad-modificar-activo").val() < 0) {
            $("#span-cantidad-modificar-activo").text("Cantidad disponible no puede ser menor a cero");
            cont_errores++;
        }
        if (cont_errores === 0) {
            $('#form-modificar-activo').submit();
        }
    });
    
    $("#button-hotel-informacion").click(function () {
        $("#span-nombre-hotel-informacion").text("");
        $("#span-mision-hotel-informacion").text("");
        $("#span-vision-hotel-informacion").text("");
        $("#span-tel-hotel-informacion").text("");
        $("#span-email-hotel-informacion").text("");
        $("#span-pais-hotel-informacion").text("");
        $("#span-ciudad-hotel-informacion").text("");
        $("#span-ubicacion-hotel-informacion").text("");
        var cont_errores = 0;
        if ($("#text-nombre-hotel-informacion").val() === "") {
            $("#span-nombre-hotel-informacion").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-mision-hotel-informacion").val() === "") {
            $("#span-mision-hotel-informacion").text("Misión no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-vision-hotel-informacion").val() === "") {
            $("#span-vision-hotel-informacion").text("Visión no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-tel-hotel-informacion").val() === "") {
            $("#span-tel-hotel-informacion").text("Teléfono no puede ser vacío");
            cont_errores++;
        }else if(!isValidTel($("#text-tel-hotel-informacion").val())){
            $("#span-tel-hotel-informacion").text("El teléfono es incorrecto");
            cont_errores++;
        }
        if ($("#text-email-hotel-informacion").val() === "") {
            $("#span-email-hotel-informacion").text("Email no puede ser vacío");
            cont_errores++;
        }else if(!isValidEmail($("#text-email-hotel-informacion").val())){
            $("#span-email-hotel-informacion").text("El email es incorrecto");
            cont_errores++;
        }
        if ($("#text-pais-hotel-informacion").val() === "") {
            $("#span-pais-hotel-informacion").text("País no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-ciudad-hotel-informacion").val() === "") {
            $("#span-ciudad-hotel-informacion").text("Ciudad no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-ubicacion-hotel-informacion").val() === "") {
            $("#span-ubicacion-hotel-informacion").text("Ubicación no puede ser vacío");
            cont_errores++;
        }
        if (cont_errores === 0) {
            $('#form-hotel-informacion').submit();
        }
    });

});

function isValidEmail(mail){
    return /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(mail);
}

function isValidTel(tel){
    return /^\([0-9]{3,3}\)[0-9]{8,8}$/.test(tel);
}

function modificarActivo(id, nombre, cantidaddis, cantidaduso) {
    $("#div-modificar-activo").show();
    $("#span-nombre-modificar-activo").text("");
    $("#span-cantidad-modificar-activo").text("");
    $("#text-id-modificar-activo").val(id);
    $("#text-nombre-modificar-activo").val(nombre);
    $("#num-cantidad-modificar-activo").val(cantidaddis);
    $("#text-cantidaduso-modificar-activo").val(cantidaduso);
}

