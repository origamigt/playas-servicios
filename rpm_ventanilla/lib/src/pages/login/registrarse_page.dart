import 'package:flutter/material.dart';
import 'package:playas/src/pages/login/mobile_mode.dart';

import 'desktop_mode.dart';

class RegistrarsePage extends StatelessWidget {
  static const String route = '/registrarse';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return MobileMode(
            tipo: 'REGISTRARSE',
          );
        } else {
          return DesktopMode(
            tipo: 'REGISTRARSE',
          );
        }
      },
    );
  }
}
