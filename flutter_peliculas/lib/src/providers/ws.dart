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

tokenAuth() async {
  //User u = await userLogged();
  //return 'Basic ' + base64Encode(utf8.encode(u.usuario + ':' + u.clave));
  //String jwt = await spGetValue(kJWT);
  return 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwOTUzMjU1OTU3IiwiZXhwIjoxNjI4ODU1NTU5LCJpYXQiOjE2Mjg2Mzk1NTl9.-Novm9mIsP7V75n9Cqx9kR8A3RCa2Ua12F6TgXujovImIyZ9u7POrBD5gUCdrHRw8dNmjtApWayFogdzdN9AIg';
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

userLogged() async {
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

Future<User?> loginAPP(String user, String pass) async {
  try {
    Map<String, String>? header = await mapHeaderAuth();
    User usr = User();
    usr.pass = pass;
    usr.username = user;
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
        u.pass = pass;
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
    print(Uri.http(SERVER_IP, url).toString());
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response =
        await http.get(Uri.http(SERVER_IP, url), headers: header);
    return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print(e);
    return null;
  }
}

find(String url, bool auth) async {
  try {
    print(Uri.http(SERVER_IP, url).toString());
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

save(String url, Object data, bool auth, bool list) async {
  try {
    print(Uri.http(SERVER_IP, url).toString());
    print(jsonEncode(data));
    Map<String, String>? header = auth ? await mapHeaderAuth() : headerNoAuth;
    http.Response response = await http
        .post(Uri.http(SERVER_IP, url), body: jsonEncode(data), headers: header)
        .timeout(const Duration(seconds: 30));

    if (!list) {
      var jsTask = response.bodyBytes;
      if (jsTask.length > 0) {
        Map<String, dynamic> map =
            json.decode(utf8.decode(jsTask)) as Map<String, dynamic>;
        return map;
      }
    } else {
      return json.decode(utf8.decode(response.bodyBytes));
    }
  } catch (e) {
    print(e);
    return null;
  }
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
