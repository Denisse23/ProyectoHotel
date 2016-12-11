function mostrar_mapa(centinela) {
    //ubicacion inicial del mapa
    var ubicacion = new google.maps.LatLng(14.6203, -87.644);  //latitud y longitud                 
    //parametros iniciales
    var opciones = {zoom: 7, //acercamiento  
        center: ubicacion, //unicacion inicial   
        mapTypeId: google.maps.MapTypeId.ROADMAP //las posibles opciones son ROADMAP/SATELLITE/HYBRID/TERRAIN   
    };
    //creacion del mapa
    var map = new google.maps.Map(document.getElementById("mapa"), opciones);


    if (centinela == 1) {
        //colocar una marca sobre el mapa
        mi_ubicacion = new google.maps.Marker({
            position: new google.maps.LatLng(14.075904, -87.199396), //posicion de la marca
            icon: 'persona.png', //imagen que aparecera en la marca, debe estar en el server
            map: map, //mapa donde estara la marca	   
            title: 'Ubicación Hotel' // titulo al hacer un mouse over	
        });

        google.maps.event.addListener(mi_ubicacion, 'click', function () {
            // Calling the open method of the infoWindow 
            infowindow.open(map, mi_ubicacion);
        });
    }
}
