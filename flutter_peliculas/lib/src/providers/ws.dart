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
