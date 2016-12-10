$(function () {

    $("#button-realizar-busqueda").click(function () {
        var conterrors = 0;
        if ($("#date-fecha-llegada").val() === "") {
            $("#span-fecha-llegada").text("La fecha de llegada no puede ser vacía");
            conterrors++;
        }
        if ($("#date-fecha-salida").val() === "") {
            $("#span-fecha-salida").text("La fecha de salida no puede ser vacía");
            conterrors++;
        }
        if (conterrors === 0 && !validasFechas()) {
            conterrors++;
        }

        if (conterrors === 0) {
            
            $("#form-relizar-busqueda").submit();
        }
    });
    
    $("#button-reserva-clientes-aceptar").click(function () {
        var values = $('#list-habitaciones-agregadas li').map(function () {
        return $(this).attr("value");
    });
    for (var i = 0; i < values.length; i++) {
        if (i === 0)
            $("#textarea-habitaciones-list").append(values[i]);
        else
            $("#textarea-habitaciones-list").append("," + values[i]);
        
      }
        
        if(values.length>0)
            $("#form-reserva-clientes-aceptar").submit();
            else
                alert("No se agregaron habitaciones a la reservación");
        
    });

});

function validasFechas() {
    var ms = Date.parse($("#date-fecha-llegada").val());
    var fechalle = new Date(ms);
    ms = Date.parse($("#date-fecha-salida").val());
    var fechasali = new Date(ms);
    if (fechasali <= fechalle) {
        $("#span-fecha-llegada").text("La fecha de llegada es mayor o igual que la fecha de salida");
        return false;
    }
    var today = new Date();
    if (fechalle < today) {
        $("#span-fecha-llegada").text("La fecha de llegada no puede ser anterior al día de hoy");
        return false;
    }

    return true;
}

function agregarHabitacion(id) {
    var values = $('#list-habitaciones-agregadas li').map(function () {
        return $(this).attr("value");
    });
    var esta = false;
    for (var i = 0; i < values.length; i++) {
        var v = values[i];
        if (v.toString()===id.toString()) {
            esta = true;
            break;
        }
    }
    if (!esta) {
        $("#list-habitaciones-agregadas").append('<li class="list-group-item" value="' + id + '">' + id + '</li>');
    }
}

function changeCategoria() {
    var values = $('#list-habitaciones-agregadas li').map(function () {
        return $(this).attr("value");
    });
    for (var i = 0; i < values.length; i++) {
        if (i === 0)
            $("#textarea-habitaciones-list-at").append(values[i]);
        else
            $("#textarea-habitaciones-list-at").append("," + values[i]);
        
      
            
        
    }
    $('#form-categoria-reservar').submit();

}
