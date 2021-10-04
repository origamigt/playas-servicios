import 'package:flutter/material.dart';

import 'desktop_mode.dart';
import 'mobile_mode.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/iniciarSesion';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return MobileMode(
            tipo: 'LOGIN',
          );
        } else {
          return DesktopMode(
            tipo: 'LOGIN',
          );
        }
      },
    );
  }
}
