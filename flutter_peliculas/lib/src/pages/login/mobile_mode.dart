import 'package:flutter/material.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/login_form.dart';
import 'package:playas/src/widgets/registro_form.dart';

class MobileMode extends StatelessWidget {
  final String? tipo;

  MobileMode({this.tipo});

  /*@override
  _MobileModeState createState() => _MobileModeState();
}

class _MobileModeState extends State<MobileMode> {*/
  double? widthSize;
  double? heightSize;

  @override
  Widget build(BuildContext context) {
    widthSize = MediaQuery.of(context).size.width;
    heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            height: heightSize,
            decoration: boxDecorationBG,
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Image.asset('assets/images/logo.png',
                  height: heightSize! * 0.3, width: widthSize! * 0.6),
              body()
            ]))));
  }

  Widget body() {
    if (tipo == 'LOGIN') {
      return LoginForm(0.007, 0.04, widthSize! * 0.04, 0.06, 0.04, 0.07,
          widthSize! * 0.09, 0.05, 0.032, 0.04, 0.032);
    }
    if (tipo == 'REGISTRARSE') {
      return RegistrarseForm(0.007, 0.04, widthSize! * 0.04, 0.06, 0.04, 0.07,
          widthSize! * 0.09, 0.05, 0.032, 0.04, 0.032);
    }
    if (tipo == 'ENVIO_MENSAJE') {}
    if (tipo == 'CLAVE') {}
    return Container();
  }
}
