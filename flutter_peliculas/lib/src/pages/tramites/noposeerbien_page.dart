import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/widgets/page_component.dart';

class NoposeerBienPage extends StatelessWidget {
  static const String route = '/noposeerbien';

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 0,
      ),
      body: PageComponent(
        header: title(),
        body: body(),
        footer: Container(),
      ),
    );
  }

  Widget title() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          'Certificado de no poseer bienes',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 3,
          style: Theme.of(context!).textTheme.headline1,
        ));
  }

  Widget body() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context!).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Datos del solicitante'),
                Text('Datos de la factura'),
                Text('Motivo de la solicitud')
              ],
            ),
          ),
        ));
    ;
  }
}
