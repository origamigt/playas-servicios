import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';

class UsuarioProvider with ChangeNotifier {
  User? user; //an instance of a user
  String? errorMessage; //error message
  bool loading = false; //loading the page

  Future<bool> fetchUser(String usuario, String clave) async {
    setLoading(true);
    // fetch user from the input supplied in the form

    await loginAPP(usuario, clave).then((data) {
      setLoading(false);
      if (data != null) {
        setUser(data);
      } else {
        setMessage('message');
      }
    });

    return isUser(); //returns the fetched user
  }

  bool isLoading() {
    return loading; //return true if the app is loading the data
  }

  void setLoading(value) {
    loading = value;
    notifyListeners(); //This method is called when the objects is changed
  }

  void setUser(value) {
    user = value;
    notifyListeners(); //alert listeners that user's value changed
  }

  User? getUser() {
    return user; //returns the fetched user
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners(); // alert listeners that the error message changed
  }

  String? getMessage() {
    return errorMessage; // get the error message
  }

  bool isUser() {
    return user != null
        ? true
        : false; // returns true if user is not null, anf false otherwise
  }

  Future<User?> findUser(String? usuario) async {
    Map<String, dynamic> map =
        await find('/api/usuario/identificacion/' + usuario!, true);
    User? user = User().fromJson(map);
    return user;
  }

  Future<User?> initialize() async {
    var u = await userLogged();
    return u;
  }
}
