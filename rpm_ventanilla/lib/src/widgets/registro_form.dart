import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/models/codigo.dart';
import 'package:playas/src/models/usuario_registro.dart';
import 'package:playas/src/pages/login/login_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
class RegistrarseForm extends StatefulWidget {
  final paddingTopForm,
      fontSizeTextField,
      fontSizeTextFormField,
      spaceBetweenFields,
      iconFormSize;
  final spaceBetweenFieldAndButton,
      widthButton,
      fontSizeButton,
      fontSizeForgotPassword,
      fontSizeSnackBar,
      errorFormMessage;

  RegistrarseForm(
      this.paddingTopForm,
      this.fontSizeTextField,
      this.fontSizeTextFormField,
      this.spaceBetweenFields,
      this.iconFormSize,
      this.spaceBetweenFieldAndButton,
      this.widthButton,
      this.fontSizeButton,
      this.fontSizeForgotPassword,
      this.fontSizeSnackBar,
      this.errorFormMessage);

  @override
  RegistrarseFormState createState() => RegistrarseFormState();
}

class RegistrarseFormState extends State<RegistrarseForm>
    with AfterLayoutMixin<RegistrarseForm> {
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  TextEditingController fechaCtrl = TextEditingController();
  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController claveCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();
  TextEditingController codigoCtrl = TextEditingController();

  AuthProvider? auth;
  String? _fecha;
  DateTime? selectedDate = DateTime.now();
  double? widthSize;
  UsuarioRegistro? usuario;
  double? heightSize;

  @override
  void afterFirstLayout(BuildContext context) {
    auth!.setRegisterState(StatusRegistro.Unknown);
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthProvider>(context);

    widthSize = MediaQuery.of(context).size.width;
    heightSize = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(
              left: widthSize! * 0.05,
              right: widthSize! * 0.05,
            ),
            child: SingleChildScrollView(
                child: (auth!.registeredInStatus == StatusRegistro.Unknown ||
                        auth!.registeredInStatus == StatusRegistro.Registering)
                    ? datosRegistro()
                    : (auth!.registeredInStatus ==
                                StatusRegistro.NotRegistered ||
                            auth!.registeredInStatus ==
                                StatusRegistro.CodigoEnviando)
                        ? datosPersona()
                        : auth!.registeredInStatus ==
                                StatusRegistro.CodigoEnviado
                            ? datosVerificacion()
                            : Container())));
  }

  Widget datosRegistro() {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.center,
          child: Text('Registrarse',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeTextField,
              ))),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Identificación',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeTextField,
              ))),
      TextFormField(
        controller: identificacionCtrl,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ingrese su identificación!';
          }
        },
        style: TextStyle(fontSize: widget.fontSizeTextFormField),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
            size: widthSize! * widget.iconFormSize,
          ),
          labelStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(
              color: Colors.red,
              fontSize: widthSize! * widget.errorFormMessage),
        ),
        textAlign: TextAlign.start,
      ),
      SizedBox(height: heightSize! * widget.spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Escriba una contraseña',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeTextField,
              ))),
      TextFormField(
        controller: claveCtrl,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ingrese una contraseña!';
          }
        },
        style: TextStyle(fontSize: widget.fontSizeTextFormField),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Theme.of(context).primaryColor,
            size: widthSize! * widget.iconFormSize,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
        textAlign: TextAlign.start,
      ),
      SizedBox(height: heightSize! * widget.spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
              'Fecha de expedición de si es cédula o fecha de inicio de actividades si es RUC',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeTextField,
              ))),
      TextFormField(
          controller: fechaCtrl,
          onSaved: (value) => _fecha = value,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese la fecha de expedición de si es cédula o fecha de inicio de actividades si es RUC';
            }
          },
          readOnly: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(
                Icons.date_range,
                color: Theme.of(context).primaryColor,
                size: widthSize! * widget.iconFormSize,
              ),
              onPressed: () async {
                _selectDate(context);
              },
            ),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.red,
                fontSize: widthSize! * widget.errorFormMessage),
          ),
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: widget.fontSizeTextFormField,
          )),
      SizedBox(height: heightSize! * widget.spaceBetweenFieldAndButton),
      auth!.registeredInStatus == StatusRegistro.Registering
          ? loading('Buscando datos ... ')
          : btnContinuar(),
      SizedBox(height: heightSize! * widget.spaceBetweenFieldAndButton),
    ]);
  }

  Widget datosPersona() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Datos personales',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        TextFormField(
          controller: datosPersonaCtrl,
          readOnly: true,
          style: TextStyle(fontSize: widget.fontSizeTextFormField),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: widthSize! * widget.iconFormSize,
            ),
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Dirección',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        TextFormField(
          controller: direccionCtrl,
          style: TextStyle(fontSize: widget.fontSizeTextFormField),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.gps_fixed,
              color: Theme.of(context).primaryColor,
              size: widthSize! * widget.iconFormSize,
            ),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.red,
                fontSize: widthSize! * widget.errorFormMessage),
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Celular',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        TextFormField(
          controller: telefonoCtrl,
          style: TextStyle(fontSize: widget.fontSizeTextFormField),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              color: Theme.of(context).primaryColor,
              size: widthSize! * widget.iconFormSize,
            ),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.red,
                fontSize: widthSize! * widget.errorFormMessage),
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Correo',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        TextFormField(
          controller: correoCtrl,
          style: TextStyle(fontSize: widget.fontSizeTextFormField),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Theme.of(context).primaryColor,
              size: widthSize! * widget.iconFormSize,
            ),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.red,
                fontSize: widthSize! * widget.errorFormMessage),
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
                'A continuación se enviará un código de verficación a su correo',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
        auth!.registeredInStatus == StatusRegistro.CodigoEnviando
            ? loading('Enviando código ... ')
            : btnEnviarCodigo(),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
      ],
    );
  }

  Widget datosVerificacion() {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Ingrese el código de verificación',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeTextField,
              ))),
      TextFormField(
        controller: codigoCtrl,
        style: TextStyle(fontSize: widget.fontSizeTextFormField),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.confirmation_num_outlined,
            color: Theme.of(context).primaryColor,
            size: widthSize! * widget.iconFormSize,
          ),
        ),
        textAlign: TextAlign.start,
      ),
      SizedBox(height: heightSize! * widget.spaceBetweenFieldAndButton),
      auth!.registeredInStatus == StatusRegistro.ValidarCodCargando
          ? loading('Registrando usuario ... ')
          : btnRegistrar(),
      SizedBox(height: heightSize! * 0.01),
    ]);
  }

  Widget btnContinuar() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
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
              buscarUsuario();
            }
          },
          child: Text('Continuar',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeButton,
              ))),
    );
  }

  Widget btnEnviarCodigo() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
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
            if (direccionCtrl.text.isEmpty) {
              mensajeError(
                  context, 'Debe ingresar una dirección para continuar');
              return;
            }
            if (correoCtrl.text.isEmpty) {
              mensajeError(context,
                  'Debe ingresar un correo electrónico para continuar');
              return;
            }
            enviarCodigo();
          },
          child: Text('Enviar código de verificación',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeButton,
              ))),
    );
  }

  Widget btnRegistrar() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
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
            if (codigoCtrl.text.isEmpty) {
              mensajeError(context,
                  'Debe ingresar el código de verificación para continuar');
              return;
            }
            registarUsuario();
          },
          child: Text('Registrar usuario',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeButton,
              ))),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        confirmText: 'ACEPTAR',
        cancelText: 'CANCELAR',
        locale: const Locale("es", "ES"),
        initialDate: selectedDate!,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _fecha = DateFormat('yyyy-MM-dd').format(selectedDate!);
        fechaCtrl.text = _fecha!;
      });
    }
  }

  buscarUsuario() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.buscarUsuario(identificacionCtrl.text, _fecha!, true);

    successfulMessage.then((response) {
      if (response['status']) {
        usuario = response['data'];
        setState(() {
          datosPersonaCtrl.text = usuario!.nombresCompletos!;
          direccionCtrl.text = usuario!.direccion!;
          telefonoCtrl.text = usuario!.celular!;
          correoCtrl.text = usuario!.correo!;
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  enviarCodigo() {
    final Future<Map<String, dynamic>> successfulMessage = auth!
        .enviarCodigoVerificacion(identificacionCtrl.text,
            datosPersonaCtrl.text, correoCtrl.text, telefonoCtrl.text);

    successfulMessage.then((response) {
      if (response['status']) {
        CodigoVerificacion data = response['data'];
        setState(() {});
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  registarUsuario() {
    final Future<Map<String, dynamic>> successfulMessage = auth!
        .validarCodigoRegistroUsuario(
            correoCtrl.text,
            codigoCtrl.text,
            telefonoCtrl.text,
            identificacionCtrl.text,
            direccionCtrl.text,
            claveCtrl.text,
            usuario!.personaId!,
            false,
            'NORMAL',
            null);

    successfulMessage.then((response) {
      if (response['status']) {
        mensajeInfo(context, 'Su usuario ha sido creado con éxito');
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  shape: borderDialog,
                  content: Text(
                    'Estimad@ ${datosPersonaCtrl.text} su usuario ha sido creado con éxito puede ingresar '
                    'con su número de cédula o ruc y su clave que registro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  actions: <Widget>[
                    Center(
                      child: ElevatedButton(
                        child: Text("Aceptar",
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                        onPressed: () async {
                          context.router.navigateNamed(LoginPage.route);
                        },
                      ),
                    )
                  ]);
            });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
