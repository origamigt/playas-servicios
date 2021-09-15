# Firma Electronica OrigamiGT

[![N|Solid](https://img1.wsimg.com/isteam/ip/21b6d1c7-6f40-4d47-9dc3-151234d95e78/logo/451e45c9-9909-495e-97b2-d712b9ac5d7b.png/:/rs=w:1023,cg:true,m/rs=h:108px/ll)](https://img1.wsimg.com/isteam/ip/21b6d1c7-6f40-4d47-9dc3-151234d95e78/logo/451e45c9-9909-495e-97b2-d712b9ac5d7b.png/:/rs=w:1023,cg:true,m/rs=h:108px/ll)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

WebServices en SpringBoot para generar un archivo PDF con firma electronica


### Implementación

Se debe crear un modelo de datos de con los siguientes campos y enviarlos en formato JSON

``` 
{
    "ubicacion": "Registro de la Propiedad",
    "motivo": "Memorando N° 005",
    "archivoFirmar": "C:\\Users\\Documentos\\Proyectos\\proyecto-memorando\\MEMORANDO NRO. 05-LECTOR-BARRAS.pdf",
    "archivo": "C:/facturacion-electronica/firmas-electronicas/ANDY AUGUSTO SANCHEZ GONZALEZ 280721123043.p12",
    "clave": "clave",
    "tipoFirma": "QR",
    "urlQr": "",
    "numeroPagina": 1,
    "posicionX1": "80",
    "posicionY1": "200"
}
```

### Docker


```sh
cd asgard-firma-ec
docker build -f Dockerfile -t asgard-firma-ec .
```

Esto creará una imagen el servicio web y podra ser ejecutada como contenedor

El sistema corre sobre el puerto 8728 

```sh
docker run -d -p 8728:8728 --restart="always" asgard-firma-ec
```
 
```sh
127.0.0.1:8728
```

License
----

MIT


**Free Software, Hell Yeah!**
