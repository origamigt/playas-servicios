// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Solicitud _$SolicitudFromJson(Map<String, dynamic> json) {
  return Solicitud()
    ..id = json['id'] as int? ?? null
    ..solTipoPersona = json['solTipoPersona'] as String? ?? null
    ..solTipoDoc = json['solTipoDoc'] as String? ?? null
    ..solApellidos = json['solApellidos'] as String? ?? null
    ..solNombres = json['solNombres'] as String? ?? null
    ..solCedula = json['solCedula'] as String? ?? null
    ..solProvincia = json['solProvincia'] as String? ?? null
    ..solCiudad = json['solCiudad'] as String? ?? null
    ..solParroquia = json['solParroquia'] as String? ?? null
    ..solCalles = json['solCalles'] as String? ?? null
    ..solNumeroCasa = json['solNumeroCasa'] as String? ?? null
    ..solCelular = json['solCelular'] as String? ?? null
    ..solConvencional = json['solConvencional'] as String? ?? null
    ..solCorreo = json['solCorreo'] as String? ?? null
    ..solEstadoCivil = json['solEstadoCivil'] as String? ?? null
    ..fechaSolicitud = json['fechaSolicitud'] as int? ?? null
    ..tipoSolicitud = json['tipoSolicitud'] as int? ?? null
    ..motivoSolicitud = json['motivoSolicitud'] as int? ?? null
    ..otroMotivo = json['otroMotivo'] as String? ?? null
    ..numeroFicha = json['numeroFicha'] as int? ?? null
    ..tipoInmueble = json['tipoInmueble'] as String? ?? null
    ..propEstadoCivil = json['propEstadoCivil'] as String? ?? null
    ..propTipoPersona = json['propTipoPersona'] as String? ?? null
    ..propTipoDoc = json['propTipoDoc'] as String? ?? null
    ..propCedula = json['propCedula'] as String? ?? null
    ..propNombres = json['propNombres'] as String? ?? null
    ..propApellidos = json['propApellidos'] as String? ?? null
    ..propConyugueCedula = json['propConyugueCedula'] as String? ?? null
    ..propConyugueNombres = json['propConyugueNombres'] as String? ?? null
    ..propConyugueApellidos = json['propConyugueApellidos'] as String? ?? null
    ..observacion = json['observacion'] as String? ?? null
    ..numInscripcion = json['numInscripcion'] as int? ?? null
    ..anioInscripcion = json['anioInscripcion'] as int? ?? null
    ..claveCatastral = json['claveCatastral'] as String? ?? null
    ..lote = json['lote'] as String? ?? null
    ..benTipoPersona = json['benTipoPersona'] as String? ?? null
    ..benTipoDoc = json['benTipoDoc'] as String? ?? null
    ..benDocumento = json['benDocumento'] as String? ?? null
    ..benNombres = json['benNombres'] as String? ?? null
    ..benApellidos = json['benApellidos'] as String? ?? null
    ..benDireccion = json['benDireccion'] as String? ?? null
    ..benTelefono = json['benTelefono'] as String? ?? null
    ..benCorreo = json['benCorreo'] as String? ?? null
    ..user = json['user'] == null
        ? null
        : User().fromJson(json['user'] as Map<String, dynamic>)
    ..installmentsType = json['installmentsType'] as int? ?? null
    ..payFrameUrl = json['payFrameUrl'] as String? ?? null
    ..fechaEntrega = json['fechaEntrega'] as int? ?? null
    ..fechaIngreso = json['fechaIngreso'] as int? ?? null
    ..fechaInscripcion = json['fechaInscripcion'] as int? ?? null
    ..numeroTramite = json['numeroTramite'] as int? ?? null
    ..avance = json['avance'] as num? ?? null
    ..message = json['message'] as String? ?? null
    ..image1 = json['image1'] as String? ?? null
    ..image2 = json['image2'] as String? ?? null
    ..image3 = json['image3'] as String? ?? null
    ..fechaSolicitudLong = json['fechaSolicitudLong'] as int? ?? null
    ..fechaInscripcionLong = json['fechaInscripcionLong'] as int? ?? null
    ..idUser = json['idUser'] as int? ?? null
    ..total = json['total'] as double? ?? null
    ..estado = json['estado'] as String? ?? null
    ..tipoPago = json['tipoPago'] as bool? ?? null
    ..cantidad = json['cantidad'] as int? ?? null
    ..anioUltimaTransferencia = json['anioUltimaTransferencia'] as int? ?? null
    ..anioAntecedenteSolicitado =
        json['anioAntecedenteSolicitado'] as int? ?? null
    ..acto = json['acto'] as String? ?? null
    ..ingresado = json['ingresado'] as bool? ?? null
    ..linkPago = json['linkPago'] as String? ?? null
    ..paymentId = json['paymentId'] as String? ?? null
    ..payWithPayPhone = json['payWithPayPhone'] as String? ?? null
    ..payWithApp = json['payWithApp'] as String? ?? null
    ..procesando = json['procesando'] as bool? ?? false;
}

