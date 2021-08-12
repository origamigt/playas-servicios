import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/routes/rpm_application.dart';
import 'package:playas/src/routes/rpm_routes.dart';
import 'package:playas/src/widgets/theme-manager.dart';
import 'package:provider/provider.dart';

void main() {
  //window.document.onContextMenu.listen((evt) => evt.preventDefault());
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
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
    final app = Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
              theme: theme.getTheme(),
              title: 'Registro de la Propiedad de Playas',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RpmApplication.router.generator,
              //onGenerateInitialRoutes: ,
              //initialRoute: HomePage().route,
              /*routes: {
                '/': (context) => LoginPage(),
                HomePage().route: (BuildContext context) => HomePage(),
                ScanQrpage().route: (BuildContext context) => HomePage(),
                TramitesPage().route: (BuildContext context) => TramitesPage(),
                AjustesPage().route: (BuildContext context) => AjustesPage(),
              },*/
            ));

    return app;
  }
}
