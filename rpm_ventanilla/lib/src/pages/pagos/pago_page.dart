import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/pages/pagos/confirmar_pago_page.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:playas/src/routes/app_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PagoPage extends StatefulWidget {
  final String? urlIframe;
  static const String route = '/pagos/procesar';

  PagoPage({this.urlIframe});

  @override
  _PagoPageState createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  UniqueKey _key = UniqueKey();
  Set<Factory<OneSequenceGestureRecognizer>>? gesture =
      [Factory(() => EagerGestureRecognizer())].toSet();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> get urlIframe async {
    print('widget.urlIframe!');
    print(widget.urlIframe!);
    await Future.delayed(Duration(seconds: 1));
    return widget.urlIframe!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white.withOpacity(0.9),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context, 'CLOSE');
              },
            ),
          ),
          Container(
            child: Text(
              'Pago en linea',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: urlIframe,
                        builder: (BuildContext context,
                                AsyncSnapshot snapshot) =>
                            snapshot.hasData
                                ? WebView(
                                    key: _key,
                                    gestureRecognizers: gesture!,
                                    initialUrl: snapshot.data,
                                    onWebViewCreated:
                                        (WebViewController webViewController) {
                                      _controller.complete(webViewController);
                                    },
                                    javascriptMode: JavascriptMode.unrestricted,
                                    gestureNavigationEnabled: true,
                                    debuggingEnabled: true,
                                    onPageFinished: (String url) {
                                      print('onPageFinished $url');
                                      if (url.startsWith(dominio +
                                          '#' +
                                          ConfirmarPagoPage.route)) {
                                        String param = url.replaceAll(
                                            dominio +
                                                '#' +
                                                ConfirmarPagoPage.route +
                                                '?',
                                            '');
                                        print('params $param');
                                        List<String> params = param.split('&');
                                        print(params[0]);
                                        print(params[1]);
                                        print(params[2]);
                                        String code = params[0].split('=')[1];
                                        String id = params[1].split('=')[1];
                                        String clientTransactionId =
                                            params[2].split('=')[1];
                                        print('code $code');
                                        print('id $id');
                                        print(
                                            'clientTransactionId $clientTransactionId');
                                        context.router.replace(
                                            ConfirmarPagoRoute(
                                                code: code,
                                                id: id,
                                                clientTransactionId:
                                                    clientTransactionId));
                                      }
                                    },
                                  )
                                : Container(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.all(5),
                                    child: CircularProgressIndicator(),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
