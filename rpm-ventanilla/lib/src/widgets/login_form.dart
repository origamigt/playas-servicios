import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/pages/login/registrarse_page.dart';
import 'package:playas/src/providers/auth_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class LoginForm extends StatelessWidget {
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

  /*@override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {*/
  final _formKey = GlobalKey<FormState>();
  BuildContext? context;
  AuthProvider? auth;
  String? _username, _password;
  double? widthSize;

  double? heightSize;

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
              child: Column(children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Identificación',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: widthSize! * fontSizeTextField,
                    ))),
            TextFormField(
              onSaved: (value) => _username = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingrese su identificación!';
                }
              },
              style: TextStyle(
                  color: Colors.black, fontSize: fontSizeTextFormField),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  size: widthSize! * iconFormSize,
                ),
                errorStyle: TextStyle(
                    color: Colors.white,
                    fontSize: widthSize! * errorFormMessage),
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: heightSize! * spaceBetweenFields),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Contraseña',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: widthSize! * fontSizeTextField,
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
                    size: widthSize! * iconFormSize,
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: widthSize! * errorFormMessage),
                ),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: fontSizeTextFormField,
                  color: Colors.black,
                )),
            SizedBox(height: heightSize! * spaceBetweenFieldAndButton),
            auth!.loggedInStatus == Status.Authenticating
                ? loading("Iniciando sesión...")
                : btnLogin(),
            SizedBox(height: heightSize! * 0.01),
            Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      //RpmApplication.router.navigateTo(context, RegistrarsePage.route);
                      //context.vRouter.push('/home');
                      context.vRouter.to(RegistrarsePage.route);
                    },
                    child: Text('Registrarse',
                        style: GoogleFonts.sourceCodePro(
                            fontSize: widthSize! * fontSizeForgotPassword,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!)))),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    context.vRouter.to(RegistrarsePage.route);
                  },
                  child: Text('Recuperar contraseña',
                      style: GoogleFonts.sourceCodePro(
                          fontSize: widthSize! * fontSizeForgotPassword,
                          fontWeight: FontWeight.w900,
                          color:
                              Theme.of(context).textTheme.bodyText1!.color!))),
            ),
          ])),
        ));
  }

  Widget btnLogin() {
    return Container(
      height: 45,
      width: MediaQuery.of(context!).size.width,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context!).primaryColor),
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
                fontSize: widthSize! * fontSizeButton,
              ))),
    );
  }

  doLogin() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth!.login(_username!, _password!);

    successfulMessage.then((response) {
      print(response.toString());
      if (response['status']) {
        User user = response['user'];
        Provider.of<UsuarioProvider>(context!, listen: false).setUser(user);
        context!.vRouter.to(HomePage.route);
      } else {
        mensajeError(context!, response['message']);
      }
    });
  }
}
