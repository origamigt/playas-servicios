import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/configs/rpm_preferences.dart';
import 'package:playas/src/models/user.dart';

const SERVER_IP = '127.0.0.1:8085';

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

Future<User?> loginAPP(String user, String clave) async {
  try {
    Map<String, String>? header = await mapHeaderAuth();
    User usr = User();
    usr.clave = clave;
    usr.usuario = user;
    usr.habilitado = true;
    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/api/usuario/loginUser'),
        body: json.encode(usr),
        headers: header);
    await PrefencesRPM.deleteAllKeys();
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;

        User u = User().fromJson(map);
        u.clave = clave;
        var uJS = json.encode(u);
        await PrefencesRPM.saveValue(kUser, uJS);
        await PrefencesRPM.saveValue(kThereUser, kThereUserOK);
        return u;
      } catch (e) {
        print(e);
      }
    } else {
      await PrefencesRPM.saveValue(kThereUser, kThereUserNOTOK);
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

findAll(String url, bool auth) async {
  try {
    print(Uri.http(SERVER_IP, url));
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response =
        await http.get(Uri.http(SERVER_IP, url), headers: header);
    return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print(e);
    return null;
  }
}

findAllResponse(String url, bool auth) async {
  try {
    print(Uri.http(SERVER_IP, url));
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response =
        await http.get(Uri.http(SERVER_IP, url), headers: header);
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}

find(String url, bool auth) async {
  try {
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response =
        await http.get(Uri.http(SERVER_IP, url), headers: header);

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

findParameters(
    String url, Map<String, dynamic> queryParameters, bool auth) async {
  try {
    print(Uri.http(SERVER_IP, url, queryParameters).toString());
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http
        .get(Uri.http(SERVER_IP, url, queryParameters), headers: header);

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
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    response = await http
        .post(Uri.http(SERVER_IP, url), body: jsonEncode(data), headers: header)
        .timeout(const Duration(seconds: 30));
  } catch (e) {
    print(e);
  }
  return response;
}

update(String url, Object data, bool auth) async {
  try {
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http
        .put(Uri.http(SERVER_IP, url), body: jsonEncode(data), headers: header)
        .timeout(const Duration(seconds: 30));

    var jsTask = response.body;
    if (jsTask.length > 0) {
      Map<String, dynamic> map = jsonDecode(jsTask) as Map<String, dynamic>;
      return map;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<String?> updateJWT(String usr, String clave) async {
  try {
    String url = '/ws/authenticate';
    http.Response response = await http.post(Uri.https(SERVER_IP, url),
        body: json.encode({"usuario": usr, "claveword": clave}),
        headers: headerNoAuth);
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      var jwt = map['token'];
      await spDelete(kJWT);
      await spSaveValue(kJWT, jwt);
      return jwt;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
