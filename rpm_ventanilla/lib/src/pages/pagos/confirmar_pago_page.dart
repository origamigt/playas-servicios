import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/response-create.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/response_provider.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class ConfirmarPagoPage extends StatefulWidget {
  static const String route = '/pagos/transaccionExitosa';

  final String? code;
  final String? id;
  final String? clientTransactionId;

  ConfirmarPagoPage(@QueryParam() this.code, @QueryParam() this.id,
      @QueryParam() this.clientTransactionId);

  @override
  ConfirmarPagoPageState createState() => ConfirmarPagoPageState();
}

class ConfirmarPagoPageState extends State<ConfirmarPagoPage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<ConfirmarPagoPage> {
  AnimationController? _controller;
  PagoProvider? pagoProvider;
  bool isWeb = UniversalPlatform.isWeb;
  Size? size;
  bool activar = false;
  bool validos = false;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  ResponseCreate? responseCreate;

  @override
  void initState() {
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

  @override
  void afterFirstLayout(BuildContext context) {
    load();
  }

  load() {
    String url =
        dominio + '#' + ConfirmarPagoPage.route + widget.clientTransactionId!;
    //print('generateMd5(url): ' + generateMd5(url));
    //print(' widget.code!: ' + widget.code!);
    if (generateMd5(url) == widget.code!) {
      doValidarPago();
    } else {
      pagoProvider!.setState(StatusPago.NotFound);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final responseProvider = ResponseProvider();

  @override
  Widget build(BuildContext context) {
    pagoProvider = Provider.of<PagoProvider>(context);
    //load(context.router.url.replaceAll('${ConfirmarPagoPage.route}?', ''));

    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Confirmación de pago', isWeb),
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
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              pagoProvider!.status == StatusPago.Unknown ||
                      pagoProvider!.status == StatusPago.Procesing
                  ? loading('....')
                  : pagoProvider!.status == StatusPago.Done
                      ? responseOk()
                      : pagoProvider!.status == StatusPago.NotFound
                          ? Column(
                              children: [
                                Text('Parametros ingresados incorrectos'),
                                inicio()
                              ],
                            )
                          : Column(
                              children: [Text('Intente nuevamente'), inicio()],
                            )
            ],
          ),
        ));
  }

  Widget responseOk() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            responseCreate != null ? responseCreate!.acto! : '',
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
            responseCreate != null
                ? 'Total: \$${oCcy.format(responseCreate!.total!)}'
                : '',
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
          Visibility(
              visible: responseCreate != null
                  ? responseCreate!.statusCode == '3'
                      ? true
                      : false
                  : false,
              child: Text(
                responseCreate != null
                    ? 'Código autorización: ${responseCreate!.authorizationCode!}'
                    : '',
              )),
          SizedBox(
            height: 10,
          ),
          Visibility(
              visible: responseCreate != null
                  ? responseCreate!.statusCode == '3'
                      ? true
                      : false
                  : false,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Su transacción fue procesada correctamente espere el correo de confirmación',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          Visibility(
              visible: responseCreate != null
                  ? responseCreate!.statusCode != '3'
                      ? true
                      : false
                  : false,
              child: Text(responseCreate != null &&
                      responseCreate!.message != null &&
                      !responseCreate!.message!.isEmpty
                  ? 'Detalle ${responseCreate!.message}'
                  : '')),
          inicio()
        ],
      ),
    );
  }

  Widget inicio() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          child: Transform.scale(
            scale: 1,
            child: _animatedButtonUI,
          ),
        )
      ],
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

  void _onTapDown(TapDownDetails details) {
    _controller!.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller!.reverse();
  }

  doValidarPago() {
    print('doValidarPago');
    final Future<Map<String, dynamic>> successfulMessage =
        pagoProvider!.confirmarPago(widget.id!, widget.clientTransactionId!);

    successfulMessage.then((response) async {
      if (response['status']) {
        setState(() {
          responseCreate = response['data'];
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
