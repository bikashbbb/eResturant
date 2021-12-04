// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:app/models/orderdetailsm.dart';
import 'package:app/providers/hiveprovider.dart';

class ItemDetails {
  int productid;
  int productCatid;
  double productprice;
  double producttax;
  var productname;
  double quantity;
  double amount;
  var orderitemid;

  ItemDetails(this.productCatid, this.productid, this.productprice,
      this.producttax, this.productname, this.quantity, this.amount,
      {this.orderitemid = ''});
}

class ActiveOrders {
  double amount;
  String tablecode;
  int OrderId;

  ActiveOrders(
    this.amount,
    this.tablecode,
    this.OrderId,
  );
}

class CreateOrderBody {
  var HallId;
  var TableId;
  var UserId;
  var OrderId;
  var NetAmount;
  var NetTax;
  var ServiceCharges;
  dynamic InvoiceItems;
  int totalItems;

  CreateOrderBody({
    required this.HallId,
    required this.TableId,
    required this.UserId,
    this.OrderId = 0,
    required this.NetAmount,
    required this.NetTax,
    this.ServiceCharges = 0,
    required this.InvoiceItems,
    this.totalItems = 1,
  });

  String createOrderbody() {
    // for invoice items i will have the models, i need a function which will get me the map of all orders
    return json.encode({
      'HallId': HallId,
      'TableId': TableId,
      'UserId': UserId,
      'OrderId': OrderId,
      'NetAmount': NetAmount,
      'NetTax': NetTax,
      'ServiceCharges': ServiceCharges,
      'InvoiceItems': InvoiceItems
    });
  }
}

/// give all the item details object
List<Map> invoiceItems(object) {
  List<Map> output = [];
  for (var obj in object) {
    output.add({
      "OrderItemId": obj.productCatid,
      "ProductId": obj.productid,
      "OrderId": obj.orderitemid,
      "Quantity": obj.quantity,
      "UnitPrice": obj.productprice,
      "TaxAmount": obj.producttax,
      "UserId": getUserid()
    });
  }
  return output;
}

String removeItembody(OrderInvoiceItem obj) {
  return json.encode({
    'OrderItemId': obj.OrderItemId,
    'ProductId': obj.ProductId,
    'OrderId': obj.OrderId,
    'Quantity': obj.Quantity,
    'UnitPrice': obj.UnitPrice,
    'TaxAmount': obj.TaxAmount,
    'UserId': obj.UserId
  });
}
