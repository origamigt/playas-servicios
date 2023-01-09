import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/configs/rpm_preferences.dart';
import 'package:playas/src/models/user.dart';

const String dominio = 'https://tramitesenlinea.rmpplayas.gob.ec/';
const SERVER_IP = 'ventanilla.rmpplayas.gob.ec';
const CONTEXT = '/servicios/';
const isDev = false;
//const SERVER_IP = '192.168.1.24:8718';
//const SERVER_IP = '190.57.139.138';
//const SERVER_IP = '192.168.100.211:8718';

String kUser = "_KUser";
String kThereUser = '_KThere_User';
String kThereUserOK = 'KThere_User_OK';
String kThereUserNOTOK = 'KThere_User_NOT_OK';
String kJWT = 'jwt';

Map<String, String> headerNoAuth = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

mapHeaderAuth() async {
  Map<String, String> map = Map();
  map['Content-type'] = 'application/json';
  map['Accept'] = 'application/json';
  map['Authorization'] = await tokenAuth();
  return map;
}

Future<bool> spDelete(String key) async {
  return await PrefencesRPM.deleteKey(key);
}

Future<String> spGetValue(String key) async {
  return await PrefencesRPM.getValue(key);
}

Future<bool> spSaveValue(String key, String value) async {
  return await PrefencesRPM.saveValue(key, value);
}

Future<User?> userLogged() async {
  var result = await PrefencesRPM.getValue(kUser);
  try {
    if (result != null && result != 'value') {
      Map<String, dynamic> map = jsonDecode(result) as Map<String, dynamic>;
      return User().fromJson(map);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

signOut() async {
  await PrefencesRPM.deleteAllKeys();
  return true;
}

findAll(String url, bool auth) async {
  try {
    Uri uri =
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, CONTEXT + url);
    //print(uri.path);
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http.get(uri, headers: header);
    return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print(e);
    return null;
  }
}

findAllResponse(String url, bool auth) async {
  try {
    Uri uri =
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, CONTEXT + url);
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http.get(uri, headers: header);
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}

find(String url, bool auth) async {
  try {
    Uri uri =
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, CONTEXT + url);
    print(uri.toString());
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http.get(uri, headers: header);

    var jsTask = response.bodyBytes;
    if (jsTask.length > 0) {
      Map<String, dynamic> map =
          json.decode(utf8.decode(jsTask)) as Map<String, dynamic>;
      return map;
    } else {
      return null;
    }
  } catch (e) {
    print('e: $e');
    return null;
  }
}

findParameters(
    String url, Map<String, dynamic> queryParameters, bool auth) async {
  try {
    Uri uri = isDev
        ? Uri.http(SERVER_IP, url, queryParameters)
        : Uri.https(SERVER_IP, CONTEXT + url, queryParameters);
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http.get(uri, headers: header);

    var jsTask = response.bodyBytes;

    if (jsTask.length > 0) {
      Map<String, dynamic> map =
          json.decode(utf8.decode(jsTask)) as Map<String, dynamic>;
      return map;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

save(String url, Object data, bool auth) async {
  http.Response? response;
  try {
    Uri uri =
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, CONTEXT + url);

    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    response = await http
        .post(uri, body: jsonEncode(data), headers: header)
        .timeout(const Duration(seconds: 60));
  } catch (e) {
    print(e.toString());
  }
  return response;
}

tokenAuth() async {
  User? u = await userLogged();
  await updateJWT(u!.usuario, u.clave!);
  String jwt = await spGetValue(kJWT);
  return 'Bearer $jwt';
}

Future<String> updateJWT(String? username, String? pass) async {
  try {
    String path = 'rpm-ventanilla/api/autentificacion';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);

    http.Response response = await http.post(uri,
        body: json.encode({"username": username, "password": pass}),
        headers: headerNoAuth);

    if (response.statusCode == 200) {
      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      var jwt = map['token'];
      await spDelete(kJWT);
      await spSaveValue(kJWT, jwt);
      return jwt;
    } else {
      return '';
    }
  } catch (e) {
    return '';
  }
}
