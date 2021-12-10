///import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/pagos/pago_page.dart';
import 'package:playas/src/providers/actos_provider.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/persona_provider.dart';
import 'package:playas/src/providers/terminos_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class NoposeerBienPage extends StatefulWidget {
  static const String route = '/noposeerbien';

  @override
  @override
  NoposeerBienState createState() => NoposeerBienState();
}

class NoposeerBienState extends State<NoposeerBienPage> {
  bool isWeb = UniversalPlatform.isWeb;
  Acto? acto;
  UsuarioProvider? userProvider;
  PersonaProvider? personaProvider;
  PagoProvider? pagoProvider;

  TextEditingController cantidadCtrl = TextEditingController();

  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();

  /*TextEditingController identificacionFactCtrl = TextEditingController();
  TextEditingController datosPersonaFactCtrl = TextEditingController();
  TextEditingController direccionFactCtrl = TextEditingController();
  TextEditingController telefonoFactCtrl = TextEditingController();
  TextEditingController correoFactCtrl = TextEditingController();*/

  TextEditingController obsCtrl = TextEditingController();
  TextEditingController otroMotivoCtrl = TextEditingController();

  String estadoCivilSol = '';
  User? usuario;
  final _formKey = GlobalKey<FormState>();

  Data motivo = motivosSolicitudNoBienes[0];
  final _actosProvider = ActosProvider();
  bool aceptaTerminosCondiciones = false;
  final _terminosProvider = TerminosProvider();

  @override
  void initState() {
    super.initState();
    cargarActo();
  }

  cargarActo() async {
    acto = await _actosProvider.findActoId(1358);
    cantidadCtrl.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context);
    personaProvider = Provider.of<PersonaProvider>(context);
    pagoProvider = Provider.of<PagoProvider>(context);

    userProvider!.initialize().then((value) {
      usuario = value;
      PubPersona persona = usuario!.persona!;

      identificacionCtrl.text = persona.cedRuc!;
      var nombres = persona.nombres! + ' ' + persona.apellidos!;
      datosPersonaCtrl.text = nombres;
      direccionCtrl.text = persona.direccion!;
      telefonoCtrl.text = persona.telefono1!;
      correoCtrl.text = persona.correo1!;

/*      identificacionFactCtrl.text = persona.cedRuc!;
      datosPersonaFactCtrl.text = nombres;
      direccionFactCtrl.text = persona.direccion!;
      telefonoFactCtrl.text = persona.telefono1!;
      correoFactCtrl.text = persona.correo1!;*/
    });

