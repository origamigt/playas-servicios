class ImagesCertificados {
  String urlImage;

  ImagesCertificados.fromJson(Map json)
      : urlImage = json['urlImage'];

  Map toJson() {
    return {'urlImage': urlImage};
  }

}
