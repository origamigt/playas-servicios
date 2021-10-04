import 'dart:js' as js;

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
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class PropiedadPage extends StatefulWidget {
  static const String route = '/propiedad';

  @override
  PropiedadPageState createState() => PropiedadPageState();
}

class PropiedadPageState extends State<PropiedadPage> {
  bool isWeb = UniversalPlatform.isWeb;

  Acto? acto;
  UsuarioProvider? userProvider;
  PersonaProvider? personaProvider;
  PagoProvider? pagoProvider;

  String? _tipoPropiedad;

  TextEditingController cantidadCtrl = TextEditingController();

  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();

  //TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();

  /*TextEditingController identificacionFactCtrl = TextEditingController();
  TextEditingController datosPersonaFactCtrl = TextEditingController();
  TextEditingController direccionFactCtrl = TextEditingController();
  TextEditingController telefonoFactCtrl = TextEditingController();
  TextEditingController correoFactCtrl = TextEditingController();*/

  TextEditingController obsCtrl = TextEditingController();
  TextEditingController otroMotivoCtrl = TextEditingController();

  TextEditingController identificacionPropCtrl = TextEditingController();
  TextEditingController datosPersonaPropCtrl = TextEditingController();
  TextEditingController anioInscripcionCtrl = TextEditingController();
  TextEditingController numeroInscripcionCtrl = TextEditingController();
  TextEditingController numeroFichaCtrl = TextEditingController();

  String estadoCivilSol = '';
  User? usuario;
  PubPersona? persona;
  final _formKey = GlobalKey<FormState>();

  Data motivo = motivosSolicitud[0];

  final _actosProvider = ActosProvider();
  double? total;

  @override
  void initState() {
    super.initState();
    cargarActo();
  }

