import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/routes/rpm_application.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Form(
        key: _formKey,
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
                        fontSize: widthSize * fontSizeTextField,
                      ))),
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su identificación!';
                  }
                },
                style: TextStyle(
                    color: Colors.white, fontSize: fontSizeTextFormField),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    size: widthSize * iconFormSize,
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: widthSize * errorFormMessage),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Contraseña',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize * fontSizeTextField,
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
                      size: widthSize * iconFormSize,
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widthSize * errorFormMessage),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: fontSizeTextFormField,
                    color: Colors.white,
                  )),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
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
                      if (_formKey.currentState!.validate()) {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );*/
                        //Navigator.pushNamed(context, HomePage.route);
                        RpmApplication.router
                            .navigateTo(context, HomePage.route);
                      }
                    },
                    child: Text('Ingresar',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: widthSize * fontSizeButton,
                        ))),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text('Registrarse',
                          style: GoogleFonts.sourceCodePro(
                              fontSize: widthSize * fontSizeForgotPassword,
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
                            fontSize: widthSize * fontSizeForgotPassword,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!))),
              ),
            ])));
  }
}
