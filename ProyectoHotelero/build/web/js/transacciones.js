$(function () {
    $("#tarjeta").hide();
    
});

function formaPago(){
    if($("#select-formapago").val()==="0"){
         $("#tarjeta").hide();
    }else{
        $("#tarjeta").show();
    }
}