    return Form(
        key: _formKey,
        child: PageComponent(
          header:
              tituloPagina(context, 'Certificado de no poseer bienes', isWeb),
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
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tituloWidget(context, 'Motivo de la solicitud'),
            Wrap(
              children: motivosWidget(),
            ),
            motivo.id == -1
                ? otroMotivoWidget()
                : SizedBox(
                    height: 10,
                  ),
            cantidadWidget(),
            observacionWidget(),
            tituloWidget(context, 'Datos del solicitante y factura'),
            identificacionWidget(),
            nombresWidget(),
            //direccionWidget(),
            telefonoWidget(),
            correoWidget(),
            /*tituloWidget(context, 'Datos de la factura'),
            identificacionFactWidget(),
            nombresFactWidget(),
            direccionFactWidget(),
            telefonoFactWidget(),
            correoFactWidget(),*/
            SizedBox(
              height: 15,
            ),
            terminosCondicionesWidget(),
            SizedBox(
              height: 15,
            ),
            pagoProvider!.status == StatusPago.Procesing
                ? loading("Procesando solicitud...")
                : Center(
                    child: btnProcesarPago(),
                  ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget otroMotivoWidget() {
    return datosWidget(
        context,
        'Escribe aqui el motivo de tu solicitud',
        TextFormField(
          controller: otroMotivoCtrl,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.stream,
            ),
          ),
          validator: (value) {
            if (motivo.id == -1 && value!.isEmpty) {
              return 'Ingrese el motivo de su solicitud!';
            }
          },
          textAlign: TextAlign.start,
        ));
  }

  Widget cantidadWidget() {
    return datosWidget(
        context,
        'Cantidad de certificados',
        TextFormField(
          controller: cantidadCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese su la cantidad de certificados a solicitar!';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.confirmation_num_outlined,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget observacionWidget() {
    return datosWidget(
        context,
        '¿Quieres contarnos algo más?',
        TextFormField(
          controller: obsCtrl,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.comment_bank_outlined,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget identificacionWidget() {
    return datosWidget(
      context,
      'Identificación',
      TextFormField(
        readOnly: true,
        controller: identificacionCtrl,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ingrese la identificación del solicitante';
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
          ),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget nombresWidget() {
    return datosWidget(
        context,
        'Datos personales',
        TextFormField(
          controller: datosPersonaCtrl,
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese los nombres del solicitante';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.accessibility,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget correoWidget() {
    return datosWidget(
        context,
        'Correo electrónico',
        TextFormField(
          controller: correoCtrl,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese el correo electrónico del solicitante';
            }
          },
          textAlign: TextAlign.start,
        ));
  }

  Widget telefonoWidget() {
    return datosWidget(
        context,
        'Teléfono',
        TextFormField(
          readOnly: true,
          controller: telefonoCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone_android_outlined,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget btnBuscarPersona(String tipo) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        /*if (identificacionFactCtrl.text.isEmpty) {
          mensajeError(context,
              'Ingrese la identificación de quien se emitirá la factura');
          return;
        }*/
        buscarPersona(tipo);
      },
    );
  }

  Widget btnProcesarPago() {
    return FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.5,
        child: Container(
          height: 45,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (!aceptaTerminosCondiciones) {
                    mensajeError(
                        context, 'Debe aceptar los términos y condiciones');
                    return;
                  }
                  doProcesarPago();
                }
              },
              child: Text(
                'Procesar solicitud',
              )),
        ));
  }

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

  List<Widget> motivosWidget() {
    List<Widget> choices = [];
    motivosSolicitudNoBienes.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          selectedColor: colorSecond.withOpacity(0.8),
          label: Text(
            item.data!,
            style: Theme.of(context).textTheme.headline6,
          ),
          selected: motivo == item,
          onSelected: (selected) {
            setState(() {
              motivo = (selected ? item : null)!;
            });
          },
        ),
      ));
    });
    return choices;
  }

  buscarPersona(String tipo) {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage = personaProvider!.buscarPersona(
        tipo == 'SOLICITANTE'
            ? identificacionCtrl.text
            : 'identificacionFactCtrl.text',
        tipo);

    successfulMessage.then((response) {
      print(response.toString());
      if (response['status']) {
        PubPersona persona = response['persona'];
        setState(() {
          if (tipo == 'SOLICITANTE') {
            identificacionCtrl.text = persona.cedRuc!;
            datosPersonaCtrl.text =
                (persona.apellidos ?? '') + ' ' + (persona.nombres ?? '');
            direccionCtrl.text = persona.direccion ?? '';
            telefonoCtrl.text = persona.telefono1 ?? '';
            correoCtrl.text = persona.correo1 ?? '';
            estadoCivilSol = persona.estadoCivil ?? '';
          } else {
            /*identificacionFactCtrl.text = persona.cedRuc!;
            datosPersonaFactCtrl.text =
                (persona.apellidos ?? '') + ' ' + (persona.nombres ?? '');
            direccionFactCtrl.text = persona.direccion ?? '';
            telefonoFactCtrl.text = persona.telefono1 ?? '';
            correoFactCtrl.text = persona.correo1 ?? '';*/
          }
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  doProcesarPago() {
    final Future<Map<String, dynamic>> successfulMessage = pagoProvider!
        .procesarPago(
            motivo,
            obsCtrl.text,
            identificacionCtrl.text,
            datosPersonaCtrl.text,
            direccionCtrl.text,
            telefonoCtrl.text,
            correoCtrl.text,
            estadoCivilSol,
            identificacionCtrl.text,
            datosPersonaCtrl.text,
            direccionCtrl.text,
            telefonoCtrl.text,
            correoCtrl.text,
            '',
            '',
            acto!,
            usuario!.id!,
            cantidadCtrl.text,
            '',
            '',
            '',
            '');

    successfulMessage.then((response) async {
      print(response.toString());
      if (response['status']) {
        Solicitud rest = response['data'];

        if (!rest.tipoPago! && rest.linkPago != null) {
          if (!isWeb) {
            var verificado = await Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) => PagoPage(
                      urlIframe: rest.payWithApp,
                    )));

            if (verificado != null) {
              mensajeError(
                context,
                'Debe proceder al pago para continuar con su solicitud',
              );
            }
          } else {
            await launch(rest.linkPago!,
                forceSafariVC: false,
                forceWebView: false,
                enableJavaScript: true,
                webOnlyWindowName: '_self');
            //js.context.callMethod('open', [rest.linkPago, '_self']);
          }
        } else {
          mensajeInfo(context,
              'Trámite ingresado correctamente, revise su correo electrónico');
        }
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
