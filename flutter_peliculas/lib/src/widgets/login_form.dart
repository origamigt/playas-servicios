import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/user_provider.dart';
import 'package:playas/src/routes/rpm_application.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
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
  final _formKey = GlobalKey<FormState>();

  AuthProvider? auth;
  String? _username, _password;
  double? widthSize;

  double? heightSize;

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthProvider>(context);
    widthSize = MediaQuery.of(context).size.width;
    heightSize = MediaQuery.of(context).size.height;
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

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
                  child: Text('Identificación',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize! * widget.fontSizeTextField,
                      ))),
              TextFormField(
                onSaved: (value) => _username = value,
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
                  child: Text('Contraseña',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize! * widget.fontSizeTextField,
                      ))),
              TextFormField(
                  onSaved: (value) => _password = value,
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
                      size: widthSize! * widget.iconFormSize,
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
                  ? loading
                  : btnLogin(),
              SizedBox(height: heightSize! * 0.01),
              Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text('Registrarse',
                          style: GoogleFonts.sourceCodePro(
                              fontSize:
                                  widthSize! * widget.fontSizeForgotPassword,
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
                            fontSize:
                                widthSize! * widget.fontSizeForgotPassword,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!))),
              ),
            ])));
  }

  doLogin() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.login(_username!, _password!);

    successfulMessage.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        RpmApplication.router.navigateTo(context, HomePage.route);
      } else {
        mensajeError(context, response['message'].toString());
      }
    });
  }

  Widget loading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );
  }

  Widget btnLogin() {
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
              doLogin();
            }
          },
          child: Text('Ingresar',
              style: GoogleFonts.sourceCodePro(
                fontSize: widthSize! * widget.fontSizeButton,
              ))),
    );
  }
}
