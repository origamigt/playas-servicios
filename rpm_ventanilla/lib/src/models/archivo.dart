import 'dart:typed_data';

class Archivo {
  String? nombre;
  Uint8List? multipartFile;

  Archivo();

  Archivo fromJson(Map<String, dynamic> json) {
    return Archivo()..nombre = json['nombre'] as String? ?? null;
  }

  Map<String, dynamic> toJson(Archivo instance) => <String, dynamic>{
        'nombre': instance.nombre,
        'multipartFile': instance.multipartFile,
      };

  @override
  String toString() {
    return 'Archivo{nombre: $nombre, multipartFile: $multipartFile}';
  }
}
