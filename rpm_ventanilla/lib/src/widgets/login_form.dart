import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/menu-login-card.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

//class LoginForm extends StatelessWidget {
class LoginForm extends StatefulWidget {
  bool isWeb = UniversalPlatform.isWeb;
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
  //BuildContext? context;
  AuthProvider? auth;

  //String? _username, _password;
  double? widthSize;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  double? heightSize;
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);

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
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
                child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Text('Iniciar sesión',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize! * widget.fontSizeTextField,
                      ))),
              SizedBox(height: 15),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Identificación',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widthSize! * widget.fontSizeTextField,
                      ))),
              TextFormField(
                //  key: _k1,
                controller: _username,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su identificación!';
                  }
                },
                style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.fontSizeTextFormField),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    size: widthSize! * widget.iconFormSize,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.red,
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
                  //key: _k2,
                  controller: _password,
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
                        color: Colors.red,
                        fontSize: widthSize! * widget.errorFormMessage),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: widget.fontSizeTextFormField,
                    color: Colors.black,
                  )),
              SizedBox(height: heightSize! * widget.spaceBetweenFieldAndButton),
              auth!.loggedInStatus == Status.Authenticating
                  ? loading("Iniciando sesión...")
                  : btnLogin(),
              SizedBox(height: heightSize! * 0.02),
              MenuLoginCard(
                menus: menusLogin,
              ),
              SizedBox(height: heightSize! * 0.02),
            ])),
          ),
        ));
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

  doLogin() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.login(_username.text, _password.text);

    successfulMessage.then((response) {
      print(response.toString());
      if (response['status']) {
        User user = response['user'];
        Provider.of<UsuarioProvider>(context, listen: false).setUser(user);
        context.router.navigateNamed(HomePage.route);
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
