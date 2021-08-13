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
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      final material = MaterialApp(
        theme: theme.getTheme(),
        title:
            'Registro Municipal de la Propiedad y Mercantil del Cantón de Playas',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RpmApplication.router.generator,
      );
      print("initial route = ${material.initialRoute}");
      return material;
    });
  }
}
