
import 'user.dart';

part 'pub-solicitud.g.dart';

class PubSolicitud {
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
  int? anioUltimaTransferencia;
  int? anioAntecedenteSolicitado;

  String? acto;
  bool? ingresado; //TRUE: ingresado SGR FALSE: NOP

  PubSolicitud();

  factory PubSolicitud.fromJson(Map<String, dynamic> json) =>
      _$PubSolicitudFromJson(json);

  Map<String, dynamic> toJson() => _$PubSolicitudToJson(this);
}
