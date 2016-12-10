$(function () {
    $("#div-nuevo-activo").hide();
    $("#div-modificar-activo").hide();

    $("#div-nuevo-servicio").hide();
    $("#div-modificar-servicio").hide();
    
    $("#div-nuevo-categoria").hide();
    $("#div-modificar-categoria").hide();
    
    $("#div-nuevo-habitacion").hide();
     $("#div-nuevo-promocion").hide();
    
    $("#button-nuevo-activo").click(function () {
        $("#div-nuevo-activo").show();
    });

     $("#button-nuevo-servicio").click(function () {
        $("#div-nuevo-servicio").show();
    });
    
    
     $("#button-nuevo-categoria").click(function () {
        $("#div-nuevo-categoria").show();
    });
    
    $("#button-nuevo-habitacion").click(function () {
        $("#div-nuevo-habitacion").show();
    });
     $("#button-nuevo-promocion").click(function () {
        $("#div-nuevo-promocion").show();
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
    
    $("#button-agregar-servicio").click(function () {
        $("#span-nombre-nuevo-servicio").text("");
        $("#span-precio-nuevo-servicio").text("");
        var cont_errores = 0;
        if ($("#text-nombre-nuevo-servicio").val() === "") {
            $("#span-nombre-nuevo-servicio").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-precio-nuevo-servicio").val() === "") {
            $("#span-precio-nuevo-servicio").text("Precio no puede ser vacío");
            cont_errores++;
        } else if (!isValidPrecio($("#text-precio-nuevo-servicio").val())) {
            $("#span-precio-nuevo-servicio").text("El precio es incorrecto");
            cont_errores++;
        }
        
        if (cont_errores === 0) {
            $('#form-nuevo-servicio').submit();
        }
    });


    $("#button-modificar-servicio").click(function () {
        $("#span-nombre-modificar-servicio").text("");
        $("#span-precio-modificar-servicio").text("");
        var cont_errores = 0;
        if ($("#text-nombre-modificar-servicio").val() === "") {
            $("#span-nombre-modificar-servicio").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-precio-modificar-servicio").val() === "") {
            $("#span-precio-modificar-servicio").text("Precio no puede ser vacío");
            cont_errores++;
        } else if (!isValidPrecio($("#text-precio-modificar-servicio").val())) {
            $("#span-precio-modificar-servicio").text("El precio es incorrecto");
            cont_errores++;
        }
        if (cont_errores === 0) {
            $('#form-modificar-servicio').submit();
        }
    });
    
    $("#button-agregar-categoria").click(function () {
        $("#span-nombre-nuevo-categoria").text("");
        $("#span-precio-nuevo-categoria").text("");
        var cont_errores = 0;
        if ($("#text-nombre-nuevo-categoria").val() === "") {
            $("#span-nombre-nuevo-categoria").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-precio-nuevo-categoria").val() === "") {
            $("#span-precio-nuevo-categoria").text("Precio no puede ser vacío");
            cont_errores++;
        } else if (!isValidPrecio($("#text-precio-nuevo-categoria").val())) {
            $("#span-precio-nuevo-categoria").text("El precio es incorrecto");
            cont_errores++;
        }
        
        if (cont_errores === 0) {
            $('#form-nuevo-categoria').submit();
        }
    });


    $("#button-modificar-categoria").click(function () {
        $("#span-nombre-modificar-categoria").text("");
        $("#span-precio-modificar-categoria").text("");
        var cont_errores = 0;
        if ($("#text-nombre-modificar-categoria").val() === "") {
            $("#span-nombre-modificar-categoria").text("Nombre no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-precio-modificar-categoria").val() === "") {
            $("#span-precio-modificar-categoria").text("Precio no puede ser vacío");
            cont_errores++;
        } else if (!isValidPrecio($("#text-precio-modificar-categoria").val())) {
            $("#span-precio-modificar-categoria").text("El precio es incorrecto");
            cont_errores++;
        }
        if (cont_errores === 0) {
            $('#form-modificar-categoria').submit();
        }
    });
    
     
    $("#button-agregar-habitacion").click(function () {
        $("#span-id-nuevo-habitacion").text("");
        var cont_errores = 0;
        if ($("#text-id-nuevo-habitacion").val() === "") {
            $("#span-id-nuevo-habitacion").text("Id no puede ser vacío");
            cont_errores++;
        }else if(!isValidId($("#text-id-nuevo-habitacion").val())){
            $("#span-id-nuevo-habitacion").text("El id es incorrecto");
            cont_errores++;
        }
        
        if (cont_errores === 0) {
            $('#form-nuevo-habitacion').submit();
        }
    });
    
    $("#button-agregar-promocion").click(function () {
        $("#span-porcentaje-agregar-promocion").text("");
        $("#span-fecha-inicio-promocion").text("");
        $("#span-fecha-fin-promocion").text("");
        var cont_errores = 0;
        if ($("#text-porcentaje-agregar-promocion").val() === "") {
            $("#span-porcentaje-agregar-promocion").text("El porcentaje no puede ser vacío");
            cont_errores++;
        }else if(!isValidPocentaje($("#text-porcentaje-agregar-promocion").val())){
            $("#span-porcentaje-agregar-promocion").text("El porcentaje está incorrecto");
            cont_errores++;
        }
        if ($("#date-fecha-inicio-promocion").val() === "") {
            $("#span-fecha-inicio-promocion").text("La fecha de inicio no puede ser vacía");
            cont_errores++;
        }
        if ($("#date-fecha-fin-promocion").val() === "") {
            $("#span-fecha-fin-promocion").text("La fecha de fin no puede ser vacía");
            cont_errores++;
        }
        if (cont_errores === 0 && !validasFechas()) {
            cont_errores++;
        }

        
        if (cont_errores === 0) {
            $('#form-nuevo-promocion').submit();
        }
    });

});
function validasFechas() {
    var ms = Date.parse($("#date-fecha-inicio-promocion").val());
    var fechalle = new Date(ms);
    ms = Date.parse($("#date-fecha-fin-promocion").val());
    var fechasali = new Date(ms);
    if (fechasali <= fechalle) {
        $("#span-fecha-inicio-promocion").text("La fecha de inicio es mayor o igual que la fecha fin");
        return false;
    }
    var today = new Date();
    if (fechalle < today) {
        $("#span-fecha-inicio-promocion").text("La fecha de inicio no puede ser anterior al día de hoy");
        return false;
    }

    return true;
}
function isValidEmail(mail){
    return /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(mail);
}

function isValidTel(tel){
    return /^\([0-9]{3,3}\)[0-9]{8,8}$/.test(tel);
}

function isValidPrecio(precio){
    return /^[0-9]+(\.[0-9]{2,2}){0,1}$/.test(precio);
}
function isValidId(id){
    return /^[0-9]+$/.test(id);
}

function isValidPocentaje(porcentaje){
    return /^(100|([0-9]){2,2}(\.[0-9]{2,2}){0,1})$/.test(porcentaje);
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


function modificarServicio(id, nombre, precio) {
    $("#div-modificar-servicio").show();
    $("#span-nombre-modificar-servicio").text("");
    $("#span-precio-modificar-servicio").text("");
    $("#text-id-modificar-servicio").val(id);
    $("#text-nombre-modificar-servicio").val(nombre);
    $("#text-precio-modificar-servicio").val(precio);
}

function modificarCategoria(id, nombre, precio) {
    $("#div-modificar-categoria").show();
    $("#span-nombre-modificar-categoria").text("");
    $("#span-precio-modificar-categoria").text("");
    $("#text-id-modificar-categoria").val(id);
    $("#text-nombre-modificar-categoria").val(nombre);
    $("#text-precio-modificar-categoria").val(precio);
}