Map<String, dynamic> _$SolicitudToJson(Solicitud instance) => <String, dynamic>{
      'id': instance.id,
      'solTipoPersona': instance.solTipoPersona,
      'solTipoDoc': instance.solTipoDoc,
      'solApellidos': instance.solApellidos,
      'solNombres': instance.solNombres,
      'solCedula': instance.solCedula,
      'solProvincia': instance.solProvincia,
      'solCiudad': instance.solCiudad,
      'solParroquia': instance.solParroquia,
      'solCalles': instance.solCalles,
      'solNumeroCasa': instance.solNumeroCasa,
      'solCelular': instance.solCelular,
      'solConvencional': instance.solConvencional,
      'solCorreo': instance.solCorreo,
      'solEstadoCivil': instance.solEstadoCivil,
      'fechaSolicitud': instance.fechaSolicitud,
      'tipoSolicitud': instance.tipoSolicitud,
      'motivoSolicitud': instance.motivoSolicitud,
      'otroMotivo': instance.otroMotivo,
      'numeroFicha': instance.numeroFicha,
      'tipoInmueble': instance.tipoInmueble,
      'propEstadoCivil': instance.propEstadoCivil,
      'propTipoPersona': instance.propTipoPersona,
      'propTipoDoc': instance.propTipoDoc,
      'propCedula': instance.propCedula,
      'propNombres': instance.propNombres,
      'propApellidos': instance.propApellidos,
      'propConyugueCedula': instance.propConyugueCedula,
      'propConyugueNombres': instance.propConyugueNombres,
      'propConyugueApellidos': instance.propConyugueApellidos,
      'observacion': instance.observacion,
      'numInscripcion': instance.numInscripcion,
      'anioInscripcion': instance.anioInscripcion,
      'claveCatastral': instance.claveCatastral,
      'lote': instance.lote,
      'benTipoPersona': instance.benTipoPersona,
      'benTipoDoc': instance.benTipoDoc,
      'benDocumento': instance.benDocumento,
      'benNombres': instance.benNombres,
      'benApellidos': instance.benApellidos,
      'benDireccion': instance.benDireccion,
      'benTelefono': instance.benTelefono,
      'benCorreo': instance.benCorreo,
      'user': instance.user,
      'installmentsType': instance.installmentsType,
      'payFrameUrl': instance.payFrameUrl,
      'fechaEntrega': instance.fechaEntrega,
      'fechaIngreso': instance.fechaIngreso,
      'fechaInscripcion': instance.fechaInscripcion,
      'numeroTramite': instance.numeroTramite,
      'avance': instance.avance,
      'message': instance.message,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'fechaSolicitudLong': instance.fechaSolicitudLong,
      'fechaInscripcionLong': instance.fechaInscripcionLong,
      'idUser': instance.idUser,
      'total': instance.total,
      'estado': instance.estado,
      'tipoPago': instance.tipoPago,
      'cantidad': instance.cantidad,
      'anioUltimaTransferencia': instance.anioUltimaTransferencia,
      'anioAntecedenteSolicitado': instance.anioAntecedenteSolicitado,
      'acto': instance.acto,
      'ingresado': instance.ingresado,
      'linkPago': instance.linkPago,
      'paymentId': instance.paymentId,
      'payWithPayPhone': instance.payWithPayPhone,
      'payWithApp': instance.payWithApp,
      'procesando': instance.procesando,
    };
