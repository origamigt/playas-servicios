import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
