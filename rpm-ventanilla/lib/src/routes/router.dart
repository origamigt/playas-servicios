import 'package:auto_route/auto_route.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/ajustes/contrasenia_page.dart';
import 'package:playas/src/pages/ajustes/perfil_page.dart';
import 'package:playas/src/pages/busqueda/buscar-page.dart';
import 'package:playas/src/pages/ciudadania/carpeta_ciudadana_page.dart';
import 'package:playas/src/pages/ciudadania/misfacturas_page.dart';
import 'package:playas/src/pages/ciudadania/mistramites_page.dart';
import 'package:playas/src/pages/ciudadania/repositorio_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/entidad_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/pages/login/recuperar_page.dart';
import 'package:playas/src/pages/login/registrarse_page.dart';
import 'package:playas/src/pages/nosotros/nosotros_page.dart';
import 'package:playas/src/pages/pagos/confirmar_pago_page.dart';
import 'package:playas/src/pages/pagos/pago_page.dart';
import 'package:playas/src/pages/tramites/inscripciones_page.dart';
import 'package:playas/src/pages/tramites/mercantil_page.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/pages/tramites/pago_inscripcion.dart';
import 'package:playas/src/pages/tramites/personal_page.dart';
import 'package:playas/src/pages/tramites/propiedad_page.dart';
import 'package:playas/src/pages/tramites/tramites_page.dart';
import 'package:playas/src/pages/verificar/certificadomov_page.dart';
import 'package:playas/src/pages/verificar/certificadoweb_page.dart';
import 'package:playas/src/pages/verificar/verificar_doc_page.dart';
import 'package:playas/src/routes/guard_router.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, path: LoginPage.route, initial: true),
    AutoRoute(page: RegistrarsePage, path: RegistrarsePage.route),
    AutoRoute(page: RecuperarPage, path: RecuperarPage.route),
    AutoRoute(page: EntidadPage, path: EntidadPage.route),
    AutoRoute(page: HomePage, path: HomePage.route),
    AutoRoute(page: ConfirmarPagoPage, path: ConfirmarPagoPage.route),
    AutoRoute(page: VerificarDocPage, path: VerificarDocPage.route),
    AutoRoute(page: CertificadoMovPage, path: CertificadoMovPage.route),
    AutoRoute(page: CertificadoWebPage, path: CertificadoWebPage.route),

    //GUARDS
    AutoRoute(
        page: TramitesPage, path: TramitesPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: NoposeerBienPage,
        path: NoposeerBienPage.route,
        guards: [AuthGuard]),
    AutoRoute(page: AjustesPage, path: AjustesPage.route, guards: [AuthGuard]),
    AutoRoute(page: PerfilPage, path: PerfilPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: ContraseniaPage,
        path: ContraseniaPage.route,
        guards: [AuthGuard]),
    AutoRoute(page: PagoPage, path: PagoPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: PropiedadPage, path: PropiedadPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: InscripcionesPage,
        path: InscripcionesPage.route,
        guards: [AuthGuard]),
    AutoRoute(
        page: PersonalPage, path: PersonalPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: MercantilPage, path: MercantilPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: PagoInscripcionPage,
        path: PagoInscripcionPage.route,
        guards: [AuthGuard]),
    AutoRoute(
        page: CarpetaCiudadanaPage,
        path: CarpetaCiudadanaPage.route,
        guards: [AuthGuard]),
    AutoRoute(
        page: MisTramitesPage,
        path: MisTramitesPage.route,
        guards: [AuthGuard]),
    AutoRoute(page: BuscarPage, path: BuscarPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: RepositorioPage,
        path: RepositorioPage.route,
        guards: [AuthGuard]),
    AutoRoute(
        page: NosotrosPage, path: NosotrosPage.route, guards: [AuthGuard]),
    AutoRoute(
        page: MisFacturasPage,
        path: MisFacturasPage.route,
        guards: [AuthGuard]),
  ],
)
class $AppRouter {}
