$(function () {
    $("#tarjeta").hide();
    
});

function formaPago(){
    if($("#select-formapago").val()==="0"){
         $("#tarjeta").hide();
         $("#fac").hide()();
    }else{
        $("#tarjeta").show();
        $("#fac").hide()();
    }
}
