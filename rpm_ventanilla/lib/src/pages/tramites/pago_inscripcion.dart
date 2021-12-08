//import 'dart:js' as js;

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/datos-detalle-proforma.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/pagos/pago_page.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/terminos_provider.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:auto_route/auto_route.dart';

class PagoInscripcionPage extends StatefulWidget {
  static const String route = '/inscripciones/pagoInscripcion';
  final String? code1;
  final String? code2;
  final String? code3;

  PagoInscripcionPage(@QueryParam() this.code1, @QueryParam() this.code2,
      @QueryParam() this.code3);

  @override
  PagoInscripcionState createState() => PagoInscripcionState();
}

class PagoInscripcionState extends State<PagoInscripcionPage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<PagoInscripcionPage> {
  PagoProvider? pagoProvider;
  final tramiteProvider = TramiteProvider();
  bool isWeb = UniversalPlatform.isWeb;
  Size? size;
  UsuarioProvider? userProvider;
  final _formKey = GlobalKey<FormState>();
  bool validos = false;
  User? usuario;
  Future<DatosProforma?>? proformaFuture = null;
  bool aceptaTerminosCondiciones = false;
  final _terminosProvider = TerminosProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    load();
  }

  void load() async {
    print('load');
    userProvider!.initialize().then((value) {
      setState(() {
        usuario = value;
        if (usuario != null) {
          String md5Compare = '${widget.code1}_${widget.code2}_INSCRIPCION';
          if (generateMd5(md5Compare) == widget.code3) {
            validos = true;
            proformaFuture = tramiteProvider
                .consultarInscripcionXtramite(int.parse(widget.code1!));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context);

    pagoProvider = Provider.of<PagoProvider>(context);
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Inscripción en linea', isWeb),
          body: body(),
          footer: Container(),
        ));
  }

  Widget body() {
    return LayoutBuilder(
      builder: (context, constraints) {
        size = MediaQuery.of(context).size;
        if (constraints.maxWidth > 600) {
          return FractionallySizedBox(
            widthFactor: 0.5,
            child: bodyDetail(),
          );
        } else {
          return bodyDetail();
        }
      },
    );
  }

  Widget bodyDetail() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            usuario != null
                ? FutureBuilder(
                    future: proformaFuture,
                    builder: (context, AsyncSnapshot<DatosProforma?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          DatosProforma rc = snapshot.data!;
                          return datosProformaWidget(rc);
                        } else {
                          if (snapshot.data == null) {
                            return Text('Intente nuevamente');
                          }
                          return CircularProgressIndicator();
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
                : Column(
                    children: [
                      Text(
                        'Debes iniciar sesión para proceder con el pago',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _animatedButtonUI
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget datosProformaWidget(DatosProforma rc) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rc.acto!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            'Total: \$${rc.totalPagar!}',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Detalle de la transacción',
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          detalleProformaWidget(rc.detalle!),
          SizedBox(
            height: 10,
          ),
          terminosCondicionesWidget(),
          SizedBox(
            height: 15,
          ),
          pagoProvider!.status == StatusPago.Procesing
              ? loading("Procesando solicitud...")
              : procederPagoWidget(rc.idSolicitud!, rc.totalPagar!)
        ],
      ),
    );
  }

  Widget detalleProformaWidget(List<DatosDetalleProforma> detalle) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: detalle.length,
        itemBuilder: (context, i) {
          DatosDetalleProforma item = detalle[i];
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.lightBlue,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.acto!,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${item.valorTotal!}',
                    style: TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget procederPagoWidget(int idSolicitud, double total) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: colorPrimary,
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (usuario != null) {
              if (!aceptaTerminosCondiciones) {
                mensajeError(
                    context, 'Debe aceptar los términos y condiciones');
                return;
              }
              doProcesarPago(idSolicitud, total);
            } else {}
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  usuario != null ? "Proceder pago" : 'Ir a iniciar sesión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: colorPrimary,
        ),
        child: ElevatedButton(
          onPressed: () async {
            context.router.navigateNamed(HomePage.route);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Ir a inicio",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );

  Widget terminosCondicionesWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          'He leído y acepto los ',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder(
                                future:
                                    _terminosProvider.findTerminosCondiciones(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String?> snapshot) {
                                  if (snapshot.hasData) {
                                    return terminosCondicionesHTML(
                                        context, snapshot.data!);
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          })
                    },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "Términos y condiciones",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Checkbox(
              value: aceptaTerminosCondiciones,
              onChanged: (bool? value) {
                setState(() {
                  aceptaTerminosCondiciones = value!;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  doProcesarPago(int idSolicitud, double total) {
    final Future<Map<String, dynamic>> successfulMessage =
        pagoProvider!.procederPagoInscripcion(idSolicitud, total);

    successfulMessage.then((response) async {
      print(response.toString());
      if (response['status']) {
        Solicitud rest = response['data'];
        print(rest.linkPago);
        if (rest.linkPago != null) {
          if (!isWeb) {
            var verificado = await Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) => PagoPage(
                      urlIframe: rest.payWithApp,
                    )));

            if (verificado != null) {
              mensajeError(
                context,
                'Debe proceder al pago para continuar con su solcitud',
              );
            }
          } else {
            await launch(rest.linkPago!,
                forceSafariVC: false,
                forceWebView: false,
                enableJavaScript: true,
                webOnlyWindowName: '_self');
            //html.window.open();
            //js.context.callMethod('open', [rest.linkPago, '_self']);
          }
        }
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
