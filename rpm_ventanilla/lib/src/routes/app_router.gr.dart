// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter(
      {GlobalKey<NavigatorState>? navigatorKey, required this.authGuard})
      : super(navigatorKey);

  final AuthGuard authGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: LoginPage());
    },
    RegistrarseRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: RegistrarsePage());
    },
    RecuperarRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: RecuperarPage());
    },
    EntidadRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: EntidadPage());
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: HomePage());
    },
    ConfirmarPagoRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ConfirmarPagoRouteArgs>(
          orElse: () => ConfirmarPagoRouteArgs(
              code: queryParams.optString('code'),
              id: queryParams.optString('id'),
              clientTransactionId:
                  queryParams.optString('clientTransactionId')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              ConfirmarPagoPage(args.code, args.id, args.clientTransactionId));
    },
    VerificarDocRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: VerificarDocPage());
    },
    CertificadoMovRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CertificadoMovPage());
    },
    CertificadoWebRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CertificadoWebPage());
    },
    PaymentsRediectRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<PaymentsRediectRouteArgs>(
          orElse: () => PaymentsRediectRouteArgs(
              code: queryParams.optString('code'),
              payment: queryParams.optString('payment')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PaymentsRediectPage(args.code, args.payment));
    },
    PagoInscripcionRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<PagoInscripcionRouteArgs>(
          orElse: () => PagoInscripcionRouteArgs(
              code1: queryParams.optString('code1'),
              code2: queryParams.optString('code2'),
              code3: queryParams.optString('code3')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PagoInscripcionPage(args.code1, args.code2, args.code3));
    },
    TramitesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TramitesPage());
    },
    NoposeerBienRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: NoposeerBienPage());
    },
    AjustesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: AjustesPage());
    },
    PerfilRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: PerfilPage());
    },
    ContraseniaRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ContraseniaPage());
    },
    PagoRoute.name: (routeData) {
      final args =
          routeData.argsAs<PagoRouteArgs>(orElse: () => const PagoRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PagoPage(urlIframe: args.urlIframe));
    },
    PropiedadRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PropiedadPage());
    },
    InscripcionesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: InscripcionesPage());
    },
    PersonalRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PersonalPage());
    },
    MercantilRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: MercantilPage());
    },
    CarpetaCiudadanaRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CarpetaCiudadanaPage());
    },
    MisTramitesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: MisTramitesPage());
    },
    BuscarRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: BuscarPage());
    },
    RepositorioRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: RepositorioPage());
    },
    NosotrosRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: NosotrosPage());
    },
    MisFacturasRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: MisFacturasPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(LoginRoute.name, path: '/iniciarSesion'),
        RouteConfig(RegistrarseRoute.name, path: '/registrarse'),
        RouteConfig(RecuperarRoute.name, path: '/recuperar'),
        RouteConfig(EntidadRoute.name, path: '/registrarEntidad'),
        RouteConfig(HomeRoute.name, path: '/'),
        RouteConfig(ConfirmarPagoRoute.name, path: '/pagos/transaccionExitosa'),
        RouteConfig(VerificarDocRoute.name, path: '/verificarDocumento'),
        RouteConfig(CertificadoMovRoute.name, path: '/validarCertificadoQR'),
        RouteConfig(CertificadoWebRoute.name, path: '/validarCertificado'),
        RouteConfig(PaymentsRediectRoute.name, path: '/pagos/paymentsredirect'),
        RouteConfig(PagoInscripcionRoute.name,
            path: '/inscripciones/pagoInscripcion'),
        RouteConfig(TramitesRoute.name, path: '/tramites', guards: [authGuard]),
        RouteConfig(NoposeerBienRoute.name,
            path: '/noposeerbien', guards: [authGuard]),
        RouteConfig(AjustesRoute.name, path: '/ajustes', guards: [authGuard]),
        RouteConfig(PerfilRoute.name, path: '/perfil', guards: [authGuard]),
        RouteConfig(ContraseniaRoute.name,
            path: '/actualizarContrasenia', guards: [authGuard]),
        RouteConfig(PagoRoute.name,
            path: '/pagos/procesar', guards: [authGuard]),
        RouteConfig(PropiedadRoute.name,
            path: '/propiedad', guards: [authGuard]),
        RouteConfig(InscripcionesRoute.name,
            path: '/inscripciones', guards: [authGuard]),
        RouteConfig(PersonalRoute.name,
            path: '/fichaPersonal', guards: [authGuard]),
        RouteConfig(MercantilRoute.name,
            path: '/mercantil', guards: [authGuard]),
        RouteConfig(CarpetaCiudadanaRoute.name,
            path: '/carpetaCiudadana', guards: [authGuard]),
        RouteConfig(MisTramitesRoute.name,
            path: '/misTramites', guards: [authGuard]),
        RouteConfig(BuscarRoute.name,
            path: '/consultarTramite', guards: [authGuard]),
        RouteConfig(RepositorioRoute.name,
            path: '/misDocumentos', guards: [authGuard]),
        RouteConfig(NosotrosRoute.name, path: '/acercaDe', guards: [authGuard]),
        RouteConfig(MisFacturasRoute.name,
            path: '/misFacturas', guards: [authGuard])
      ];
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/iniciarSesion');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [RegistrarsePage]
class RegistrarseRoute extends PageRouteInfo<void> {
  const RegistrarseRoute() : super(RegistrarseRoute.name, path: '/registrarse');

