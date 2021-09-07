import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/datos-detalle-proforma.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/pagos/pago_page.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vrouter/vrouter.dart';

class PagoInscripcionPage extends StatefulWidget {
  static const String route = '/inscripciones/pagoInscripcion';

  @override
  PagoInscripcionState createState() => PagoInscripcionState();
}

class PagoInscripcionState extends State<PagoInscripcionPage>
    with SingleTickerProviderStateMixin {
  bool isWeb = UniversalPlatform.isWeb;
  Size? size;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PagoProvider? pagoProvider;

  bool validos = false;
  bool loading = true;
  bool connect = false;

  List<String> params = [];

  List<String> param1 = [];
  List<String> param2 = [];
  List<String> param3 = [];

  @override
  void initState() {
    super.initState();
  }

  void load(String urlPago) {
    params = urlPago.split('&');

    param1 = params[0].split('='); //Numero tramite
    param2 = params[1].split('='); //usuario
    param3 = params[2].split('='); //md5 tramite_usuario_INSCRIPCION

    String md5Compare = '${param1[1]}_${param2[1]}_INSCRIPCION';

    if (generateMd5(md5Compare) == param3[1]) {
      validos = true;
    }
  }

  final tramiteProvider = TramiteProvider();

  @override
  Widget build(BuildContext context) {
    load(context.vRouter.url.replaceAll('${PagoInscripcionPage.route}?', ''));
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.15), BlendMode.dstATop),
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  "Datos de la inscripcion",
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                    future: tramiteProvider
                        .consultarInscripcionXtramite(int.parse(param1[1])),
                    builder: (context, AsyncSnapshot<DatosProforma?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          DatosProforma rc = snapshot.data!;
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  rc.acto!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35.0,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Total: \$${rc.totalPagar!}',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Detalle de la transacción',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                detalleProformaWidget(rc.detalle!),
                                SizedBox(
                                  height: 10,
                                ),
                                procederPagoWidget(rc.idSolicitud!)
                              ],
                            ),
                          );
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
          )),
    );
  }

  Widget detalleProformaWidget(List<DatosDetalleProforma> detalle) {
    return Column(
      children: [
        Text(
          'Detalle proforma',
          style: Theme.of(context).textTheme.headline5,
        ),
        ListView.builder(
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
                  height: 85,
                  width: size!.width - 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.lightBlue,
                        width: 3.0,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Wrap(
                        children: [
                          Text(
                            item.acto!,
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
            })
      ],
    );
  }

  Widget procederPagoWidget(int idSolicitud) {
    return Container(
      height: 60,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: colorPrimary,
      ),
      child: ElevatedButton(
        onPressed: () async {
          context.vRouter.to(HomePage.route);
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  doProcesarPago(int idSolicitud) {
    final Future<Map<String, dynamic>> successfulMessage = pagoProvider!
        .procederPagoInscripcion(idSolicitud);

    successfulMessage.then((response) async {
      print(response.toString());
      if (response['status']) {
        Solicitud rest = response['data'];

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
            js.context.callMethod('open', [rest.linkPago, '_self']);
          }
        }
      } else {
        mensajeError(context, response['message']);
      }
    });
  }


}
