import 'package:flutter/material.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/ajustes/contrasenia_page.dart';
import 'package:playas/src/pages/ajustes/perfil_page.dart';
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
  Menu('Perfil', PerfilPage.route, Colors.lightBlue, Icons.person),
  Menu('Cambiar contraseña', ContraseniaPage.route, Colors.purple,
      Icons.password),
  Menu('Sobre nosotros', ScanQrpage().route, Colors.red, Icons.food_bank),
  Menu('Cerrar sesión', '/cerrarSesion', Colors.tealAccent, Icons.logout),
];

List<Data> motivosSolicitud = [
  Data().initData(100, 'Demanda'),
  Data().initData(101, 'Garantía'),
  Data().initData(102, 'Donación'),
  Data().initData(103, 'Embargo'),
  Data().initData(104, 'Hipoteca'),
  Data().initData(105, 'Prohibición'),
  Data().initData(106, 'CompraVenta'),
  Data().initData(107, 'Interdicción'),
  Data().initData(108, 'Trámite municipal'),
  Data().initData(109, 'Trámite personal'),
  Data().initData(110, 'Trámite judicial'),
  Data().initData(111, 'Juicio de alimentos'),
  Data().initData(112, 'Partición extrajudicial'),
  Data().initData(113, 'Línea de fábrica'),
  Data().initData(114, 'Permiso de construcción'),
  Data().initData(115, 'Informe de nueva linderación'),
  Data().initData(116, 'Otros'),
];

String language = 'es-ES';

String qrCertificate = '';

const kMobileBreakpoint = 576;
const kTabletBreakpoint = 1024;
const kDesktopBreakPoint = 1366;
