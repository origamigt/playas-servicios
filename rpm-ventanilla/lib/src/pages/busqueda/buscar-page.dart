import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/providers/consulta_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class BuscarPage extends StatefulWidget {
  static const String route = '/consultarTramite';

  BuscarPage();

  @override
  State<StatefulWidget> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  bool isWeb = UniversalPlatform.isWeb;
  ConsultaProvider? tramiteProvider;
  final _formKey = GlobalKey<FormState>();
  DatosProforma? _datosProforma;
  static final formatter = DateFormat('dd-MM-yyyy');
  String header = '', status = '', dateInit = '', dateFinish = '';
  bool searching = false;
  bool foundResult = false;
  TextEditingController codigoCtrl = TextEditingController();
  final styleTextCard = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.grey,
    fontSize: 14.0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tramiteProvider = Provider.of<ConsultaProvider>(context);
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Consulta de trámites', isWeb),
          body: body(),
          footer: Container(),
        ));
  }

  Widget body() {
    return LayoutBuilder(
      builder: (context, constraints) {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            height: 80,
            alignment: Alignment.center,
            child: TextFormField(
              controller: codigoCtrl,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingrese el número de trámite';
                }
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                suffix: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      consultarTramite();
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Ingrese el número de trámite',
              ),
              textAlign: TextAlign.start,
            )),
        tramiteProvider!.status == StatusConsultaProv.Unknown
            ? Container()
            : tramiteProvider!.status == StatusConsultaProv.Searching
                ? cargando()
                : cardSearch()
      ],
    );
  }

  Widget cardSearch() {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.bookmark, color: Colors.lightBlue),
                title: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      header,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.battery_charging_full,
                                color: Colors.indigoAccent),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(status,
                                  textAlign: TextAlign.center,
                                  style: styleTextCard),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.access_time, color: Colors.orange),
                            Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(dateInit,
                                    textAlign: TextAlign.center,
                                    style: styleTextCard))
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.beenhere, color: Colors.green),
                            Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(dateFinish,
                                    textAlign: TextAlign.center,
                                    style: styleTextCard))
                          ],
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void consultarTramite() {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage = tramiteProvider!.consultarTramite(codigoCtrl.text);
    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          _datosProforma = response['data'];
          this.header = '#' +
              _datosProforma!.numerotramite!.toString() +
              ' - ' +
              _datosProforma!.nombre_beneficiario!;
          this.status = _datosProforma!.estadotramite!;
          this.dateInit = formatter.format(DateTime.fromMillisecondsSinceEpoch(
              _datosProforma!.fechaingreso!));
          this.dateFinish = _datosProforma!.revisor!;
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
