import 'dart:convert';
import 'package:app/providers/login.dart';
import 'package:http/http.dart' as https;

//String host;
sendLoginRequest() async {
  var requesturl = LoginController.baseurlControlls.text;
  try {
    var response =
        await https.post(Uri.parse('$requesturl/user/login/loginuser'), body: {
      'username': LoginController.usernameControlls.text,
      'userpassword': LoginController.passwordControlls.text
    });
    return jsonDecode(response.body);
  } catch (e) {
    return false;
  }
}

product(String endpoints) async {
  var response = await https.post(
    Uri.parse(endpoints),
  );
  var res = jsonDecode(response.body);
  return res;
}
