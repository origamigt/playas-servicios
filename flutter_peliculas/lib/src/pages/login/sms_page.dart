import 'package:flutter/material.dart';

import 'desktop_mode.dart';
import 'mobile_mode.dart';

class SmsPage extends StatelessWidget {
  static const String route = '/codigoVerificacion';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return MobileMode(
            tipo: 'ENVIO_MENSAJE',
          );
        } else {
          return DesktopMode(
            tipo: 'ENVIO_MENSAJE',
          );
        }
      },
    );
  }
}
