import 'package:auto_route/auto_route.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:playas/src/routes/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool? authenitcated = await initialize();
    if (authenitcated!) {
      resolver.next(true);
    } else {
      router.push(LoginRoute());
    }
  }

  Future<bool?> initialize() async {
    var u = await userLogged();
    print('initialize()');
    return u != null ? true : false;
  }
}
