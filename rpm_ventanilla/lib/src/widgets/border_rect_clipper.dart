import 'package:flutter/material.dart';

class BorderRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // First rectangle, to be transformed
    var path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width / 2,
          height: size.height / 2));

    // Transform matrix
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.0005)
      ..rotateX(-0.9);
    path = path.transform(matrix.storage);

    // Outer rectangle, straight
    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    // Return path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
