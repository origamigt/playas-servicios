import 'package:flutter/material.dart';
import 'package:playas/src/widgets/components.dart';

class CerrarSesionPage extends StatelessWidget {
  String route = '/cerrarSesion';

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
            tituloPagina(context, 'Cerrar sesión'),
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
            /*if (await signOut()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }*/
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
