import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/iniciosesion_provider.dart';
import 'package:playas/src/routes/rpm_application.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

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

  LoginForm(
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
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Form(
        key: widget._formKey,
        child: Padding(
            padding: EdgeInsets.only(
              left: widthSize * 0.05,
              right: widthSize * 0.05,
            ),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Identificación',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize * widget.fontSizeTextField,
                      ))),
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su identificación!';
                  }
                },
                style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.fontSizeTextFormField),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    size: widthSize * widget.iconFormSize,
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: widthSize * widget.errorFormMessage),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: heightSize * widget.spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Contraseña',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize * widget.fontSizeTextField,
                      ))),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su contraseña para continuar!';
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      size: widthSize * widget.iconFormSize,
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize * widget.errorFormMessage),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: widget.fontSizeTextFormField,
                    color: Colors.white,
                  )),
              SizedBox(height: heightSize * widget.spaceBetweenFieldAndButton),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                    ),
                    onPressed: () async {
                      if (widget._formKey.currentState!.validate()) {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );*/
                        //Navigator.pushNamed(context, HomePage.route);
                        RpmApplication.router
                            .navigateTo(context, HomePage.route);
                        iniciarSesion();
                      }
                    },
                    child: Text('Ingresar',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: widthSize * widget.fontSizeButton,
                        ))),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text('Registrarse',
                          style: GoogleFonts.sourceCodePro(
                              fontSize:
                                  widthSize * widget.fontSizeForgotPassword,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!)))),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text('Recuperar contraseña',
                        style: GoogleFonts.sourceCodePro(
                            fontSize: widthSize * widget.fontSizeForgotPassword,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!))),
              ),
            ])));
  }

  void iniciarSesion() async {
    InicioSesionState _providerState =
        Provider.of<InicioSesionState>(context, listen: false);
    try {
      if (await _providerState.LoginUser(
          _usernameController.text, _passwordController.text)) {
        RpmApplication.router.navigateTo(context, HomePage.route);
      }
    } catch (e) {
      print(e);
    }
  }
}
