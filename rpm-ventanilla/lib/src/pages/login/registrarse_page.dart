import 'package:flutter/material.dart';

import 'desktop_mode.dart';
import 'mobile_mode.dart';

class RegistrarsePage extends StatelessWidget {
  static const String route = '/registrarse';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return MobileMode(
            tipo: 'REGISTRO',
          );
        } else {
          return DesktopMode(
            tipo: 'REGISTRO',
          );
        }
      },
    );
  }
}
