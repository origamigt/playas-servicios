import 'package:playas/src/models/datos_usuario.dart';

class Certificado {
  String? informacionFirmante; //DInformación del firmante
  String?
      informacionEntidadCertificadora; //Información de la entidad certificadora
  DateTime? validoDesde; //certificado digital válido desde
  DateTime? validoHasta; //certificado digital válido hasta
  DateTime? generado; //fecha de firmar del documento
  DateTime? revocado; //fecha de revocado del certificado digital
  bool? validado; //validación del certificado en las fecha de vigencia
  String? clavesUso; //llaves de uso
  DatosUsuario? datosUsuario;
  bool? firmaVerificada; //Integridad Firma
  DateTime? docTimeStamp; //Estampa de tiempo
  String? motivoDocumento; //Razón del documento
  String? localizacionDocumento; //Localización del documento

  Certificado fromJson(Map<String, dynamic> json) {
    return Certificado()
      ..informacionFirmante = json['informacionFirmante'] as String? ?? null
      ..informacionEntidadCertificadora =
          json['informacionEntidadCertificadora'] as String? ?? null
      ..validoDesde = json['validoDesde'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['validoDesde'] as int)
      ..validoHasta = json['validoHasta'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['validoHasta'] as int)
      ..generado = json['generado'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['generado'] as int)
      ..revocado = json['revocado'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['revocado'] as int)
      ..validado = json['validado'] as bool? ?? null
      ..clavesUso = json['clavesUso'] as String? ?? null
      ..datosUsuario = json['datosUsuario'] == null
          ? null
          : DatosUsuario()
              .fromJson(json['datosUsuario'] as Map<String, dynamic>)
      ..firmaVerificada = json['firmaVerificada'] as bool? ?? null
      ..docTimeStamp = json['docTimeStamp'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['docTimeStamp'] as int)
      ..motivoDocumento = json['motivoDocumento'] as String? ?? null
      ..localizacionDocumento =
          json['localizacionDocumento'] as String? ?? null;
  }
}
