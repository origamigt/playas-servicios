import 'package:playas/src/models/certificado.dart';

class Documento {
  bool? firmaValida; //validez de todas las firmas
  bool? documentoValido; //validez de todo el documento
  List<Certificado>?
      certificados; //si la lista de certificados se encuentra en null, el documento no contiene firmas
  String? error;

  Documento fromJson(Map<String, dynamic> json) {
    return Documento()
      ..documentoValido = json['documentoValido'] as bool? ?? null
      ..firmaValida = json['firmaValida'] as bool? ?? null
      ..certificados = (json['certificados'] as List)
          .map((e) => e == null
              ? null
              : Certificado().fromJson(e as Map<String, dynamic>))
          .cast<Certificado>()
          .toList()
      ..error = json['error'] as String? ?? null;
  }
}
