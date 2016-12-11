$(function () {
    
     $("#button-entrar-login").click(function () {
         
        $("#span-usuario-login").text("");
        $("#span-pass-login").text("");
        var cont_errores = 0;
        if ($("#text-usuario-login").val() === "") {
            $("#span-usuario-login").text("Usuario no puede ser vacío");
            cont_errores++;
        }
        if ($("#text-pass-login").val() === "") {
            $("#span-pass-login").text("Password no puede ser vacío");
            cont_errores++;
        }
        if (cont_errores === 0) {
            var sinCifrar =$('#text-pass-login').val(); 
            $('#text-pass-login').val(hex_md5(sinCifrar));
            $('#form-login').submit();
        }
     });
});
