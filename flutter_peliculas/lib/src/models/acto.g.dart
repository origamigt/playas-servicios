part of 'acto.dart';

Map<String, dynamic> _$ActoToJson(Acto instance) => <String, dynamic>{
      'id': instance.id,
      'acto': instance.acto,
      'descripcion': instance.descripcion,
      'urlImage': instance.urlImage,
      'orden': instance.orden,
      'valor': instance.valor,
      'certificadoNoPoseerBien': instance.certificadoNoPoseerBien,
      'valorTemp': instance.valorTemp
    };
