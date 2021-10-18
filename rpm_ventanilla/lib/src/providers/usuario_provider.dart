import 'package:flutter/material.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';

class UsuarioProvider extends ChangeNotifier {
  User? user; //an instance of a user
  String? errorMessage; //error message
  bool loading = false; //loading the page

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

  Future<User?> initialize() async {
    var u = await userLogged();
    return u;
  }

  Future<void> cerrarSesion() async {
    setLoading(true);
    user = null;
    await signOut();
    setLoading(false);
  }
}
