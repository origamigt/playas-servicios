import 'package:flutter/material.dart';
import 'package:playas/src/models/facturas.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:universal_platform/universal_platform.dart';

class MisFacturasPage extends StatefulWidget {
  static const String route = '/misFacturas';

  @override
  _MisFacturasPageState createState() => _MisFacturasPageState();
}

class _MisFacturasPageState extends State<MisFacturasPage> {
  bool isWeb = UniversalPlatform.isWeb;

  List<Facturas> facturas = [];

  User? user;
  Size? size;

  final _formKey = GlobalKey<FormState>();
  Future<List<Facturas>>? solicitudesFuture;
  final tramiteProvider = TramiteProvider();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tramiteProvider.findMisFacturas();
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Mis facturas', isWeb),
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
        width: size!.width,
        height: size!.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: tramiteProvider.misFacturasStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Facturas>?> snapshot) {
                  if (snapshot.hasData) {
                    facturas = snapshot.data!;
                    return _buildList();
                  } else {
                    return cargando();
                  }
                },
              )
            ],
          ),
        ));
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: facturas.length,
      itemBuilder: (BuildContext context, int index) {
        Facturas factura = facturas[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              '# Autorización: ${factura.numAutorizacion!}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Icon(Icons.developer_board,
                                    color: Colors.black),
                                Text(
                                  'Clave de acceso:\n${factura.claveAcceso!}',
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.system_update_alt,
                                    color: Colors.black),
                                Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      '# Factura: ${factura.numFacturaFormato!}',
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.monetization_on_outlined,
                                    color: Colors.black),
                                Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      '\$Total: ${factura.valorTotal!}',
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ))
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
