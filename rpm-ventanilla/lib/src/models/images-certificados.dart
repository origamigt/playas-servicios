class ImagenesCertificados {
  String? urlImage;

  ImagenesCertificados fromJson(Map<String, dynamic> json) {
    return ImagenesCertificados()
      ..urlImage = json['urlImage'] as String? ?? null;
  }

  Map toJson() {
    return {'urlImage': urlImage};
  }
}
