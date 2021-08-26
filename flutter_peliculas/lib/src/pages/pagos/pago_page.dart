import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class PagoPage extends StatelessWidget {
  static const String route = '/confirmarPago';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.vRouter.url,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
