import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';

class MisTramitesPage extends StatefulWidget {
  static const String route = '/misTramites';

  @override
  _MisTramitesPageState createState() => _MisTramitesPageState();
}

class _MisTramitesPageState extends State<MisTramitesPage> {
  UsuarioProvider? userProvider;
  static final formatter = DateFormat('dd-MM-yyyy');
  List<Solicitud> _pubSolicitudes = [];

  String header = '',
      status = '',
      dateInit = '',
      dateFinish = '',
      beneficiario = '';
  num? avance;
  User? user;
  Size? size;

  final _formKey = GlobalKey<FormState>();
  Future<List<Solicitud>>? solicitudesFuture;
  final tramiteProvider = TramiteProvider();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context, listen: false);
    userProvider!.initialize().then((value) {
      solicitudesFuture = tramiteProvider.findMisSolicitudes(value!.id!);
    });

    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Mis solicitudes'),
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
              FutureBuilder(
                  future: solicitudesFuture,
                  builder: (context, AsyncSnapshot<List<Solicitud>?> snapshot) {
                    print(snapshot.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        _pubSolicitudes = snapshot.data!;
                        return _buildList();
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
            ],
          ),
        ));
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _pubSolicitudes.length,
      itemBuilder: (BuildContext context, int index) {
        avance = _pubSolicitudes[index].avance;
        beneficiario = _pubSolicitudes[index].solApellidos! +
            ' ' +
            _pubSolicitudes[index].solNombres!;
        header = '';
        if (_pubSolicitudes[index].numeroTramite != null) {
          header =
              '#' + _pubSolicitudes[index].numeroTramite.toString() + ' - ';
        }
        header += beneficiario;

        if (_pubSolicitudes[index].fechaIngreso != null) {
          dateInit = formatter.format(DateTime.fromMillisecondsSinceEpoch(
              _pubSolicitudes[index].fechaIngreso!));
        }

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
                        child: Text(
                          header.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.developer_board,
                                    color: Colors.black),
                                Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      '${_pubSolicitudes[index].acto}',
                                      textAlign: TextAlign.center,
                                    ))
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
                                      'Fecha de Ingreso: ' + dateInit,
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
