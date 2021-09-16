import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BuscarPage extends StatefulWidget {
  static const String route = '/consultarTramite';
  BuscarPage();

  @override
  State<StatefulWidget> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  DatosProforma? _datosProforma;
  static final formatter = DateFormat('dd-MM-yyyy');
  String header = '', status = '', dateInit = '', dateFinish = '';
  bool searching = false;
  bool foundResult = false;
  final styleTextCard = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.grey,
    fontSize: 14.0,
  );

  Widget descriptionBody = Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
          child: Text(
        '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          fontSize: 15.0,
        ),
      )));

  Widget appBarTitle = Text(
    'titleSearch',
    style: TextStyle(color: Colors.lightBlue, fontSize: 15),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.lightBlue,
  );

  @override
  void initState() {
    super.initState();
    //bodyText = 'defaultText';
  }

  @override
  Widget build(BuildContext context) {
    final cardSearch = Center(
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

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
                brightness: Brightness.light,
                elevation: 1.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: appBarTitle,
                actions: <Widget>[
                  IconButton(
                    icon: actionIcon,
                    onPressed: () {
                      setState(() {
                        if (this.actionIcon.icon == Icons.search) {
                          this.descriptionBody = Text('');

                          this.actionIcon =
                              Icon(Icons.close, color: Colors.lightBlue);
                          this.appBarTitle = TextField(
                            textInputAction: TextInputAction.send,
                            keyboardType: TextInputType.number,
                            onSubmitted: searchProcedure,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.lightBlue),
                                hintText: "Escriba el número de su trámite...",
                                hintStyle: TextStyle(
                                    color: Colors.lightBlue, fontSize: 12)),
                          );
                        } else {
                          this.actionIcon = Icon(
                            Icons.search,
                            color: Colors.lightBlue,
                          );
                          this.appBarTitle = Text('titleSearch',
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 15));

                          this.descriptionBody = Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                  child: Text(
                                'bodyText',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                ),
                              )));
                        }
                      });
                    },
                  ),
                ])),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Visibility(
                visible: searching,
                child: JumpingDotsProgressIndicator(
                  fontSize: 30.0,
                )),
            (!searching && _datosProforma == null)
                ? descriptionBody
                : (!searching &&
                        _datosProforma != null &&
                        _datosProforma?.numerotramite != null)
                    ? cardSearch
                    : descriptionBody,
          ],
        ));
  }

  searchProcedure(String inputSearch) async {
    if (inputSearch.length > 0) {
      setState(() {
        searching = true;
      });
      _datosProforma = DatosProforma();
      //DatosProforma result = await findTask(int.parse(inputSearch));

      setState(() {
        searching = false;
        //_datosProforma = result;
        if (_datosProforma != null && _datosProforma!.numerotramite != null) {
          this.descriptionBody = Text('');
          this.header = '#' +
              _datosProforma!.numerotramite!.toString() +
              ' - ' +
              _datosProforma!.nombre_beneficiario!;
          this.status = _datosProforma!.estadotramite!;
          this.dateInit = formatter.format(DateTime.fromMillisecondsSinceEpoch(
              _datosProforma!.fechaingreso!));
          this.dateFinish = _datosProforma!.revisor!;
        } else {
          this.descriptionBody = Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                'No se encontró trámite',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              )));
        }
      });
    }
  }
}
