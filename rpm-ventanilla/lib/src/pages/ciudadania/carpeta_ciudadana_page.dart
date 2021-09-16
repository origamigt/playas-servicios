import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/widgets/ajustes_card.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';

class CarpetaCiudadanaPage extends StatelessWidget {
  static const String route = '/carpetaCiudadana';

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 0,
      ),
      body: PageComponent(
        header: tituloPagina(context, 'Carpeta ciudadana'),
        body: gridMenus(),
        footer: Container(),
      ),
    );
  }

  Widget gridMenus() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: AjustesCard(
        menus: menusCarpeta,
      ),
    );
    ;
  }
}
