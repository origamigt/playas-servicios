import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/models/usuario_registro.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

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

  final UsuarioRegistro usuarioRegistro;

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
      this.errorFormMessage,
      this.usuarioRegistro);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<RegistrarseForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerFecha = TextEditingController();
  AuthProvider? auth;
  String? _identificacion, _fecha;
  DateTime? selectedDate = DateTime.now();
  double? widthSize;

  double? heightSize;

  @override
  Widget build(BuildContext context) {
    //this.context = context;
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
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Bienvenido ${widget.usuarioRegistro.nombresCompletos}',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize! * widget.fontSizeTextField,
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Celular',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize! * widget.fontSizeTextField,
                      ))),
              TextFormField(
                onSaved: (value) => _identificacion = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su número de celular!';
                  }
                },
                //textInputAction: Input.phone,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.fontSizeTextFormField),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android,
                    size: widthSize! * widget.iconFormSize,
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(
                      color: Colors.white,
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
                  controller: _controllerFecha,
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
                        size: widthSize! * widget.iconFormSize,
                      ),
                      onPressed: () async {
                        _selectDate(context);
                      },
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize! * widget.errorFormMessage),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: widget.fontSizeTextFormField,
                    color: Colors.white,
                  )),
              SizedBox(height: heightSize! * widget.spaceBetweenFieldAndButton),
              auth!.loggedInStatus == Status.Authenticating
                  ? loading()
                  : btnContinuar(),
              SizedBox(height: heightSize! * 0.01),
            ])));
  }

  buscarUsuario() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.buscarUsuario(_identificacion!, _fecha!);

    successfulMessage.then((response) {
      print(response.toString());
      if (response['status']) {
        User user = response['user'];
        Provider.of<UsuarioProvider>(context, listen: false).setUser(user);
        context.vRouter.to(HomePage.route);
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  Widget loading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Buscando datos ... Por favor espere")
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        confirmText: 'ACEPTAR',
        cancelText: 'CANCELAR',
        initialDate: selectedDate!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _fecha = DateFormat('yyyy-MM-dd').format(selectedDate!);
        _controllerFecha.text = _fecha!;
      });
    }
  }
}
