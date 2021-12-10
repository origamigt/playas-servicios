import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/ajustes/cerrar_sesion_page.dart';
import 'package:playas/src/pages/ajustes/contrasenia_page.dart';
import 'package:playas/src/pages/ajustes/perfil_page.dart';
import 'package:playas/src/pages/busqueda/buscar-page.dart';
import 'package:playas/src/pages/ciudadania/carpeta_ciudadana_page.dart';
import 'package:playas/src/pages/ciudadania/misfacturas_page.dart';
import 'package:playas/src/pages/ciudadania/mistramites_page.dart';
import 'package:playas/src/pages/ciudadania/repositorio_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/entidad_page.dart';
import 'package:playas/src/pages/login/recuperar_page.dart';
import 'package:playas/src/pages/login/registrarse_page.dart';
import 'package:playas/src/pages/nosotros/nosotros_page.dart';
import 'package:playas/src/pages/verificar/certificadomov_page.dart';
import 'package:playas/src/pages/verificar/certificadoweb_page.dart';
import 'package:playas/src/pages/verificar/verificar_doc_page.dart';
import 'package:playas/src/widgets/components.dart';

const String appName =
    'Registro Municipal de la Propiedad y Mercantil del Cantón de Playas';

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
  Menu(
      'Cerrar sesión', CerrarSesionPage.route, Colors.tealAccent, Icons.logout),
];

List<Menu> menusCarpeta = [
  Menu('Mis trámites', MisTramitesPage.route, Colors.lightBlue,
      Icons.filter_list),
  Menu('Mis facturas', MisFacturasPage.route, Colors.redAccent,
      Icons.attach_money),
  Menu('Mis documentos', RepositorioPage.route, Colors.grey, Icons.filter_list),
];

List<Menu> menusLogin = [
  Menu('Registrarse', RegistrarsePage.route, colorBandera1,
      Icons.person_add_alt_1),
  Menu('Recuperar contraseña', RecuperarPage.route, colorBandera2,
      Icons.admin_panel_settings_outlined),
  Menu('Ingresar como invitado', HomePage.route, colorBandera3,
      Icons.pets_rounded),
  Menu('Registrarse como entidad verificadora', EntidadPage.route, colorPrimary,
      Icons.apartment),
];

List<Data> motivosSolicitud = [
  Data().initData(25, 'Trámite Municipal'),
  Data().initData(26, 'Medidor de agua potable'),
  Data().initData(27, 'Compraventa'),
  Data().initData(31, 'Trámite Judicial'),
  Data().initData(32, 'Medidor de luz'),
  Data().initData(33, 'Solicitud certificado linderos'),
  Data().initData(41, 'Instuciones bancarias'),
  Data().initData(42, 'Trámite en notaria'),
  Data().initData(43, 'Donación'),
  Data().initData(44, 'Legalización de bien'),
  Data().initData(45, 'Para matricular'),
  Data().initData(46, 'Casas comerciales'),
  Data().initData(47, 'Instituciones Públicas'),
  Data().initData(48, 'Solicitud para certificado de avalúo'),
  Data().initData(-1, 'Otros'),
];

List<Data> motivosSolicitudNoBienes = [
  Data().initData(25, 'Trámite Municipal'),
  Data().initData(41, 'Instuciones bancarias'),
  Data().initData(47, 'Instituciones Públicas'),
  Data().initData(31, 'Trámite Judicial'),
  Data().initData(-1, 'Otros'),
];

List<Data> tiposBusqueda = [
  Data().initData(1, 'Certificados'),
  Data().initData(2, 'Inscripciones'),
];

String language = 'es-ES';

String qrCertificate = '';

const kMobileBreakpoint = 576;
const kTabletBreakpoint = 1024;
const kDesktopBreakPoint = 1366;

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}
