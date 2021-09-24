import 'package:flutter/material.dart';
import 'package:playas/src/pages/login/mobile_mode.dart';

import 'desktop_mode.dart';

class RecuperarPage extends StatelessWidget {
  static const String route = '/recuperar';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return MobileMode(
            tipo: 'RECUPERAR',
          );
        } else {
          return DesktopMode(
            tipo: 'RECUPERAR',
          );
        }
      },
    );
  }
}