  static const String name = 'RegistrarseRoute';
}

/// generated route for
/// [RecuperarPage]
class RecuperarRoute extends PageRouteInfo<void> {
  const RecuperarRoute() : super(RecuperarRoute.name, path: '/recuperar');

  static const String name = 'RecuperarRoute';
}

/// generated route for
/// [EntidadPage]
class EntidadRoute extends PageRouteInfo<void> {
  const EntidadRoute() : super(EntidadRoute.name, path: '/registrarEntidad');

  static const String name = 'EntidadRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ConfirmarPagoPage]
class ConfirmarPagoRoute extends PageRouteInfo<ConfirmarPagoRouteArgs> {
  ConfirmarPagoRoute(
      {required String? code,
      required String? id,
      required String? clientTransactionId})
      : super(ConfirmarPagoRoute.name,
            path: '/pagos/transaccionExitosa',
            args: ConfirmarPagoRouteArgs(
                code: code, id: id, clientTransactionId: clientTransactionId),
            rawQueryParams: {
              'code': code,
              'id': id,
              'clientTransactionId': clientTransactionId
            });

  static const String name = 'ConfirmarPagoRoute';
}

class ConfirmarPagoRouteArgs {
  const ConfirmarPagoRouteArgs(
      {required this.code,
      required this.id,
      required this.clientTransactionId});

  final String? code;

  final String? id;

  final String? clientTransactionId;

  @override
  String toString() {
    return 'ConfirmarPagoRouteArgs{code: $code, id: $id, clientTransactionId: $clientTransactionId}';
  }
}

/// generated route for
/// [VerificarDocPage]
class VerificarDocRoute extends PageRouteInfo<void> {
  const VerificarDocRoute()
      : super(VerificarDocRoute.name, path: '/verificarDocumento');

  static const String name = 'VerificarDocRoute';
}

/// generated route for
/// [CertificadoMovPage]
class CertificadoMovRoute extends PageRouteInfo<void> {
  const CertificadoMovRoute()
      : super(CertificadoMovRoute.name, path: '/validarCertificadoQR');

  static const String name = 'CertificadoMovRoute';
}

/// generated route for
/// [CertificadoWebPage]
class CertificadoWebRoute extends PageRouteInfo<void> {
  const CertificadoWebRoute()
      : super(CertificadoWebRoute.name, path: '/validarCertificado');

  static const String name = 'CertificadoWebRoute';
}

/// generated route for
/// [PaymentsRediectPage]
class PaymentsRediectRoute extends PageRouteInfo<PaymentsRediectRouteArgs> {
  PaymentsRediectRoute({required String? code, required String? payment})
      : super(PaymentsRediectRoute.name,
            path: '/pagos/paymentsredirect',
            args: PaymentsRediectRouteArgs(code: code, payment: payment),
            rawQueryParams: {'code': code, 'payment': payment});

  static const String name = 'PaymentsRediectRoute';
}

class PaymentsRediectRouteArgs {
  const PaymentsRediectRouteArgs({required this.code, required this.payment});

  final String? code;

  final String? payment;

  @override
  String toString() {
    return 'PaymentsRediectRouteArgs{code: $code, payment: $payment}';
  }
}

/// generated route for
/// [PagoInscripcionPage]
class PagoInscripcionRoute extends PageRouteInfo<PagoInscripcionRouteArgs> {
  PagoInscripcionRoute(
      {required String? code1, required String? code2, required String? code3})
      : super(PagoInscripcionRoute.name,
            path: '/inscripciones/pagoInscripcion',
            args: PagoInscripcionRouteArgs(
                code1: code1, code2: code2, code3: code3),
            rawQueryParams: {'code1': code1, 'code2': code2, 'code3': code3});

  static const String name = 'PagoInscripcionRoute';
}

class PagoInscripcionRouteArgs {
  const PagoInscripcionRouteArgs(
      {required this.code1, required this.code2, required this.code3});

