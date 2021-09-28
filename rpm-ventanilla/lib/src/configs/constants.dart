import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/ajustes/contrasenia_page.dart';
import 'package:playas/src/pages/ajustes/perfil_page.dart';
import 'package:playas/src/pages/busqueda/buscar-page.dart';
import 'package:playas/src/pages/ciudadania/carpeta_ciudadana_page.dart';
import 'package:playas/src/pages/ciudadania/mistramites_page.dart';
import 'package:playas/src/pages/ciudadania/repositorio_page.dart';
import 'package:playas/src/pages/nosotros/nosotros_page.dart';
import 'package:playas/src/pages/verificar/certificadomov_page.dart';
import 'package:playas/src/pages/verificar/certificadoweb_page.dart';
import 'package:playas/src/pages/verificar/verificar_doc_page.dart';

List<Menu> menus(isWeb) {
  return [
    Menu('Consultar trámites', BuscarPage.route, Colors.lightBlueAccent,
        Icons.search),
    Menu(
        'Validar\ndocumentos',
        isWeb ? CertificadoWebPage.route : CertificadoMovPage.route,
        Colors.red,
        Icons.qr_code),
    Menu('Validar\nfirma eléctronica', VerificarDocPage.route, Colors.purple,
        Icons.qr_code_scanner),
    Menu('Carpeta\nciudadana', CarpetaCiudadanaPage.route, Colors.tealAccent,
        Icons.qr_code),
    Menu('Ajustes', AjustesPage.route, Colors.blueGrey, Icons.settings),
  ];
}

List<Menu> menusConfiguraciones = [
  Menu('Perfil', PerfilPage.route, Colors.lightBlue, Icons.person),
  Menu('Cambiar contraseña', ContraseniaPage.route, Colors.purple,
      Icons.password),
  Menu('Sobre nosotros', NosotrosPage.route, Colors.red, Icons.food_bank),
  Menu('Cerrar sesión', '/cerrarSesion', Colors.tealAccent, Icons.logout),
];

List<Menu> menusCarpeta = [
  Menu('Mis trámites', MisTramitesPage.route, Colors.lightBlue,
      Icons.filter_list),
  Menu('Mis documentos', RepositorioPage.route, Colors.grey, Icons.filter_list),
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

List<Data> tiposBusqueda = [
  Data().initData(1, 'Certificados'),
  Data().initData(2, 'Inscripciones'),
];

String dominio = 'http://localhost:9090';

String language = 'es-ES';

String qrCertificate = '';

const kMobileBreakpoint = 576;
const kTabletBreakpoint = 1024;
const kDesktopBreakPoint = 1366;

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
