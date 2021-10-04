/*import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/user_provider.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:playas/src/routes/rpm_application.dart';
import 'package:playas/src/routes/rpm_routes.dart';
import 'package:playas/src/routes/rpm_vroutes.dart';
import 'package:playas/src/widgets/theme-manager.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

void main() {
  //window.document.onContextMenu.listen((evt) => evt.preventDefault());
  /* return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: AppComponent(),
  ));*/

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: Builder(
      builder: (context) {
        final themeNotifier = Provider.of<ThemeNotifier>(context);
        Future<User?> getUserData() => userLogged();
        return VRouter(
          theme: themeNotifier.getTheme(),
          debugShowCheckedModeBanner: false,
          // VRouter acts as a MaterialApp
          mode: VRouterMode.history,
          // Remove the '#' from the url
          logs: VLogs.info,
          // Defines which logs to show, info is the default
          routes: [
            VWidget(
              path: LoginPage.route,
              widget: LoginPage(),
            ),
            VRouteRedirector(
              redirectTo: LoginPage.route,
              path: r'*',
            ),
            VGuard(
                beforeEnter: (vRedirector) async {
                  User? check = await getUserData();
                  return check == null ? null : vRedirector.to(LoginPage.route);
                },
                stackedRoutes: [
                  ConnectedRoutes(), // Custom VRouteElement
                ]),
          ],
        );
      },
    ),
  ));
}

class MyScaffold extends StatelessWidget {
  final Widget child;

  const MyScaffold(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState();

  @override
  void initState() {
    final router = FluroRouter();
    RpmRoutes.configureRoutes(router);
    RpmApplication.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    Future<User?> getUserData() => userLogged();
    return MaterialApp(
      theme: themeNotifier.getTheme(),
      title:
          'Registro Municipal de la Propiedad y Mercantil del Cantón de Playas',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RpmApplication.router.generator,
      home: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else if (snapshot.data == null) return LoginPage();
                return HomePage();
            }
          }),
    );
  }
}
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/certificado_provider.dart';
import 'package:playas/src/providers/consulta_provider.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/perfil_provider.dart';
import 'package:playas/src/providers/persona_provider.dart';
import 'package:playas/src/providers/requisitos_provider.dart';
import 'package:playas/src/providers/theme-manager.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/providers/validardoc_provider.dart';
import 'package:playas/src/routes/guard_router.dart';
import 'package:playas/src/routes/router.gr.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter(authGuard: AuthGuard());

  Widget build(BuildContext context) {
    /*return MaterialApp.router(
      title: appName,
      routerDelegate: AutoRouterDelegate(_appRouter),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );*/
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => PersonaProvider()),
        ChangeNotifierProvider(create: (_) => ValidarDocProvider()),
        ChangeNotifierProvider(create: (_) => PagoProvider()),
        ChangeNotifierProvider(create: (_) => RequisitosProvider()),
        ChangeNotifierProvider(create: (_) => CertificadoProvider()),
        ChangeNotifierProvider(create: (_) => ConsultaProvider()),
        ChangeNotifierProvider(create: (_) => PerfilProvider()),
      ],
      builder: (context, child) {
        final themeNotifier = Provider.of<ThemeNotifier>(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.getTheme(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          title: appName,
          routerDelegate: AutoRouterDelegate(_appRouter),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
