import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/ajustes/ajustes_page.dart';
import 'package:playas/src/pages/ajustes/contrasenia_page.dart';
import 'package:playas/src/pages/ajustes/perfil_page.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

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
      final authProvider = context.read<AuthProvider>();
      Future<User?> getUserData() => userLogged();
      User? user = await getUserData();
      if (user != null) {
        authProvider.setAuthState(Status.LoggedIn);
      } else {
        authProvider.setAuthState(Status.NotLoggedIn);
      }
      //authProvider.
    });
  }

  @override
  Widget build(BuildContext context) {
    //final viewsState = watch(viewsChangeNotifier);
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      if (authProvider.loggedInStatus == Status.Unknown) {
        print('Unknown');
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
        theme: widget.themeData!,
        mode: VRouterMode.history,
        initialUrl: LoginPage.route,
        routes: [
          VWidget(
              path: LoginPage.route,
              widget: LoginPage(),
              buildTransition: (animation, _, child) =>
                  FadeTransition(opacity: animation, child: child)),
          /*VWidget(
              path: '/register',
              widget: RegisterScreen(),
              buildTransition: (animation, _, child) =>
                  FadeTransition(opacity: animation, child: child)),*/
          //VWidget(path: r':_(.confirmarPago)', widget: PagoPage()),
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
                    buildTransition: (animation, _, child) =>
                        FadeTransition(opacity: animation, child: child),
                    nestedRoutes: [
                      VWidget(
                          path: HomePage.route,
                          widget: HomePage(),
                          transitionDuration: Duration(milliseconds: 0)),
                      VWidget(
                          path: NoposeerBienPage.route,
                          widget: NoposeerBienPage(),
                          transitionDuration: Duration(milliseconds: 0)),
                      VWidget(
                        path: AjustesPage.route,
                        widget: AjustesPage(),
                        transitionDuration: Duration(milliseconds: 0),
                      ),
                      VWidget(
                          path: PerfilPage.route,
                          widget: PerfilPage(),
                          transitionDuration: Duration(milliseconds: 0)),
                      VWidget(
                          path: ContraseniaPage.route,
                          widget: ContraseniaPage(),
                          transitionDuration: Duration(milliseconds: 0)),
                    ])
              ])
        ],
      );
    });
  }
}
