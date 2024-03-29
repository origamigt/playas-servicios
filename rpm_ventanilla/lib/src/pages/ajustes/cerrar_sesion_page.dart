import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class CerrarSesionPage extends StatelessWidget {
  bool isWeb = UniversalPlatform.isWeb;
  static const String route = '/cerrarSesion';
  UsuarioProvider? userProvider;
  AuthProvider? authProvider;
  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    userProvider = Provider.of<UsuarioProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white.withOpacity(0.96),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.topRight,
              child: IconButton(
                color: colorPrimary,
                icon: Icon(
                  Icons.close,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(context, 'CLOSE');
                },
              ),
            ),
            tituloPagina(context, 'Cerrar sesión', isWeb),
            SizedBox(
              height: 10,
            ),
            btnCerrarSesion()
          ],
        ),
      ),
    );
  }

  Widget btnCerrarSesion() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: new Text("Cerrar Sesión"),
      content: new Text("Esta seguro?"),
      actions: <Widget>[
        TextButton(
          child: new Text("SI"),
          onPressed: () async {
            userProvider!.cerrarSesion();
            authProvider!.setAuthState(Status.NotLoggedIn);
            context!.router.navigateNamed(HomePage.route);
          },
        ),
        // usually buttons at the bottom of the dialog
        TextButton(
          child: new Text("NO"),
          onPressed: () {
            Navigator.of(context!).pop();
          },
        ),
      ],
    );
  }
}
