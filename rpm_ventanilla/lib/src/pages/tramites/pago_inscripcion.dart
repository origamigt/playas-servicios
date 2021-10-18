//import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/datos-detalle-proforma.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/pages/pagos/pago_page.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:auto_route/auto_route.dart';

class PagoInscripcionPage extends StatefulWidget {
  static const String route = '/inscripciones/pagoInscripcion';

  @override
  PagoInscripcionState createState() => PagoInscripcionState();
}

class PagoInscripcionState extends State<PagoInscripcionPage>
    with SingleTickerProviderStateMixin {
  PagoProvider? pagoProvider;
  final tramiteProvider = TramiteProvider();
  bool isWeb = UniversalPlatform.isWeb;
  Size? size;

  final _formKey = GlobalKey<FormState>();
  bool validos = false;

  Future<DatosProforma?>? proformaFuture = null;

  List<String> params = [];

  List<String> param1 = [];
  List<String> param2 = [];
  List<String> param3 = [];

  @override
  void initState() {
    super.initState();
  }

  void load(String urlPago) async {
    params = urlPago.split('&');

    param1 = params[0].split('='); //Numero tramite
    param2 = params[1].split('='); //usuario
    param3 = params[2].split('='); //md5 tramite_usuario_INSCRIPCION

    String md5Compare = '${param1[1]}_${param2[1]}_INSCRIPCION';
    if (generateMd5(md5Compare) == param3[1]) {
      validos = true;
      proformaFuture =
          tramiteProvider.consultarInscripcionXtramite(int.parse(param1[1]));
    }
  }

  @override
  Widget build(BuildContext context) {
    //load(//context.vRouter.url.replaceAll('${PagoInscripcionPage.route}?', ''));
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
            FutureBuilder(
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
                }),
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
            doProcesarPago(idSolicitud, total);
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
                  "Proceder pago",
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
                      urlIframe: rest.linkPago,
                    )));

            if (verificado != null) {
              mensajeError(
                context,
                'Debe proceder al pago para continuar con su solcitud',
              );
            }
          } else {
            await launch(
              rest.linkPago!,
              forceSafariVC: true,
              forceWebView: true,
              enableJavaScript: true,
            );
            //js.context.callMethod('open', [rest.linkPago, '_self']);
          }
        }
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
