part of 'datos-proforma.dart';

DatosProforma _$DatosProformaFromJson(Map<String, dynamic> json) {
  try {
    return DatosProforma()
      ..numerotramite = json['numerotramite'] as int? ?? null
      ..doc_solicitante = json['doc_solicitante'] as String? ?? null
      ..nombre_solicitante = json['nombre_solicitante'] as String? ?? null
      ..correo_solicitante = json['correo_solicitante'] as String? ?? null
      ..doc_beneficiario = json['doc_beneficiario'] as String? ?? null
      ..nombre_beneficiario = json['nombre_beneficiario'] as String? ?? null
      ..correo_beneficiario = json['correo_beneficiario'] as String? ?? null
      ..revisor = json['revisor'] as String? ?? null
      ..numerofactura = json['numerofactura'] as String? ?? null
      ..estadotramite = json['estadotramite'] as String? ?? null
      ..mensaje = json['mensaje'] as String? ?? ''
      ..fechaingreso = json['fechaingreso'] as int? ?? null
      ..fechaentrega = json['fechaentrega'] as int? ?? null
      ..subtotal = json['subtotal'] as num? ?? null
      ..descuento = json['descuento'] as num? ?? null
      ..totalPagar = json['totalPagar'] as double? ?? null
      ..detalle = json['detalle'] != null
          ? (json['detalle'] as List)
              .map((e) =>
                  DatosDetalleProforma.fromJson(e as Map<String, dynamic>))
              .cast<DatosDetalleProforma>()
              .toList()
          : null
      ..acto = json['acto'] as String? ?? null
      ..procedePago = json['procedePago'] as bool? ?? false;
  } catch (e) {
    print(e);
    return DatosProforma();
  }
}

/*Map<String, dynamic> _$DatosProformaToJson(DatosProforma instance) =>
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
    };*/
