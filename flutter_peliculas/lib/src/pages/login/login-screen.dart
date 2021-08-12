import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/pages/home_page.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title:
          'Registro Municipal de la\nPropiedad y Mercantil del Cantón Playas',
      logo: 'assets/images/logo.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
          userHint: 'Identificación',
          passwordHint: 'Contraseña',
          confirmPasswordHint: 'Confirmar contrasela',
          loginButton: 'Iniciar sesión',
          signupButton: 'Registrarse',
          forgotPasswordButton: 'Recuperar contraseña',
          recoverPasswordButton: 'HELP ME',
          goBackButton: 'Regresar',
          confirmPasswordError: 'Not match!',
          recoverPasswordDescription:
              'Se enviará un correo electrónico para la recuperación de su contraseña',
          recoverPasswordSuccess: 'Password rescued successfully',
          recoverPasswordIntro: 'Recuperar contraseña'),
      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        errorColor: Colors.lightBlue,
        logoWidth: 1,
        titleStyle: GoogleFonts.sourceCodePro(
            color: Colors.black,
            letterSpacing: 4,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        cardTheme: CardTheme(
          margin: EdgeInsets.only(top: 15),
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.lightBlue,
          elevation: 6.0,
          highlightElevation: 6.0,
        ),
      ),
    );
  }
}
