import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/user_provider.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:playas/src/routes/rpm_application.dart';
import 'package:playas/src/routes/rpm_routes.dart';
import 'package:playas/src/widgets/theme-manager.dart';
import 'package:provider/provider.dart';

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
    child: AppComponent(),
  ));
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
