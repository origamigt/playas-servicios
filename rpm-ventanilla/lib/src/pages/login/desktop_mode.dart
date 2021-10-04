import 'package:flutter/material.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/entidad_form.dart';
import 'package:playas/src/widgets/login_form.dart';
import 'package:playas/src/widgets/recuperar_form.dart';
import 'package:playas/src/widgets/registro_form.dart';

class DesktopMode extends StatelessWidget {
  String? tipo;

  DesktopMode({this.tipo});

  double? widthSize;
  double? heightSize;

  @override
  Widget build(BuildContext context) {
    widthSize = MediaQuery.of(context).size.width;
    heightSize = MediaQuery.of(context).size.height;

    return Container(
        decoration: boxDecorationBG,
        child: Center(
            child: Container(
                height: heightSize! * 0.70,
                width: widthSize! * 0.70,
                child: Card(
                    elevation: 2,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                  color: colorBandera1,
                                  width: 6,
                                ),
                                bottom: BorderSide(
                                  color: colorBandera2,
                                  width: 6,
                                ),
                                right: BorderSide(
                                  color: colorBandera3,
                                  width: 6,
                                ))),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              playasBG(heightSize, widthSize),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      //decoration: boxDecorationLogin,
                                      child: SingleChildScrollView(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              leftBody(),
                                              SizedBox(height: 20),
                                              body()
                                            ]),
                                      )))
                            ]),
                      ),
                    )))));
  }

  Widget leftBody() {
    return Image.asset('assets/images/logo.png',
        height: heightSize! * 0.12, width: widthSize! * 0.15);
  }

  Widget body() {
    if (tipo == 'LOGIN') {
      return LoginForm(
          0, 0.009, 18, 0.04, 0.01, 0.03, 75, 0.01, 0.009, 0.01, 0.006);
    }
    if (tipo == 'REGISTRARSE') {
      return RegistrarseForm(
          0, 0.009, 18, 0.04, 0.01, 0.03, 75, 0.01, 0.009, 0.01, 0.006);
    }
    if (tipo == 'REGISTRAR_ENTIDAD') {
      return EntidadForm(
          0, 0.009, 18, 0.04, 0.01, 0.03, 75, 0.01, 0.009, 0.01, 0.006);
    }
    if (tipo == 'RECUPERAR') {
      return RecuperarForm(
          0, 0.009, 18, 0.04, 0.01, 0.03, 75, 0.01, 0.009, 0.01, 0.006);
    }
    if (tipo == 'CLAVE') {}
    return Container();
  }
}
