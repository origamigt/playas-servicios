import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/widgets/ajustes_card.dart';
import 'package:playas/src/widgets/page_component.dart';

class AjustesPage extends StatelessWidget {
  static const String route = '/ajustes';

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
        body: gridMenus(),
        footer: Container(),
      ),
    );
  }

  Widget title() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          'Ajustes',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 3,
          style: Theme.of(context!).textTheme.headline1,
        ));
  }

  Widget gridMenus() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: AjustesCard(
        menus: menusConfiguraciones,
      ),
    );
    ;
  }
}
