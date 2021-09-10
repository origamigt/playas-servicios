// Extend VRouteElementBuilder to create your own VRouteElement
import 'package:flutter/material.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/pages/login/registrarse_page.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/pages/tramites/tramites_page.dart';
import 'package:vrouter/vrouter.dart';

class ConnectedRoutes extends VRouteElementBuilder {
  static String root = LoginPage.route;
  static String registrarse = RegistrarsePage.route;
  static String inicio = HomePage.route;
  static String ajustes = AjustesPage.route;
  static String tramites = TramitesPage.route;
  static String tramitesNoBienes = NoposeerBienPage.route;

  static void toRegistrarse(BuildContext? context) =>
      context!.vRouter.to('/$registrarse');

  static void toInicio(BuildContext context) {
    try {
      print('$inicio');
      context.vRouter.to('/$inicio');
    } catch (e) {
      print(e);
    }
  }

  static void to(BuildContext context, String route) {
    try {
      context.vRouter.to('/$route');
    } catch (e) {
      print(e);
    }
  }

  static void toAjustes(BuildContext context) =>
      context.vRouter.to('/$ajustes');

  static void toTramites(BuildContext context) =>
      context.vRouter.to('/$tramites');

  static void toTramitesNoBienes(BuildContext context) =>
      context.vRouter.to('/$tramitesNoBienes');

  @override
  List<VRouteElement> buildRoutes() {
    return [
      VNester.builder(
        // .builder constructor gives you easy access to VRouter data
        path: '/', // :username is a path parameter and can be any value
        widgetBuilder: (_, state, child) => Container(),
        nestedRoutes: [
          VWidget(
            path: inicio,
            name: inicio,
            widget: HomePage(),
          ),
          VWidget(
            path: ajustes,
            name: ajustes,
            widget: AjustesPage(),
          ),
          VWidget(
            path: tramites,
            name: tramites,
            widget: TramitesPage(),
          ),
          VWidget(
            path: tramitesNoBienes,
            name: tramitesNoBienes,
            widget: NoposeerBienPage(),
          ),
        ],
      ),
    ];
  }
}
