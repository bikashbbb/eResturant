import 'dart:convert';
import 'package:app/providers/login.dart';
import 'package:http/http.dart' as https;

//String host;
sendLoginRequest() async {
  //https.post(url);
  var response = await https.post(Uri.parse('https://erestuarantwebapi20211115232617.azurewebsites.net/api/user/login/loginuser'), body: {
    'username': LoginController.usernameControlls.text,
    'userpassword': LoginController.passwordControlls.text
  });
  return jsonDecode(response.body);
}

product(String endpoints) async {
  var response = await https.post(
    Uri.parse(endpoints),
  );
  var res = jsonDecode(response.body);
  return res;
}
