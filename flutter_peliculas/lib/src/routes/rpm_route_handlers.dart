import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/pages/tramites/tramites_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginPage();
});

var inicioHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return HomePage();
});

var ajustesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AjustesPage();
});

var tramitesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return TramitesPage();
});

var tramitesNoBienesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return NoposeerBienPage();
});
