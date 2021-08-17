import 'dart:core';

import 'pub-persona.dart';

class User {
  int? id;
  String? username;
  String? pass;
  bool? habilitado;
  PubPersona? persona;
  String? token;
  int? personaID;

  //String urlRp;

  User();

  User fromJson(Map<String, dynamic> json) {
    return User()
      ..id = json['id'] as int? ?? null
      ..username = json['username'] as String? ?? null
      ..habilitado = json['habilitado'] as bool? ?? null
      ..pass = json['pass'] as String? ?? null
      ..token = json['token'] as String? ?? null
      ..personaID = json['personaID'] as int? ?? null
      ..persona = json['persona'] == null
          ? null
          : PubPersona().fromJson(json['persona'] as Map<String, dynamic>);
  }


  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'pass': pass,
        'habilitado': habilitado,
        'persona': persona,
        'token': token,
        'personaID': personaID,
        //'urlRp': urlRp,
      };

  Map<String, dynamic> json(User instance) => <String, dynamic>{
        'id': instance.id,
        'username': instance.username,
        'pass': instance.pass,
        'habilitado': instance.habilitado,
        'persona': instance.persona != null
            ? PubPersona().json(instance.persona!)
            : null,
        'token': instance.token,
        'personaID': instance.personaID,
      };

  @override
  String toString() {
    return 'User{id: $id, username: $username, pass: $pass, habilitado: $habilitado, '
        'persona: $persona, token: $token, personaID: $personaID}';
  }
}
