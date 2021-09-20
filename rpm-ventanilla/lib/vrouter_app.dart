import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/ajustes/contrasenia_page.dart';
import 'package:playas/src/pages/ajustes/perfil_page.dart';
import 'package:playas/src/pages/busqueda/buscar-page.dart';
import 'package:playas/src/pages/ciudadania/carpeta_ciudadana_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
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
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import 'src/pages/ciudadania/mistramites_page.dart';

class VRouterApp extends StatefulWidget {
  final ThemeData? themeData;

  const VRouterApp({Key? key, this.themeData}) : super(key: key);

  @override
  _VRouterAppState createState() => _VRouterAppState();
}

class _VRouterAppState extends State<VRouterApp> {
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final usuarioProv = context.read<UsuarioProvider>();
      final authProvider = context.read<AuthProvider>();
      usuarioProv.initialize().then((value) {
        if (value != null) {
          authProvider.setAuthState(Status.LoggedIn);
        } else {
          authProvider.setAuthState(Status.NotLoggedIn);
        }
      });

      //authProvider.
    });
  }

  @override
  Widget build(BuildContext context) {
    //final viewsState = watch(viewsChangeNotifier);
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      if (authProvider.loggedInStatus == Status.Unknown) {
        return Container(
          color: Colors.white,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      }

      return VRouter(
        debugShowCheckedModeBanner: false,
        title:
            'Registro Municipal de la Propiedad y Mercantil del Cantón de Playas',
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('es'), const Locale('en')],
        theme: widget.themeData!,
        mode: VRouterMode.history,
        initialUrl: LoginPage.route,
        routes: [
          VWidget(
              path: LoginPage.route,
              widget: LoginPage(),
              buildTransition: (animation, _, child) =>
                  FadeTransition(opacity: animation, child: child)),
          VWidget(
              path: RegistrarsePage.route,
              widget: RegistrarsePage(),
              buildTransition: (animation, _, child) =>
                  FadeTransition(opacity: animation, child: child)),
          VWidget(
              path: r':_(.pagos/transaccionExitosa)',
              widget: ConfirmarPagoPage()),
          VGuard(
              beforeEnter: (vRedirector) async {
                switch (authProvider.loggedInStatus) {
                  case Status.NotLoggedIn:
                    vRedirector.to(LoginPage.route);
                    break;
                  default:
                    break;
                }
              },
              stackedRoutes: [
                VNester(
                    path: '/',
                    widgetBuilder: (child) => Scaffold(body: child),
                    buildTransition: (animation1, _, child) =>
                        FadeTransition(opacity: animation1, child: child),
                    nestedRoutes: [
                      VWidget(
                        path: HomePage.route,
                        widget: HomePage(),
                      ),
                      VWidget(
                        path: TramitesPage.route,
                        widget: TramitesPage(),
                      ),
                      VWidget(
                        path: NoposeerBienPage.route,
                        widget: NoposeerBienPage(),
                      ),
                      VWidget(
                        path: AjustesPage.route,
                        widget: AjustesPage(),
                      ),
                      VWidget(
                        path: PerfilPage.route,
                        widget: PerfilPage(),
                      ),
                      VWidget(
                        path: ContraseniaPage.route,
                        widget: ContraseniaPage(),
                      ),
                      VWidget(
                        path: VerificarDocPage.route,
                        widget: VerificarDocPage(),
                      ),
                      VWidget(
                        path: PagoPage.route,
                        widget: PagoPage(),
                      ),
                      VWidget(
                        path: PropiedadPage.route,
                        widget: PropiedadPage(),
                      ),
                      VWidget(
                        path: InscripcionesPage.route,
                        widget: InscripcionesPage(),
                      ),
                      VWidget(
                        path: PersonalPage.route,
                        widget: PersonalPage(),
                      ),
                      VWidget(
                        path: MercantilPage.route,
                        widget: MercantilPage(),
                      ),
                      /*VWidget(
                          path: r':_(.inscripciones/pagoInscripcion)',
                          widget: PagoInscripcionPage()),*/
                      VWidget(
                        path: PagoInscripcionPage.route,
                        widget: PagoInscripcionPage(),
                      ),
                      VWidget(
                        path: CarpetaCiudadanaPage.route,
                        widget: CarpetaCiudadanaPage(),
                      ),
                      VWidget(
                        path: MisTramitesPage.route,
                        widget: MisTramitesPage(),
                      ),
                      VWidget(
                        path: BuscarPage.route,
                        widget: BuscarPage(),
                      ),
                      VWidget(
                        path: CertificadoMovPage.route,
                        widget: CertificadoMovPage(),
                      ),
                      VWidget(
                        path: CertificadoWebPage.route,
                        widget: CertificadoWebPage(),
                      ),
                      VWidget(
                        path: NosotrosPage.route,
                        widget: NosotrosPage(),
                      ),
                    ])
              ])
        ],
      );
    });
  }
}
