import 'package:flutter/material.dart';
import 'package:playas/src/pages/login/mobile_mode.dart';

import 'desktop_mode.dart';

class EntidadPage extends StatelessWidget {
  static const String route = '/registrarEntidad';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return MobileMode(
            tipo: 'REGISTRAR_ENTIDAD',
          );
        } else {
          return DesktopMode(
            tipo: 'REGISTRAR_ENTIDAD',
          );
        }
      },
    );
  }
}
