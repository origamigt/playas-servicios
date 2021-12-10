//import 'dart:js' as js;

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:auto_route/auto_route.dart';

class PaymentsRediectPage extends StatefulWidget {
  static const String route = '/pagos/paymentsredirect';
  final String? code;
  final String? payment;

  PaymentsRediectPage(
    @QueryParam() this.code,
    @QueryParam() this.payment,
  );

  @override
  PagoInscripcionState createState() => PagoInscripcionState();
}

class PagoInscripcionState extends State<PaymentsRediectPage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<PaymentsRediectPage> {
  PagoProvider? pagoProvider;
  final tramiteProvider = TramiteProvider();
  bool isWeb = UniversalPlatform.isWeb;
  Size? size;
  UsuarioProvider? userProvider;
  final _formKey = GlobalKey<FormState>();
  bool validos = false;
  String txtvalidado = '';

  UniqueKey _key = UniqueKey();
  Set<Factory<OneSequenceGestureRecognizer>>? gesture =
      [Factory(() => EagerGestureRecognizer())].toSet();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    load();
  }

  void load() async {
    DateTime now = DateTime.now();
    String hoy = DateFormat('yyyy-MM-dd').format(now);
    print(widget.code!);
    print(hoy);
    print(dominio + '#' + PaymentsRediectPage.route);
    print(generateMd5(dominio + '#' + PaymentsRediectPage.route));
    print(widget.payment!);
    print(generateMd5(hoy +
        generateMd5(dominio + '#' + PaymentsRediectPage.route) +
        widget.payment!));
    if (generateMd5(hoy +
            generateMd5(dominio + '#' + PaymentsRediectPage.route) +
            widget.payment!) ==
        widget.code) {
      validos = true;
      await launch(widget.payment!,
          forceSafariVC: false,
          forceWebView: false,
          enableJavaScript: true,
          webOnlyWindowName: '_self');
    } else {
      setState(() {
        txtvalidado = 'Intente nuevamente';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context);

    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, '', isWeb),
          body: SingleChildScrollView(
            child: Column(
              children: [
                loading('....'),
                Text(txtvalidado.isNotEmpty ? txtvalidado : ''),
              ],
            ),
          ),
          footer: Container(),
        ));
  }
}
