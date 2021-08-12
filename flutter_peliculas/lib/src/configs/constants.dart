import 'package:flutter/material.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/tramites/tramites_page.dart';
import 'package:playas/src/pages/validar/scan-qr-page.dart';

List<Menu> menus = [
  Menu('Mis trámites', '/', Colors.lightBlue, Icons.filter_list),
  Menu('Servicios en linea', TramitesPage.route, Colors.purple, Icons.search),
  Menu('Validar documentos', ScanQrpage().route, Colors.red, Icons.qr_code),
  Menu('Carpeta ciudadana', ScanQrpage().route, Colors.tealAccent,
      Icons.qr_code),
  Menu('Ajustes', AjustesPage.route, Colors.blueGrey, Icons.settings),
];

List<Menu> menusConfiguraciones = [
  Menu('Perfil', '/perfil', Colors.lightBlue, Icons.person),
  Menu('Cambiar contraseña', TramitesPage.route, Colors.purple, Icons.password),
  Menu('Sobre nosotros', ScanQrpage().route, Colors.red, Icons.food_bank),
  Menu('Cerrar sesión', ScanQrpage().route, Colors.tealAccent, Icons.logout),
];

String SERVER_IP = '@127.0.0.1:8085';

String language = 'es-ES';

String qrCertificate = '';

const kMobileBreakpoint = 576;
const kTabletBreakpoint = 1024;
const kDesktopBreakPoint = 1366;
