import 'dart:convert';
import 'package:app/providers/hiveprovider.dart';
import 'package:http/http.dart' as http;

var client = http.Client();
var responseurl = LocalData.getBaseUrl();
Future<List> getActiveOrders() async {
  var response = await client.post(Uri.parse('$responseurl/orders/myorders'),
      body: {"Userid": getUserid()});

  return jsonDecode(response.body);
}

sendOrderCreateRequest(String body,
    {String path = '/orders/createorder'}) async {
  var response = await client.post(Uri.parse('$responseurl$path'),
      headers: {'Content-Type': 'application/json'}, body: body);
  return jsonDecode(response.body);
}


