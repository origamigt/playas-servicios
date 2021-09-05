import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/response-create.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/response_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:vrouter/vrouter.dart';

class ConfirmarPagoPage extends StatefulWidget {
  static const String route = '/pagos/transaccionExitosa';

  ConfirmarPagoPage();

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

  List<String> params = [];

  List<String> param1 = [];
  List<String> param2 = [];
  List<String> param3 = [];

  @override
  void initState() {
    //load();
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

  void load(String urlPago) {
    params = urlPago.split('&');

    param1 = params[0].split('=');
    param2 = params[1].split('=');
    param3 = params[2].split('=');

    String url = dominio + ConfirmarPagoPage.route + param2[1];

    if (generateMd5(url) == param1[1]) {
      validos = true;
    }
  }

  final responseProvider = ResponseProvider();

  @override
  Widget build(BuildContext context) {
    load(context.vRouter.url.replaceAll('/pagos/transaccionExitosa?', ''));
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
                    future:
                        responseProvider.confirmarPago(param2[1], param3[1]),
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
