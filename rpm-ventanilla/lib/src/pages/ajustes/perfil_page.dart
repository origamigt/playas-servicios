import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/perfil_provider.dart';
import 'package:playas/src/providers/persona_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class PerfilPage extends StatefulWidget {
  static const route = '/perfil';

  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  bool isWeb = UniversalPlatform.isWeb;
  UsuarioProvider? userProvider;
  PersonaProvider? personaProvider;
  PerfilProvider? perfilProvider;

  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();
  User? usuario;
  PubPersona? persona;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context);
    personaProvider = Provider.of<PersonaProvider>(context);
    perfilProvider = Provider.of<PerfilProvider>(context);
    this.personaProvider = personaProvider;
    userProvider!.initialize().then((value) {
      usuario = value;
      persona = usuario!.persona!;
      identificacionCtrl.text = persona!.cedRuc!;
      var nombres = persona!.nombres! + ' ' + persona!.apellidos!;
      datosPersonaCtrl.text = nombres;
      direccionCtrl.text = persona!.direccion!;
      telefonoCtrl.text = persona!.telefono1!;
      correoCtrl.text = persona!.correo1!;
    });

    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Perfil', isWeb),
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
            identificacionWidget(),
            nombresWidget(),
            direccionWidget(),
            telefonoWidget(),
            correoWidget(),
            SizedBox(
              height: 10,
            ),
            perfilProvider!.status == StatusPerfil.Searching
                ? loading("Actualizando datos...")
                : btnActualizar()
          ],
        ),
      ),
    );
  }

  Widget identificacionWidget() {
    return datosWidget(
      context,
      'Identificación',
      TextFormField(
        controller: identificacionCtrl,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone_android_outlined,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget btnActualizar() {
    return Align(
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          height: 45,
          child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  actualizarPersona();
                }
              },
              child: Text(
                'Actualizar perfil',
              )),
        ),
      ),
    );
  }

  void actualizarPersona() {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage = perfilProvider!.actualizarPerfil(
        identificacionCtrl.text,
        direccionCtrl.text,
        telefonoCtrl.text,
        correoCtrl.text,
        usuario!,
        persona!);
    successfulMessage.then((response) {
      if (response['status']) {
        mensajeInfo(context, response['message']);
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
