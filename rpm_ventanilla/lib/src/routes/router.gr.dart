// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i27;
import 'package:flutter/material.dart' as _i28;

import '../pages/ajustes/ajustes_page.dart' as _i12;
import '../pages/ajustes/contrasenia_page.dart' as _i14;
import '../pages/ajustes/perfil_page.dart' as _i13;
import '../pages/busqueda/buscar-page.dart' as _i23;
import '../pages/ciudadania/carpeta_ciudadana_page.dart' as _i21;
import '../pages/ciudadania/misfacturas_page.dart' as _i26;
import '../pages/ciudadania/mistramites_page.dart' as _i22;
import '../pages/ciudadania/repositorio_page.dart' as _i24;
import '../pages/home_page.dart' as _i5;
import '../pages/login/entidad_page.dart' as _i4;
import '../pages/login/login_page.dart' as _i1;
import '../pages/login/recuperar_page.dart' as _i3;
import '../pages/login/registrarse_page.dart' as _i2;
import '../pages/nosotros/nosotros_page.dart' as _i25;
import '../pages/pagos/confirmar_pago_page.dart' as _i6;
import '../pages/pagos/pago_page.dart' as _i15;
import '../pages/tramites/inscripciones_page.dart' as _i17;
import '../pages/tramites/mercantil_page.dart' as _i19;
import '../pages/tramites/noposeerbien_page.dart' as _i11;
import '../pages/tramites/pago_inscripcion.dart' as _i20;
import '../pages/tramites/personal_page.dart' as _i18;
import '../pages/tramites/propiedad_page.dart' as _i16;
import '../pages/tramites/tramites_page.dart' as _i10;
import '../pages/verificar/certificadomov_page.dart' as _i8;
import '../pages/verificar/certificadoweb_page.dart' as _i9;
import '../pages/verificar/verificar_doc_page.dart' as _i7;
import 'guard_router.dart' as _i29;

class AppRouter extends _i27.RootStackRouter {
  AppRouter(
      {_i28.GlobalKey<_i28.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i29.AuthGuard authGuard;

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.LoginPage());
    },
    RegistrarseRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.RegistrarsePage());
    },
    RecuperarRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.RecuperarPage());
    },
    EntidadRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.EntidadPage());
    },
    HomeRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.HomePage());
    },
    ConfirmarPagoRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.ConfirmarPagoPage());
    },
    VerificarDocRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.VerificarDocPage());
    },
    CertificadoMovRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.CertificadoMovPage());
    },
    CertificadoWebRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.CertificadoWebPage());
    },
    TramitesRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.TramitesPage());
    },
    NoposeerBienRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i11.NoposeerBienPage());
    },
    AjustesRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.AjustesPage());
    },
    PerfilRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.PerfilPage());
    },
    ContraseniaRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.ContraseniaPage());
    },
    PagoRoute.name: (routeData) {
      final args =
          routeData.argsAs<PagoRouteArgs>(orElse: () => const PagoRouteArgs());
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i15.PagoPage(urlIframe: args.urlIframe));
    },
    PropiedadRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i16.PropiedadPage());
    },
    InscripcionesRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i17.InscripcionesPage());
    },
    PersonalRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i18.PersonalPage());
    },
    MercantilRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i19.MercantilPage());
    },
    PagoInscripcionRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i20.PagoInscripcionPage());
    },
    CarpetaCiudadanaRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i21.CarpetaCiudadanaPage());
    },
    MisTramitesRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i22.MisTramitesPage());
    },
    BuscarRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i23.BuscarPage());
    },
    RepositorioRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i24.RepositorioPage());
    },
    NosotrosRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i25.NosotrosPage());
    },
    MisFacturasRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: _i26.MisFacturasPage());
    }
  };

  @override
  List<_i27.RouteConfig> get routes => [
        _i27.RouteConfig(LoginRoute.name, path: '/iniciarSesion'),
        _i27.RouteConfig(RegistrarseRoute.name, path: '/registrarse'),
        _i27.RouteConfig(RecuperarRoute.name, path: '/recuperar'),
        _i27.RouteConfig(EntidadRoute.name, path: '/registrarEntidad'),
        _i27.RouteConfig(HomeRoute.name, path: '/'),
        _i27.RouteConfig(ConfirmarPagoRoute.name,
            path: '/pagos/transaccionExitosa/*'),
        _i27.RouteConfig(VerificarDocRoute.name, path: '/verificarDocumento'),
        _i27.RouteConfig(CertificadoMovRoute.name,
            path: '/validarCertificadoQR'),
        _i27.RouteConfig(CertificadoWebRoute.name, path: '/validarCertificado'),
        _i27.RouteConfig(TramitesRoute.name,
            path: '/tramites', guards: [authGuard]),
        _i27.RouteConfig(NoposeerBienRoute.name,
            path: '/noposeerbien', guards: [authGuard]),
        _i27.RouteConfig(AjustesRoute.name,
            path: '/ajustes', guards: [authGuard]),
        _i27.RouteConfig(PerfilRoute.name,
            path: '/perfil', guards: [authGuard]),
        _i27.RouteConfig(ContraseniaRoute.name,
            path: '/actualizarContrasenia', guards: [authGuard]),
        _i27.RouteConfig(PagoRoute.name,
            path: '/pagos/procesar', guards: [authGuard]),
        _i27.RouteConfig(PropiedadRoute.name,
            path: '/propiedad', guards: [authGuard]),
        _i27.RouteConfig(InscripcionesRoute.name,
            path: '/inscripciones', guards: [authGuard]),
        _i27.RouteConfig(PersonalRoute.name,
            path: '/fichaPersonal', guards: [authGuard]),
        _i27.RouteConfig(MercantilRoute.name,
            path: '/mercantil', guards: [authGuard]),
        _i27.RouteConfig(PagoInscripcionRoute.name,
            path: '/inscripciones/pagoInscripcion', guards: [authGuard]),
        _i27.RouteConfig(CarpetaCiudadanaRoute.name,
            path: '/carpetaCiudadana', guards: [authGuard]),
        _i27.RouteConfig(MisTramitesRoute.name,
            path: '/misTramites', guards: [authGuard]),
        _i27.RouteConfig(BuscarRoute.name,
            path: '/consultarTramite', guards: [authGuard]),
        _i27.RouteConfig(RepositorioRoute.name,
            path: '/misDocumentos', guards: [authGuard]),
        _i27.RouteConfig(NosotrosRoute.name,
            path: '/acercaDe', guards: [authGuard]),
        _i27.RouteConfig(MisFacturasRoute.name,
            path: '/misFacturas', guards: [authGuard])
      ];
}

