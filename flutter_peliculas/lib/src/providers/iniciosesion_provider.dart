import 'package:flutter/material.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class InicioSesionState extends ChangeNotifier {
  Status _status = Status.Uninitialized;
  User? _user;

  Status get status => _status;
  User? get user => _user;

  Future<bool> signIn(String usuario, String clave) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      User? u = await loginAPP(usuario, clave);

      if (u != null) {
        if (u.id != null) {
          //_uid = userCredential.user.uid;
          //_email = userCredential.user.email;
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero); //TODO
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  /*Future<bool> signUpUser(String usuario, String clave) async {
    bool retval = false;

    try {
      User? u = await loginAPP(usuario, clave);

      if (u != null) {
        if (u.id != null) {
          //_uid = userCredential.user.uid;
          //_email = userCredential.user.email;
          return retval = true;
        }
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  Future<bool> LoginUser(String usuario, String clave) async {
    bool retval = false;

    try {
      User? u = await loginAPP(usuario, clave);

      if (u != null) {
        if (u.id != null) {
          //_uid = userCredential.user.uid;
          //_email = userCredential.user.email;
          return retval = true;
        }
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }*/
}
