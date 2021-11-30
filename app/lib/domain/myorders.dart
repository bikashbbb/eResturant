import 'dart:convert';
import 'package:app/providers/hiveprovider.dart';
import 'package:http/http.dart' as http;

var client = http.Client();
var responseurl = LocalData.getBaseUrl();
getActiveOrders() async {
  // gives active orders from the backend

  var response = await client.post(Uri.parse('$responseurl/getmyorder'),
      body: {"UserId": getUserid()});
  return jsonDecode(response.body);
}

sendOrderCreateRequest() async {
  // todo: send order request,,
  var response = await client.post(Uri.parse('$responseurl/createorder'),
      body: jsonEncode({
        "HallId": '1',
        "TableId": '2',
        "UserId": '2',
        "OrderId": '4',
        "NetAmount": '5.0',
        "NetTax": '6.0',
        "ServiceCharges": '7.0',
        "InvoiceItems": [
          {
            "OrderItemId": '1',
            "ProductId": '2',
            "OrderId": '4',
            "Quantity": '4.0',
            "UnitPrice": '5.0',
            "TaxAmount": '6.0',
            "UserId": '7'
          },
          {
            "OrderItemId": '1',
            "ProductId": '2',
            "OrderId": '4',
            "Quantity": '4.0',
            "UnitPrice": '5.0',
            "TaxAmount": '6.0',
            "UserId": '7'
          }
        ]
      }));
  print(response.body);
}
