part of 'datos-proforma.dart';

DatosProforma _$DatosProformaFromJson(Map<String, dynamic> json) {
  return DatosProforma()
    ..numerotramite = json['numerotramite'] as int
    ..repertorio = json['repertorio'] as int
    ..doc_solicitante = json['doc_solicitante'] as String
    ..nombre_solicitante = json['nombre_solicitante'] as String
    ..correo_solicitante = json['correo_solicitante'] as String
    ..doc_beneficiario = json['doc_beneficiario'] as String
    ..nombre_beneficiario = json['nombre_beneficiario'] as String
    ..correo_beneficiario = json['correo_beneficiario'] as String
    ..revisor = json['revisor'] as String
    ..numerofactura = json['numerofactura'] as String
    ..claveacceso = json['claveacceso'] as String
    ..numeroautorizacion = json['numeroautorizacion'] as String
    ..estadotramite = json['estadotramite'] as String
    ..mensaje = json['mensaje'] as String
    ..fechaingreso = json['fechaingreso'] as int
    ..fechaentrega = json['fechaentrega'] as int
    ..subtotal = json['subtotal'] as num
    ..descuento = json['descuento'] as num
    ..dscto_limitcobro = json['dscto_limitcobro'] as num
    ..descuento_porc = json['descuento_porc'] as num
    ..gastos_generales = json['gastos_generales'] as num
    ..totalPagar = json['totalPagar'] as num
    ..avance = json['avance'] as double
    ..detalle = (json['detalle'] as List)
        .map((e) => e == null
            ? null
            : DatosDetalleProforma.fromJson(e as Map<String, dynamic>))
        .cast<DatosDetalleProforma>()
        .toList()
    ..detalleSolicitud = json['detalleSolicitud'] as String
    ..detalleAvance = json['detalleAvance'] as String
    ..acto = json['acto'] as String;
}

Map<String, dynamic> _$DatosProformaToJson(DatosProforma instance) =>
    <String, dynamic>{
      'numerotramite': instance.numerotramite,
      'repertorio': instance.repertorio,
      'doc_solicitante': instance.doc_solicitante,
      'nombre_solicitante': instance.nombre_solicitante,
      'correo_solicitante': instance.correo_solicitante,
      'doc_beneficiario': instance.doc_beneficiario,
      'nombre_beneficiario': instance.nombre_beneficiario,
      'correo_beneficiario': instance.correo_beneficiario,
      'revisor': instance.revisor,
      'numerofactura': instance.numerofactura,
      'claveacceso': instance.claveacceso,
      'numeroautorizacion': instance.numeroautorizacion,
      'estadotramite': instance.estadotramite,
      'mensaje': instance.mensaje,
      'fechaingreso': instance.fechaingreso,
      'fechaentrega': instance.fechaentrega,
      'subtotal': instance.subtotal,
      'descuento': instance.descuento,
      'dscto_limitcobro': instance.dscto_limitcobro,
      'descuento_porc': instance.descuento_porc,
      'gastos_generales': instance.gastos_generales,
      'totalPagar': instance.totalPagar,
      'avance': instance.avance,
      'detalle': instance.detalle,
      'detalleSolicitud': instance.detalleSolicitud,
      'detalleAvance': instance.detalleAvance,
      'acto': instance.acto
    };