  cargarActo() async {
    acto = await _actosProvider.findActoId(1357);
    total = acto!.valor;
    /*cantidadCtrl.addListener(() {
      try {
        print(cantidadCtrl.text);
        if (cantidadCtrl.text.isNotEmpty) {
          double? v = double.parse(cantidadCtrl.text);
          total = acto!.valor! * v;
        }
        ;
      } catch (e) {
        print(e);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    cantidadCtrl.text = '1';
    userProvider = Provider.of<UsuarioProvider>(context);
    personaProvider = Provider.of<PersonaProvider>(context);
    pagoProvider = Provider.of<PagoProvider>(context);
    if (userProvider != null) {
      userProvider!.initialize().then((value) {
        usuario = value;
        persona = usuario!.persona!;

        identificacionCtrl.text = persona!.cedRuc!;
        var nombres = persona!.nombres! + ' ' + persona!.apellidos!;
        datosPersonaCtrl.text = nombres;
        //direccionCtrl.text = persona.direccion!;
        telefonoCtrl.text = persona!.telefono1!;
        correoCtrl.text = persona!.correo1!;

        /*identificacionFactCtrl.text = persona!.cedRuc!;
        datosPersonaFactCtrl.text = nombres;
        direccionFactCtrl.text = persona!.direccion!;
        telefonoFactCtrl.text = persona!.telefono1!;
        correoFactCtrl.text = persona!.correo1!;*/
      });
    }
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Certificado de Historia de Dominio'),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tituloWidget(context, 'Motivo de la solicitud'),
            Wrap(
              children: motivosWidget(),
            ),
            motivo.id == 116
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
            tituloWidget(context, 'Datos de la propiedad'),
            identificacionPropWidget(),
            nombresPropWidget(),
            tiposPropiedad(),
            numeroFichaWidget(),
            numeroInscripcionWidget(),
            anioInscripcionWidget(),
            /*tituloWidget(context, 'Datos de la factura'),
            identificacionFactWidget(),
            nombresFactWidget(),
            direccionFactWidget(),
            telefonoFactWidget(),
            correoFactWidget(),*/
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
            if (motivo.id == 116 && value!.isEmpty) {
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese alguna observación a su solicitud';
            }
          },
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

  /* Widget direccionWidget() {
    return datosWidget(
        context,
        'Dirección',
        TextFormField(
          controller: direccionCtrl,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese la dirección del solicitante';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.gps_fixed,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }
*/
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

  Widget identificacionFactWidget() {
    return datosWidget(
      context,
      'Identificación',
      TextFormField(
        //controller: identificacionFactCtrl,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
          ),
          suffixIcon: personaProvider!.personaStatusPersonProv ==
                  StatusPersonProv.SearchingFact
              ? loading("...")
              : btnBuscarPersona('FACTURA'),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget nombresFactWidget() {
    return datosWidget(
        context,
        'Datos personales',
        TextFormField(
          //controller: datosPersonaFactCtrl,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese los nombres para la factura';
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

  Widget direccionFactWidget() {
    return datosWidget(
        context,
        'Dirección',
        TextFormField(
          //controller: direccionFactCtrl,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese la dirección para la factura';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.gps_fixed,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget correoFactWidget() {
    return datosWidget(
        context,
        'Correo electrónico',
        TextFormField(
          //controller: correoFactCtrl,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese un correo electrónico para la factura';
            }
          },
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.start,
        ));
  }

  Widget telefonoFactWidget() {
    return datosWidget(
        context,
        'Teléfono',
        TextFormField(
          //controller: telefonoFactCtrl,
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
        if (tipo == 'PROPIETARIO') {
          if (identificacionCtrl.text.isEmpty) {
            mensajeError(context, 'Ingrese la identificación del propietario');
            return;
          }
        } else {
          /*if (identificacionFactCtrl.text.isEmpty) {
            mensajeError(context,
                'Ingrese la identificación de quien se emitirá la factura');
            return;
          }*/
        }
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
                  doProcesarPago();
                }
              },
              child: Text(
                'Procesar pago',
              )),
        ));
  }

  Widget tiposPropiedad() {
    return datosWidget(
        context,
        'Escoja el tipo de propiedad',
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: _tipoPropiedad,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: <String>[
              'Terreno',
              'Casa',
              'Departamento',
              'Parqueadero',
              'Propiedad horizontal',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            hint: Text(
              'Escoja el tipo de propiedad',
            ),
            onChanged: (String? value) {
              setState(() {
                _tipoPropiedad = value;
              });
            },
          ),
        ));
  }

  Widget identificacionPropWidget() {
    return datosWidget(
      context,
      'Identificación',
      TextFormField(
        controller: identificacionPropCtrl,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ingrese la identificación del propietario';
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
          ),
          suffixIcon: personaProvider!.personaStatusPersonProv ==
                  StatusPersonProv.SearchingFact
              ? loading("...")
              : btnBuscarPersona('PROPIETARIO'),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget nombresPropWidget() {
    return datosWidget(
        context,
        'Datos personales',
        TextFormField(
          controller: datosPersonaPropCtrl,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese los nombres del propietario';
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

  Widget numeroFichaWidget() {
    return datosWidget(
        context,
        'Ficha registral',
        TextFormField(
          controller: numeroFichaCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.animation,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget numeroInscripcionWidget() {
    return datosWidget(
        context,
        'Número de inscripción',
        TextFormField(
          controller: numeroInscripcionCtrl,
          maxLength: 5,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.add_road_sharp,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget anioInscripcionWidget() {
    return datosWidget(
        context,
        'Año de inscripción',
        TextFormField(
          controller: anioInscripcionCtrl,
          maxLength: 4,
          validator: (value) {
            if (value!.isNotEmpty && value.length != 4) {
              return 'Debe ingresar un año valido';
            }
          },
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  doProcesarPago() {
    print('doProcesarPago');
    final Future<Map<String, dynamic>> successfulMessage = pagoProvider!
        .procesarPago(
            motivo,
            obsCtrl.text,
            identificacionCtrl.text,
            datosPersonaCtrl.text,
            persona!.direccion!,
            telefonoCtrl.text,
            correoCtrl.text,
            estadoCivilSol,
            identificacionCtrl.text,
            datosPersonaCtrl.text,
            persona!.direccion!,
            telefonoCtrl.text,
            correoCtrl.text,
            identificacionPropCtrl.text,
            datosPersonaPropCtrl.text,
            acto!,
            usuario!.id!,
            cantidadCtrl.text);

    successfulMessage.then((response) async {
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

  List<Widget> motivosWidget() {
    List<Widget> choices = [];
    motivosSolicitud.forEach((item) {
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
        tipo == 'PROPIETARIO'
            ? identificacionPropCtrl.text
            : 'identificacionFactCtrl.text',
        tipo);

    successfulMessage.then((response) {
      if (response['status']) {
        PubPersona p = response['persona'];
        setState(() {
          if (tipo == 'PROPIETARIO') {
            identificacionPropCtrl.text = p.cedRuc!;
            datosPersonaPropCtrl.text =
                (p.apellidos ?? '') + ' ' + (p.nombres ?? '');
          } else {
            /*identificacionFactCtrl.text = 'p.cedRuc!';
            datosPersonaFactCtrl.text =
                (p.apellidos ?? '') + ' ' + (p.nombres ?? '');
            direccionFactCtrl.text = p.direccion ?? '';
            telefonoFactCtrl.text = p.telefono1 ?? '';
            correoFactCtrl.text = p.correo1 ?? '';*/
          }
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