  final String? code1;

  final String? code2;

  final String? code3;

  @override
  String toString() {
    return 'PagoInscripcionRouteArgs{code1: $code1, code2: $code2, code3: $code3}';
  }
}

/// generated route for
/// [TramitesPage]
class TramitesRoute extends PageRouteInfo<void> {
  const TramitesRoute() : super(TramitesRoute.name, path: '/tramites');

  static const String name = 'TramitesRoute';
}

/// generated route for
/// [NoposeerBienPage]
class NoposeerBienRoute extends PageRouteInfo<void> {
  const NoposeerBienRoute()
      : super(NoposeerBienRoute.name, path: '/noposeerbien');

  static const String name = 'NoposeerBienRoute';
}

/// generated route for
/// [AjustesPage]
class AjustesRoute extends PageRouteInfo<void> {
  const AjustesRoute() : super(AjustesRoute.name, path: '/ajustes');

  static const String name = 'AjustesRoute';
}

/// generated route for
/// [PerfilPage]
class PerfilRoute extends PageRouteInfo<void> {
  const PerfilRoute() : super(PerfilRoute.name, path: '/perfil');

  static const String name = 'PerfilRoute';
}

/// generated route for
/// [ContraseniaPage]
class ContraseniaRoute extends PageRouteInfo<void> {
  const ContraseniaRoute()
      : super(ContraseniaRoute.name, path: '/actualizarContrasenia');

  static const String name = 'ContraseniaRoute';
}

/// generated route for
/// [PagoPage]
class PagoRoute extends PageRouteInfo<PagoRouteArgs> {
  PagoRoute({String? urlIframe})
      : super(PagoRoute.name,
            path: '/pagos/procesar', args: PagoRouteArgs(urlIframe: urlIframe));

  static const String name = 'PagoRoute';
}

class PagoRouteArgs {
  const PagoRouteArgs({this.urlIframe});

  final String? urlIframe;

  @override
  String toString() {
    return 'PagoRouteArgs{urlIframe: $urlIframe}';
  }
}

/// generated route for
/// [PropiedadPage]
class PropiedadRoute extends PageRouteInfo<void> {
  const PropiedadRoute() : super(PropiedadRoute.name, path: '/propiedad');

  static const String name = 'PropiedadRoute';
}

/// generated route for
/// [InscripcionesPage]
class InscripcionesRoute extends PageRouteInfo<void> {
  const InscripcionesRoute()
      : super(InscripcionesRoute.name, path: '/inscripciones');

  static const String name = 'InscripcionesRoute';
}

/// generated route for
/// [PersonalPage]
class PersonalRoute extends PageRouteInfo<void> {
  const PersonalRoute() : super(PersonalRoute.name, path: '/fichaPersonal');

  static const String name = 'PersonalRoute';
}

/// generated route for
/// [MercantilPage]
class MercantilRoute extends PageRouteInfo<void> {
  const MercantilRoute() : super(MercantilRoute.name, path: '/mercantil');

  static const String name = 'MercantilRoute';
}

/// generated route for
/// [CarpetaCiudadanaPage]
class CarpetaCiudadanaRoute extends PageRouteInfo<void> {
  const CarpetaCiudadanaRoute()
      : super(CarpetaCiudadanaRoute.name, path: '/carpetaCiudadana');

  static const String name = 'CarpetaCiudadanaRoute';
}

/// generated route for
/// [MisTramitesPage]
class MisTramitesRoute extends PageRouteInfo<void> {
  const MisTramitesRoute() : super(MisTramitesRoute.name, path: '/misTramites');

  static const String name = 'MisTramitesRoute';
}

/// generated route for
/// [BuscarPage]
class BuscarRoute extends PageRouteInfo<void> {
  const BuscarRoute() : super(BuscarRoute.name, path: '/consultarTramite');

  static const String name = 'BuscarRoute';
}

/// generated route for
/// [RepositorioPage]
class RepositorioRoute extends PageRouteInfo<void> {
  const RepositorioRoute()
      : super(RepositorioRoute.name, path: '/misDocumentos');

  static const String name = 'RepositorioRoute';
}

/// generated route for
/// [NosotrosPage]
class NosotrosRoute extends PageRouteInfo<void> {
  const NosotrosRoute() : super(NosotrosRoute.name, path: '/acercaDe');

  static const String name = 'NosotrosRoute';
}

/// generated route for
/// [MisFacturasPage]
class MisFacturasRoute extends PageRouteInfo<void> {
  const MisFacturasRoute() : super(MisFacturasRoute.name, path: '/misFacturas');

  static const String name = 'MisFacturasRoute';
}
