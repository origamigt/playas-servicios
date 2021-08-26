import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/response-create.dart';
import 'package:playas/src/providers/response_provider.dart';
import 'package:playas/src/widgets/components.dart';

class ConfirmarPagoPage extends StatefulWidget {
  final String? url;

  ConfirmarPagoPage(this.url);

  @override
  ConfirmarPagoPageState createState() => ConfirmarPagoPageState();
}

class ConfirmarPagoPageState extends State<ConfirmarPagoPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // String widget.url!; //code1=1290&code2=0953255957&code3=1573939762285

  bool activar = false;
  bool validos = false;
  bool loading = true;
  bool connect = false;

  String? code1; //code
  String? code2; // id
  String? code3; //clientTransactionId
  String startCode1 = 'code=';
  String endCode1 = '&id';

  String startCode2 = 'id=';
  String endCode2 = '&clientTransactionId';

  String startCode3 = 'clientTransactionId=';

  @override
  void initState() {
    load();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void load() {
    DateTime now = DateTime.now();
    String hoy = DateFormat('yyyy-MM-dd').format(now);

    String urlPago = ''; //urlVentanilla + confirmarPago;

    int startIndexCode1;
    int endIndexCode1;

    startIndexCode1 = widget.url!.indexOf(startCode1);
    endIndexCode1 =
        widget.url!.indexOf(endCode1, startIndexCode1 + startCode1.length);
    code1 = widget.url!
        .substring(startIndexCode1 + startCode1.length, endIndexCode1);
    int startIndexCode2;
    int endIndexCode2;
    startIndexCode2 = widget.url!.indexOf(startCode2);
    endIndexCode2 =
        widget.url!.indexOf(endCode2, startIndexCode2 + startCode2.length);
    code2 = widget.url!
        .substring(startIndexCode2 + startCode2.length, endIndexCode2);
    int startIndexCode3;
    int endIndexCode3;
    startIndexCode3 = widget.url!.indexOf(startCode3);
    code3 = widget.url!
        .substring(startIndexCode3 + startCode3.length, widget.url!.length);

    String md5 = generateMd5(hoy + generateMd5(urlPago) + code3!);
    if (md5 == code1) {
      validos = true;
    }
  }

  final responseProvider = ResponseProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.15), BlendMode.dstATop),
              image: AssetImage('assets/images/img_registro.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                //logoLogin(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Confirmación de pago",
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                    future: responseProvider.confirmarPago(code2!, code3!),
                    builder:
                        (context, AsyncSnapshot<ResponseCreate?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          ResponseCreate rc = snapshot.data!;
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
                                  'Total: \$${rc.total!}',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Datos de la transacción',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Código autorización: ${rc.authorizationCode!}',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                    visible:
                                        rc.statusCode == '3' ? true : false,
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Text(
                                        'Su transacción fue procesada correctamente espere el correo de confirmación',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Visibility(
                                    visible:
                                        rc.statusCode != '3' ? true : false,
                                    child: Text('Detalle ${rc.messageCode}')),
                                GestureDetector(
                                  onTapDown: _onTapDown,
                                  onTapUp: _onTapUp,
                                  child: Transform.scale(
                                    scale: 1,
                                    child: _animatedButtonUI,
                                  ),
                                )
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

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: colorPrimary,
        ),
        child: ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
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

  Widget get _animatedButtonUIMainPage => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: colorPrimary,
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Ir a Pantalla de Inicio",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller!.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller!.reverse();
  }
}
