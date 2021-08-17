// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pub-solicitud.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubSolicitud _$PubSolicitudFromJson(Map<String, dynamic> json) {
  return PubSolicitud()
    ..id = json['id'] as int
    ..solTipoPersona = json['solTipoPersona'] as String
    ..solTipoDoc = json['solTipoDoc'] as String
    ..solApellidos = json['solApellidos'] as String
    ..solNombres = json['solNombres'] as String
    ..solCedula = json['solCedula'] as String
    ..solProvincia = json['solProvincia'] as String
    ..solCiudad = json['solCiudad'] as String
    ..solParroquia = json['solParroquia'] as String
    ..solCalles = json['solCalles'] as String
    ..solNumeroCasa = json['solNumeroCasa'] as String
    ..solCelular = json['solCelular'] as String
    ..solConvencional = json['solConvencional'] as String
    ..solCorreo = json['solCorreo'] as String
    ..solEstadoCivil = json['solEstadoCivil'] as String
    ..fechaSolicitud = json['fechaSolicitud'] as int
    ..tipoSolicitud = json['tipoSolicitud'] as int
    ..motivoSolicitud = json['motivoSolicitud'] as int
    ..otroMotivo = json['otroMotivo'] as String
    ..numeroFicha = json['numeroFicha'] as int
    ..tipoInmueble = json['tipoInmueble'] as String
    ..propEstadoCivil = json['propEstadoCivil'] as String
    ..propTipoPersona = json['propTipoPersona'] as String
    ..propTipoDoc = json['propTipoDoc'] as String
    ..propCedula = json['propCedula'] as String
    ..propNombres = json['propNombres'] as String
    ..propApellidos = json['propApellidos'] as String
    ..propConyugueCedula = json['propConyugueCedula'] as String
    ..propConyugueNombres = json['propConyugueNombres'] as String
    ..propConyugueApellidos = json['propConyugueApellidos'] as String
    ..observacion = json['observacion'] as String
    ..numInscripcion = json['numInscripcion'] as int
    ..anioInscripcion = json['anioInscripcion'] as int
    ..claveCatastral = json['claveCatastral'] as String
    ..lote = json['lote'] as String
    ..benTipoPersona = json['benTipoPersona'] as String
    ..benTipoDoc = json['benTipoDoc'] as String
    ..benDocumento = json['benDocumento'] as String
    ..benNombres = json['benNombres'] as String
    ..benApellidos = json['benApellidos'] as String
    ..benDireccion = json['benDireccion'] as String
    ..benTelefono = json['benTelefono'] as String
    ..benCorreo = json['benCorreo'] as String
    ..user = json['user'] == null
        ? null
        : User().fromJson(json['user'] as Map<String, dynamic>)
    ..installmentsType = json['installmentsType'] as int
    ..payFrameUrl = json['payFrameUrl'] as String
    ..fechaEntrega = json['fechaEntrega'] as int
    ..fechaIngreso = json['fechaIngreso'] as int
    ..fechaInscripcion = json['fechaInscripcion'] as int
    ..numeroTramite = json['numeroTramite'] as int
    ..avance = json['avance'] as num
    ..message = json['message'] as String
    ..image1 = json['image1'] as String
    ..image2 = json['image2'] as String
    ..image3 = json['image3'] as String
    ..fechaSolicitudLong = json['fechaSolicitudLong'] as int
    ..fechaInscripcionLong = json['fechaInscripcionLong'] as int
    ..idUser = json['idUser'] as int
    ..total = json['total'] as double
    ..estado = json['estado'] as String
    ..tipoPago = json['tipoPago'] as bool
    ..cantidad = json['cantidad'] as int
    ..anioUltimaTransferencia = json['anioUltimaTransferencia'] as int
    ..anioAntecedenteSolicitado = json['anioAntecedenteSolicitado'] as int
    ..acto = json['acto'] as String
    ..ingresado = json['ingresado'] as bool;
}

Map<String, dynamic> _$PubSolicitudToJson(PubSolicitud instance) =>
    <String, dynamic>{
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
      'ingresado': instance.ingresado
    };
