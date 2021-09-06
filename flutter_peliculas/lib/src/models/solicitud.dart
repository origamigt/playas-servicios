import 'package:playas/src/models/acto_requisito.dart';

import 'user.dart';

part 'solicitud.g.dart';

class Solicitud {
  int? id;
  String? solTipoPersona;
  String? solTipoDoc;
  String? solApellidos;
  String? solNombres;
  String? solCedula;
  String? solProvincia; //DIRECCION
  String? solCiudad;
  String? solParroquia;

  //MANZANA
  String? solCalles;
  String? solNumeroCasa;
  String? solCelular;
  String? solConvencional;
  String? solCorreo;
  String? solEstadoCivil;
  int? fechaSolicitud;

//PROPIETARIO - 1ACTO
  int? tipoSolicitud;
  int? motivoSolicitud;
  String? otroMotivo;
  int? numeroFicha;
  String? tipoInmueble;

  String? propEstadoCivil;
  String? propTipoPersona;
  String? propTipoDoc;
  String? propCedula;
  String? propNombres;
  String? propApellidos;
  String? propConyugueCedula;
  String? propConyugueNombres;
  String? propConyugueApellidos;
  String? observacion;

  int? numInscripcion;
  int? anioInscripcion;
  String? claveCatastral;
  String? lote;

  //FACTURA
  String? benTipoPersona;
  String? benTipoDoc;
  String? benDocumento;
  String? benNombres;
  String? benApellidos;
  String? benDireccion;
  String? benTelefono;
  String? benCorreo;

  User? user;
  int? installmentsType;

  String? payFrameUrl;
  int? fechaEntrega;
  int? fechaIngreso;
  int? fechaInscripcion;
  int? numeroTramite;
  num? avance;
  String? message;
  String? image1;
  String? image2;
  String? image3;
  int? fechaSolicitudLong;
  int? fechaInscripcionLong;
  int? idUser;

  double? total;
  String? estado;

  bool? tipoPago; //TRUE: VENTANILLA FALSE: PAGO EN LINEA
  int? cantidad;

  String? acto;
  bool? ingresado; //TRUE: ingresado SGR FALSE: NOP

  String? linkPago;
  String? paymentId;
  String? payWithPayPhone;
  String? payWithApp;
  bool? procesando;

  List<ActoRequisito>? requisitos;

  Solicitud();

  Solicitud fromJson(Map<String, dynamic> json) => _$SolicitudFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitudToJson(this);

  Map<String, dynamic> json(Solicitud instance) => <String, dynamic>{
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
        'acto': instance.acto,
        'ingresado': instance.ingresado,
        'linkPago': instance.linkPago,
        'paymentId': instance.paymentId,
        'payWithPayPhone': instance.payWithPayPhone,
        'payWithApp': instance.payWithApp,
        'procesando': instance.procesando,
        'requisitos': instance.requisitos
      };
}
