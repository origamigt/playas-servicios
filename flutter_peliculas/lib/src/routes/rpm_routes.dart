import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/pages/tramites/tramites_page.dart';
import 'package:playas/src/routes/rpm_route_handlers.dart';

class RpmRoutes {
  static String root = LoginPage.route;
  static String inicio = HomePage.route;
  static String ajustes = AjustesPage.route;
  static String tramites = TramitesPage.route;
  static String tramitesNoBienes = NoposeerBienPage.route;

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(root, handler: rootHandler);
    router.define(inicio, handler: inicioHandler);
    router.define(ajustes, handler: ajustesHandler);
    router.define(tramites,
        handler: tramitesHandler, transitionType: TransitionType.inFromLeft);
    router.define(tramitesNoBienes,
        handler: tramitesNoBienesHandler,
        transitionType: TransitionType.inFromLeft);
  }
}
