$(function () {

    $("#button-realizar-busqueda").click(function () {
        var conterrors = 0;
        if ($("#date-fecha-llegada").val()==="") {
            $("#span-fecha-llegada").text("La fecha de llegada no puede ser vacía");
            conterrors++;
        }
        if ($("#date-fecha-salida").val() === "") {
            $("#span-fecha-salida").text("La fecha de salida no puede ser vacía");
            conterrors++;
        }

        if (conterrors === 0) {
            var values = $('#list-habitaciones-agregadas li').map(function () {
                return $(this).attr("value");
            });
            for (var i = 0; i < values.length; i++) {
                if (i === 0)
                    $("#textarea-habitaciones-agregadas-at").append(values[i]);
                else
                    $("#textarea-habitaciones-agregadas-at").append("," + values[i]);
            }
            $("#form-relizar-busqueda").submit();
        }
    });

});

function agregarHabitacion(id) {
    $("#list-habitaciones-agregadas").append('<li class="list-group-item" value="' + id + '">' + id + '</li>');
}

function changeCategoria() {
    $('#form-categoria-reservar').submit();

}

