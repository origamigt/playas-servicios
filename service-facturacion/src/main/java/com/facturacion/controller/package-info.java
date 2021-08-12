package com.facturacion.controller;

/*
----MODELO DE JSON PARA FACTURA
http://127.0.0.1:8780/api/facturacionElectronica/enviarFacturacionElectronica/
{
	"idLiquidacion":8850,
	"tipoLiquidacionSGR":"RL", //RF -  RN
	"tramite":8812,
	"isOnline":false,
	"ambiente":"1",
	"puntoEmision":"004",
	"rucEntidad":"1160053010001",
	"comprobanteCodigo":"01",
	"numComprobante":"6088",
	"descuentoAdicional":0.00,
	"cabecera":{
		"fechaEmision":"2019-08-26",
		"cedulaRuc":"0953255957",
		"propietario":"SANCHEZ GONZÁLEZ ANDY AUGUSTO",
		"direccion":"GYE",
		"correo":"andysanchezgonzalez1996@gmail.com",
		"telefono":"0960978378",
		"esPasaporte":false
	},
	"detallePagos":[{
		"formaPago":"01",
		"total":6.25
	}],
	"detalles":{
		"detalle":[{
				"descripcion":"CERTIFICADO SIMPLE",
				"valorUnitario":6.25,
				"valorTotal":6.25,
				"recargo":0.0,
				"descuento":0.0,
				"cantidad":1,
				"iva":0.0,
				"codigoPrincipal":"115",
				"codigoTarifa":"6"}]
	}
}



---MODELO DE NOTA DE CRREDITO

{
	  "puntoEmision" : "004",
	  "rucEntidad": "1360086410001",
	  "comprobanteCodigo": "04",
	  "numComprobanteModifica" : "001-004-000000119",
	  "motivoNotaCredito": "DEMO PRUEBA",
	  "tipoDocumentoModifica": "01",
	  "fechaEmisionDocumentoModifica": "2019-01-31",
	  "cabecera": {
	    "entidadTributaria": "1360000200001",
	    "fechaEmision": "2019-01-31",
	    "cedulaRuc": "1304543984",
	    "propietario": "VALDIVIEZO RUIZ CRISTOBAL COLON",
	    "direccion": "SAN RAFAEL",
	    "telefono": "NINGUNO",
	    "correo": "aparraga31@gmail.com"
	  },
	  "detalles": {
	    "detalle": [
	      {
	        "descripcion": "Arriendo Mercado #2 febrero/2017",
	        "valor": "16.96",
	        "descuento": "6",
	        "cantidad": "1",
	        "iva": "12",
	        "codigoTarifa": "2"
	      }
	    ]
	  }
}


---MODELO DE NOTA DE DEBITO

{
	  "puntoEmision" : "004",
	  "rucEntidad": "1360086410001",
	  "comprobanteCodigo": "05",
	  "numComprobanteModifica" : "001-004-000000119",
	  "tipoDocumentoModifica": "01",
	  "fechaEmisionDocumentoModifica": "2019-01-29",
	  "cabecera": {
	    "entidadTributaria": "1360000200001",
	    "fechaEmision": "2019-01-29",
	    "cedulaRuc": "1304543984",
	    "propietario": "VALDIVIEZO RUIZ CRISTOBAL COLON",
	    "direccion": "SAN RAFAEL",
	    "telefono": "NINGUNO",
	    "correo": "aparraga31@gmail.com"
	  },
	  "detallePagos": [
	  		{
	  			"formaPago" : "01",
	  			"total" : "67.20"
	  		}
	  	],
	  "impuestoNotaDebito": {
			"codigo" : 2,
			"codigoPorcentaje" : "2",
			"tarifa" : "12",
			"baseImponible" : "60",
			"valor" : "7.20"
	  },
	  "motivosNotaDebito" : [
			{
				"razon" : "INTERES MORA",
				"valor": "10"
			},
			{
				"razon" : "GASTOS",
				"valor": "50"
			}
	  ]
}



----MODELO DE JSON PARA COMPROBANTE DE RETENCION
{
	  "puntoEmision" : "004",
	  "rucEntidad": "1360086410001",
	  "comprobanteCodigo": "07",
	  "mes" : "2",
	  "anio": "2018",
	  "cabecera": {
	    "entidadTributaria": "1360000200001",
	    "fechaEmision": "2019-01-29",
	    "cedulaRuc": "0953255957",
	    "propietario": "VALDIVIEZO RUIZ CRISTOBAL COLON",
	    "direccion": "SAN RAFAEL",
	    "telefono": "NINGUNO",
	    "correo": "aparraga31@gmail.com"
	  },
	  "impuestoComprobanteRetencion": [
			{
	  			"codigo" : 2,
				"codigoPorcentaje" : "2",
				"fechaEmisionDocumento" : "2018-02-23",
				"baseImponible" : "60",
				"codigoDocumento" : "01",
				"numDocumento" : "000012345678901",
				"porcentajeRetencion" : "70"
			}
	  ]
}



 */