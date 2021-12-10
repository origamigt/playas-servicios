import 'dart:core';

class Facturas {
  String? numAutorizacion;
  String? claveAcceso;
  String? numFacturaFormato;
  String? fechaAutorizacion;
  String? valorTotal;
  int? numTramite;

  //String urlRp;

  Facturas();

  Facturas fromJson(Map<String, dynamic> json) {
    return Facturas()
      ..numAutorizacion = json['numAutorizacion'] as String? ?? null
      ..claveAcceso = json['claveAcceso'] as String? ?? null
      ..numFacturaFormato = json['numFacturaFormato'] as String? ?? null
      ..fechaAutorizacion = json['fechaAutorizacion'] as String? ?? null
      ..numTramite = json['numTramite'] as int? ?? null
      ..valorTotal = json['valorTotal'] as String? ?? null;
  }
}
