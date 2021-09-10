import 'dart:core';

import 'persona.dart';

class User {
  int? id;
  String? usuario;
  String? clave;
  bool? habilitado;
  PubPersona? persona;
  String? token;
  int? personaID;

  //String urlRp;

  User();

  User fromJson(Map<String, dynamic> json) {
    return User()
      ..id = json['id'] as int? ?? null
      ..usuario = json['usuario'] as String? ?? null
      ..habilitado = json['habilitado'] as bool? ?? null
      ..clave = json['clave'] as String? ?? null
      ..token = json['token'] as String? ?? null
      ..personaID = json['personaID'] as int? ?? null
      ..persona = json['persona'] == null
          ? null
          : PubPersona().fromJson(json['persona'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'usuario': usuario,
        'clave': clave,
        'habilitado': habilitado,
        'persona': persona,
        'token': token,
        'personaID': personaID,
        //'urlRp': urlRp,
      };

  Map<String, dynamic> json(User instance) => <String, dynamic>{
        'id': instance.id,
        'usuario': instance.usuario,
        'clave': instance.clave,
        'habilitado': instance.habilitado,
        'persona': instance.persona != null
            ? PubPersona().json(instance.persona!)
            : null,
        'token': instance.token,
        'personaID': instance.personaID,
      };

  @override
  String toString() {
    return 'User{id: $id, usuario: $usuario, clave: $clave, habilitado: $habilitado, '
        'persona: $persona, token: $token, personaID: $personaID}';
  }
}
