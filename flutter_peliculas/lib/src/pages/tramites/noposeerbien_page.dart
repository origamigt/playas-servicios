import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/providers/persona_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';

class NoposeerBienPage extends StatefulWidget {
  static const String route = '/noposeerbien';

  @override
  NoposeerBienState createState() => NoposeerBienState();
}

class NoposeerBienState extends State<NoposeerBienPage> {
  UsuarioProvider? userProvider;
  PersonaProvider? personaProvider;

  String? identificacion;
  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();

  TextEditingController identificacionFactCtrl = TextEditingController();
  TextEditingController datosPersonaFactCtrl = TextEditingController();
  TextEditingController direccionFactCtrl = TextEditingController();
  TextEditingController telefonoFactCtrl = TextEditingController();
  TextEditingController correoFactCtrl = TextEditingController();

  TextEditingController obsCtrl = TextEditingController();
  TextEditingController otroMotivoCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Data motivo = motivosSolicitud[0];

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context);
    personaProvider = Provider.of<PersonaProvider>(context);
    this.personaProvider = personaProvider;
    if (userProvider != null && userProvider!.user != null) {
      PubPersona persona = userProvider!.user!.persona!;
      identificacion = persona.cedRuc;
      identificacionCtrl.text = identificacion!;
      var nombres = persona.nombres! + ' ' + persona.apellidos!;
      datosPersonaCtrl.text = nombres;
      direccionCtrl.text = persona.direccion!;
      telefonoCtrl.text = persona.telefono1!;
      correoCtrl.text = persona.correo1!;
    }
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Certificado de no poseer bienes'),
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
            observacionWidget(),
            tituloWidget(context, 'Datos del solicitante'),
            identificacionWidget(),
            nombresWidget(),
            direccionWidget(),
            telefonoWidget(),
            correoWidget(),
            tituloWidget(context, 'Datos de la factura'),
            identificacionFactWidget(),
            nombresFactWidget(),
            direccionFactWidget(),
            telefonoFactWidget(),
            correoFactWidget(),
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
        controller: identificacionCtrl,
        onSaved: (value) => identificacion = value,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
          ),
          suffixIcon: personaProvider!.personaStatusPersonProv ==
                  StatusPersonProv.Searching
              ? loading("...")
              : btnBuscarPersona('SOLICITANTE'),
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
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.accessibility,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget direccionWidget() {
    return datosWidget(
        context,
        'Dirección',
        TextFormField(
          controller: direccionCtrl,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.gps_fixed,
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
        controller: identificacionFactCtrl,
        onSaved: (value) => identificacion = value,
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
          controller: datosPersonaFactCtrl,
          readOnly: true,
          keyboardType: TextInputType.number,
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
          controller: direccionFactCtrl,
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
          controller: correoFactCtrl,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.start,
        ));
  }

  Widget telefonoFactWidget() {
    return datosWidget(
        context,
        'Teléfono',
        TextFormField(
          controller: telefonoFactCtrl,
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
        if (tipo == 'SOLICITANTE') {
          if (identificacionCtrl.text.isEmpty) {
            mensajeError(context, 'Ingrese la identificación del solicitante');
            return;
          }
        } else {
          if (identificacionFactCtrl.text.isEmpty) {
            mensajeError(context,
                'Ingrese la identificación de quien se emitirá la factura');
            return;
          }
        }
        buscarPersona(tipo);
      },
    );
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
        tipo == 'SOLICITANTE'
            ? identificacionCtrl.text
            : identificacionFactCtrl.text,
        tipo);

    successfulMessage.then((response) {
      print(response.toString());
      if (response['status']) {
        PubPersona persona = response['persona'];
        print(persona.cedRuc);
        if (tipo == 'SOLICITANTE') {
          identificacionCtrl.text = persona.cedRuc!;
          datosPersonaCtrl.text =
              (persona.nombres ?? '') + ' ' + (persona.apellidos ?? '');
          direccionCtrl.text = persona.direccion ?? '';
          telefonoCtrl.text = persona.telefono1 ?? '';
          correoCtrl.text = persona.correo1 ?? '';
        }
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