/// generated route for [_i1.LoginPage]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/iniciarSesion');

  static const String name = 'LoginRoute';
}

/// generated route for [_i2.RegistrarsePage]
class RegistrarseRoute extends _i27.PageRouteInfo<void> {
  const RegistrarseRoute() : super(name, path: '/registrarse');

  static const String name = 'RegistrarseRoute';
}

/// generated route for [_i3.RecuperarPage]
class RecuperarRoute extends _i27.PageRouteInfo<void> {
  const RecuperarRoute() : super(name, path: '/recuperar');

  static const String name = 'RecuperarRoute';
}

/// generated route for [_i4.EntidadPage]
class EntidadRoute extends _i27.PageRouteInfo<void> {
  const EntidadRoute() : super(name, path: '/registrarEntidad');

  static const String name = 'EntidadRoute';
}

/// generated route for [_i5.HomePage]
class HomeRoute extends _i27.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i6.ConfirmarPagoPage]
class ConfirmarPagoRoute extends _i27.PageRouteInfo<void> {
  const ConfirmarPagoRoute() : super(name, path: '/pagos/transaccionExitosa/*');

  static const String name = 'ConfirmarPagoRoute';
}

/// generated route for [_i7.VerificarDocPage]
class VerificarDocRoute extends _i27.PageRouteInfo<void> {
  const VerificarDocRoute() : super(name, path: '/verificarDocumento');

  static const String name = 'VerificarDocRoute';
}

/// generated route for [_i8.CertificadoMovPage]
class CertificadoMovRoute extends _i27.PageRouteInfo<void> {
  const CertificadoMovRoute() : super(name, path: '/validarCertificadoQR');

  static const String name = 'CertificadoMovRoute';
}

/// generated route for [_i9.CertificadoWebPage]
class CertificadoWebRoute extends _i27.PageRouteInfo<void> {
  const CertificadoWebRoute() : super(name, path: '/validarCertificado');

  static const String name = 'CertificadoWebRoute';
}

