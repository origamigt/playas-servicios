import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/pages/ajustes/cerrar_sesion_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/pages/verificar/certificadomov_page.dart';
import 'package:playas/src/pages/verificar/certificadoweb_page.dart';
import 'package:playas/src/pages/verificar/verificar_doc_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Color colorPrimary = Color(0xFF2D2E74);
Color colorSecond = Color(0xFF189247);

Color colorBandera1 = Color(0xFFFEF200);
Color colorBandera2 = Color(0xFFF8821E);
Color colorBandera3 = Color(0XFF70C047);

BoxDecoration boxDecorationBG = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/images/background.jpg"),
    fit: BoxFit.cover,
  ),
);

BoxDecoration boxDecorationLogin = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      colors: [
        Color(0xFFFEF200).withOpacity(0.75),
        Color(0xFFF8821E).withOpacity(0.75),
        Color(0XFF70C047).withOpacity(0.75)
      ],
      stops: [0.46, 0.55, 0.7],
      begin: Alignment(-1.0, -2.0),
      end: Alignment(1.0, 2.0),
    ));

Widget playasBG(heightSize, widthSize) {
  return Expanded(
      flex: 1,
      child: Container(
          child: Align(
        alignment: Alignment.center,
        child: Image.asset('assets/images/logo_2.jpg',
            height: heightSize * 0.5,
            width: widthSize * 0.5,
            semanticLabel: 'test'),
      )));
}

BoxDecoration boxDecorationPlayasBG = BoxDecoration(
  image: DecorationImage(
      image: AssetImage(
        "assets/images/logo.png",
      ),
      scale: 6,
      colorFilter:
          ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
      alignment: Alignment.topLeft),
);

Widget menuCard(BuildContext context, Menu menu, bool isWeb, bool auth) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    width: 122,
    height: 160,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      boxShadow: [
        BoxShadow(
            color: menu.color.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(2, 3))
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () {
          if (menu.route == CertificadoWebPage.route ||
              menu.route == CertificadoMovPage.route ||
              menu.route == VerificarDocPage.route ||
              menu.route == LoginPage.route) {
            context.router.navigateNamed(menu.route);
          } else if (auth) {
            if (menu.route != CerrarSesionPage.route) {
              context.router.navigateNamed(menu.route);
            } else {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      CerrarSesionPage()));
            }
          } else {
            mensajeError(context, 'Debe iniciar sesion para continuar');
          }
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Icon(
                  menu.iconData,
                  size: 25,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                menu.descripcion,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

mensajeError(BuildContext context, String mensaje) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      message: mensaje,
    ),
  );
}

mensajeInfo(BuildContext context, String mensaje) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      message: mensaje,
    ),
  );
}

Widget loading(String txt) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      SizedBox(
        width: 5,
      ),
      Text(txt)
    ],
  );
}

Widget datosWidget(BuildContext? context, String txt, Widget child) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          txt,
          style: Theme.of(context!).textTheme.headline5,
        ),
        child
      ],
    ),
  );
}

Widget tituloWidget(BuildContext? context, String txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Text(
      txt,
      style: Theme.of(context!).textTheme.headline1,
    ),
  );
}

Widget tituloWidget2(BuildContext? context, String txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Text(
      txt,
      style: Theme.of(context!).textTheme.headline4,
    ),
  );
}

Widget subTituloWidget(BuildContext? context, String txt) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Text(
      txt,
      style: Theme.of(context!).textTheme.headline2,
    ),
  );
}

Widget subTituloWidget2(BuildContext? context, String txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Text(
      txt,
      style: Theme.of(context!).textTheme.headline2,
    ),
  );
}

Widget tituloPagina(BuildContext? context, String txt, bool isWeb) {
  return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        txt,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        softWrap: true,
        maxLines: 3,
        style: isWeb
            ? Theme.of(context!).textTheme.headline1
            : Theme.of(context!).textTheme.headline4,
      ));
}

RoundedRectangleBorder borderDialog = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)));

Widget cargando() {
  return Container(
      alignment: Alignment.center,
      height: 60,
      child: CircularProgressIndicator());
}

Widget terminosCondicionesHTML(BuildContext context, String? termsConditions) {
  return AlertDialog(
    shape: borderDialog,
    content: Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 1.5,
      child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Html(
              data: termsConditions,
            ),
          )),
    ),
    actions: <Widget>[
      TextButton(
        child: Text("Aceptar"),
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      ),
    ],
  );
}
