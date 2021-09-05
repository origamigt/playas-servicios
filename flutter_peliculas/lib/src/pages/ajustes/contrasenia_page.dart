import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/persona_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';

class ContraseniaPage extends StatefulWidget {
  static const route = '/actualizarContrasenia';

  @override
  ContraseniaPageState createState() => ContraseniaPageState();
}

class ContraseniaPageState extends State<ContraseniaPage> {
  UsuarioProvider? userProvider;
  PersonaProvider? personaProvider;

  User? usuario;

  String? identificacion;
  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController claveActualCtrl = TextEditingController();
  TextEditingController claveNuevaCtrl = TextEditingController();
  TextEditingController claveConfirmaCtrl = TextEditingController();

  bool mostrarClaveActual = false;
  bool mostrarClaveNueva = false;
  bool mostrarClaveVerifica = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UsuarioProvider>(context);
    personaProvider = Provider.of<PersonaProvider>(context);
    this.personaProvider = personaProvider;
    if (userProvider != null && userProvider!.user != null) {
      usuario = userProvider!.user!;
      PubPersona persona = usuario!.persona!;
      identificacion = persona.cedRuc;
      identificacionCtrl.text = identificacion!;
      var nombres = persona.nombres! + ' ' + persona.apellidos!;
      datosPersonaCtrl.text = nombres;
    }
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Actualizar contraseña'),
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
            claveActualWidget(),
            claveNuevaWidget(),
            verificaNuevaClaveWidget(),
            SizedBox(
              height: 10,
            ),
            btnActualizar()
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
        readOnly: true,
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

  Widget claveActualWidget() {
    return datosWidget(
        context,
        'Ingrese su clave actual',
        TextFormField(
          controller: claveActualCtrl,
          obscureText: !mostrarClaveActual,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                if (!mostrarClaveActual) {
                  setState(() {
                    mostrarClaveActual = true;
                  });
                } else {
                  setState(() {
                    mostrarClaveActual = false;
                  });
                }
              },
              icon: Icon(
                mostrarClaveActual
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
              ),
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget claveNuevaWidget() {
    return datosWidget(
        context,
        'Escriba su nueva clave',
        TextFormField(
          controller: claveNuevaCtrl,
          obscureText: !mostrarClaveNueva,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Escriba su nueva clave!';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                if (!mostrarClaveNueva) {
                  setState(() {
                    mostrarClaveNueva = true;
                  });
                } else {
                  setState(() {
                    mostrarClaveNueva = false;
                  });
                }
              },
              icon: Icon(
                mostrarClaveNueva
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
              ),
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget verificaNuevaClaveWidget() {
    return datosWidget(
        context,
        'Repita su nueva clave',
        TextFormField(
          controller: claveConfirmaCtrl,
          obscureText: !mostrarClaveVerifica,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Repita su nueva clave!';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                if (!mostrarClaveVerifica) {
                  setState(() {
                    mostrarClaveVerifica = true;
                  });
                } else {
                  setState(() {
                    mostrarClaveVerifica = false;
                  });
                }
              },
              icon: Icon(
                mostrarClaveVerifica
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
              ),
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
                  //    doLogin();
                }
              },
              child: Text(
                'Actualizar contraseña',
              )),
        ),
      ),
    );
  }
}