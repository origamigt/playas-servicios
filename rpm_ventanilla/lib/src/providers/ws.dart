import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/configs/rpm_preferences.dart';
import 'package:playas/src/models/user.dart';

const String dominio = 'http://localhost:9090/';
const SERVER_IP = '127.0.0.1:8085';
const isDev = true;
//const SERVER_IP = 'rpv.digital';
//const isDev = false;
//const SERVER_IP = '192.168.1.24:8718';
//const SERVER_IP = '190.57.139.138';
//const SERVER_IP = '192.168.100.211:8718';
//const String dominio = 'https://tramitesenlinea.rmpplayas.gob.ec/';
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
  String token = await tokenAuth();
  Map<String, String> map = Map();
  map['Content-type'] = 'application/json';
  map['Accept'] = 'application/json';
  map['Authorization'] = token;
  return map;
}

tokenAuth() async {
  String jwt = await spGetValue(kJWT);
  return 'Bearer $jwt';
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
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, '/ws/' + url);
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
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, '/ws/' + url);
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
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, '/ws/' + url);
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
        : Uri.https(SERVER_IP, '/ws/' + url, queryParameters);
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
        isDev ? Uri.http(SERVER_IP, url) : Uri.https(SERVER_IP, '/ws/' + url);
    print(uri.toString());
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    response = await http
        .post(uri, body: jsonEncode(data), headers: header)
        .timeout(const Duration(seconds: 60));
  } catch (e) {
    print(e.toString());
  }
  return response;
}
