import 'package:auto_route/auto_route.dart';
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

class RecuperarForm extends StatefulWidget {
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

  RecuperarForm(
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
  RecuperarState createState() => RecuperarState();
}

class RecuperarState extends State<RecuperarForm> {
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  TextEditingController fechaCtrl = TextEditingController();
  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController claveCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();
  TextEditingController codigoCtrl = TextEditingController();

  AuthProvider? auth;
  String? _fecha;
  DateTime? selectedDate = DateTime.now();
  double? widthSize;
  UsuarioRegistro? usuario;
  double? heightSize;

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
                                StatusRegistro.CodigoEnviando ||
                            auth!.registeredInStatus ==
                                StatusRegistro.ValidarCodCargando ||
                            auth!.registeredInStatus ==
                                StatusRegistro.ValidarCodNoOk)
                        ? datosPersona()
                        : (auth!.registeredInStatus ==
                                    StatusRegistro.ValidarCodOk ||
                                auth!.registeredInStatus ==
                                    StatusRegistro.ClaveActualizando ||
                                auth!.registeredInStatus ==
                                    StatusRegistro.ClaveActualizada ||
                                auth!.registeredInStatus ==
                                    StatusRegistro.ClaveNoActualizada)
                            ? nuevaContrasenia()
                            : Container())));
  }

  Widget datosRegistro() {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.center,
          child: Text('Recuperar usuario',
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
          child: Text(
              'Fecha de expedición de si es cédula o fecha de inicio de actividades o si es RUC',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeTextField,
              ))),
      TextFormField(
          controller: fechaCtrl,
          onSaved: (value) => _fecha = value,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese la fecha de expedición de si es cédula o fecha de inicio de actividades o si es RUC';
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
            child: Text('Se envió un código de verficación a su correo',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
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
          maxLength: 5,
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
            ? loading('Validando código ... ')
            : btnValidarCodigo(),
        SizedBox(height: heightSize! * 0.01),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
      ],
    );
  }

  Widget nuevaContrasenia() {
    return Column(
      children: [
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Escriba su nueva contraseña',
                style: GoogleFonts.sourceCodePro(
                  fontSize: widthSize! * widget.fontSizeTextField,
                ))),
        TextFormField(
          controller: claveCtrl,
          obscureText: obscureText,
          style: TextStyle(fontSize: widget.fontSizeTextFormField),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Theme.of(context).primaryColor,
              size: widthSize! * widget.iconFormSize,
            ),
            suffixIcon: IconButton(
              icon: Icon(
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
        auth!.registeredInStatus == StatusRegistro.ClaveActualizando
            ? loading('Actualizando clave ... ')
            : btnActualizarClave(),
        SizedBox(height: heightSize! * widget.spaceBetweenFields),
      ],
    );
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

  Widget btnValidarCodigo() {
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
            print(codigoCtrl.text);
            if (codigoCtrl.text.isEmpty) {
              mensajeError(context,
                  'Debe ingresar el código de verificación para continuar');
              return;
            }
            if (codigoCtrl.text.length != 5) {
              mensajeError(context, 'Ingrese un código de valido');
              return;
            }
            validarCodigoRecuperar();
          },
          child: Text('Validar código',
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

  Widget btnActualizarClave() {
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
            if (claveCtrl.text.isEmpty) {
              mensajeError(context, 'Ingrese un su nueva clave');
              return;
            }
            if (claveCtrl.text.length < 5) {
              mensajeError(
                  context, 'Ingrese una nueva clave mayor a 5 digitos');
              return;
            }
            actualizarClave();
          },
          child: Text('Actualizar clave',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeButton,
              ))),
    );
  }

  buscarUsuario() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.buscarUsuario(identificacionCtrl.text, _fecha!, false);

    successfulMessage.then((response) {
      if (response['status']) {
        usuario = response['data'];

        setState(() {
          datosPersonaCtrl.text = usuario!.nombresCompletos!;
          correoCtrl.text = usuario!.correoCodificado!;
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  enviarCodigo() {
    final Future<Map<String, dynamic>> successfulMessage = auth!
        .enviarCodigoVerificacion(identificacionCtrl.text,
            datosPersonaCtrl.text, correoCtrl.text, '');

    successfulMessage.then((response) {
      if (response['status']) {
        CodigoVerificacion data = response['data'];
        setState(() {});
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  validarCodigoRecuperar() {
    final Future<Map<String, dynamic>> successfulMessage = auth!
        .validarCodigoRegistroUsuario(
            usuario!.correo!,
            codigoCtrl.text,
            usuario!.celular!,
            usuario!.identificacion!,
            '',
            '',
            usuario!.personaId!,
            true,
            'NORMAL',
            null);

    successfulMessage.then((response) {
      if (!response['status']) {
        mensajeError(context, response['message']);
      }
    });
  }

  actualizarClave() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.actualizarContrasenia(
      claveCtrl.text,
      usuario!.identificacion!,
    );

    successfulMessage.then((response) {
      if (response['status']) {
        mensajeInfo(context, 'Su usuario ha sido actualizado con éxito');
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  shape: borderDialog,
                  content: Text(
                    'Estimad@ ${datosPersonaCtrl.text} su usuario ha sido actualizado con éxito,\ninicie sesión nuevamente',
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