/// generated route for [_i10.TramitesPage]
class TramitesRoute extends _i27.PageRouteInfo<void> {
  const TramitesRoute() : super(name, path: '/tramites');

  static const String name = 'TramitesRoute';
}

/// generated route for [_i11.NoposeerBienPage]
class NoposeerBienRoute extends _i27.PageRouteInfo<void> {
  const NoposeerBienRoute() : super(name, path: '/noposeerbien');

  static const String name = 'NoposeerBienRoute';
}

/// generated route for [_i12.AjustesPage]
class AjustesRoute extends _i27.PageRouteInfo<void> {
  const AjustesRoute() : super(name, path: '/ajustes');

  static const String name = 'AjustesRoute';
}

/// generated route for [_i13.PerfilPage]
class PerfilRoute extends _i27.PageRouteInfo<void> {
  const PerfilRoute() : super(name, path: '/perfil');

  static const String name = 'PerfilRoute';
}

/// generated route for [_i14.ContraseniaPage]
class ContraseniaRoute extends _i27.PageRouteInfo<void> {
  const ContraseniaRoute() : super(name, path: '/actualizarContrasenia');

  static const String name = 'ContraseniaRoute';
}

/// generated route for [_i15.PagoPage]
class PagoRoute extends _i27.PageRouteInfo<PagoRouteArgs> {
  PagoRoute({String? urlIframe})
      : super(name,
            path: '/pagos/procesar', args: PagoRouteArgs(urlIframe: urlIframe));

  static const String name = 'PagoRoute';
}

class PagoRouteArgs {
  const PagoRouteArgs({this.urlIframe});

  final String? urlIframe;
}

/// generated route for [_i16.PropiedadPage]
class PropiedadRoute extends _i27.PageRouteInfo<void> {
  const PropiedadRoute() : super(name, path: '/propiedad');

  static const String name = 'PropiedadRoute';
}

/// generated route for [_i17.InscripcionesPage]
class InscripcionesRoute extends _i27.PageRouteInfo<void> {
  const InscripcionesRoute() : super(name, path: '/inscripciones');

  static const String name = 'InscripcionesRoute';
}

/// generated route for [_i18.PersonalPage]
class PersonalRoute extends _i27.PageRouteInfo<void> {
  const PersonalRoute() : super(name, path: '/fichaPersonal');

  static const String name = 'PersonalRoute';
}

/// generated route for [_i19.MercantilPage]
class MercantilRoute extends _i27.PageRouteInfo<void> {
  const MercantilRoute() : super(name, path: '/mercantil');

  static const String name = 'MercantilRoute';
}

/// generated route for [_i20.PagoInscripcionPage]
class PagoInscripcionRoute extends _i27.PageRouteInfo<void> {
  const PagoInscripcionRoute()
      : super(name, path: '/inscripciones/pagoInscripcion');

  static const String name = 'PagoInscripcionRoute';
}

/// generated route for [_i21.CarpetaCiudadanaPage]
class CarpetaCiudadanaRoute extends _i27.PageRouteInfo<void> {
  const CarpetaCiudadanaRoute() : super(name, path: '/carpetaCiudadana');

  static const String name = 'CarpetaCiudadanaRoute';
}

/// generated route for [_i22.MisTramitesPage]
class MisTramitesRoute extends _i27.PageRouteInfo<void> {
  const MisTramitesRoute() : super(name, path: '/misTramites');

  static const String name = 'MisTramitesRoute';
}

/// generated route for [_i23.BuscarPage]
class BuscarRoute extends _i27.PageRouteInfo<void> {
  const BuscarRoute() : super(name, path: '/consultarTramite');

  static const String name = 'BuscarRoute';
}

/// generated route for [_i24.RepositorioPage]
class RepositorioRoute extends _i27.PageRouteInfo<void> {
  const RepositorioRoute() : super(name, path: '/misDocumentos');

  static const String name = 'RepositorioRoute';
}

/// generated route for [_i25.NosotrosPage]
class NosotrosRoute extends _i27.PageRouteInfo<void> {
  const NosotrosRoute() : super(name, path: '/acercaDe');

  static const String name = 'NosotrosRoute';
}

/// generated route for [_i26.MisFacturasPage]
class MisFacturasRoute extends _i27.PageRouteInfo<void> {
  const MisFacturasRoute() : super(name, path: '/misFacturas');

  static const String name = 'MisFacturasRoute';
}
