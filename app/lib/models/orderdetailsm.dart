// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:app/models/orders.dart';
import 'package:app/providers/hiveprovider.dart';

class OrderInvoiceItem {
  var amount;

  /// this is given from the backend and will be used while removing the order
  var OrderItemId;
  var ProductId;

  /// this is also given from the backend to be used while updating order
  var OrderId;
  var Quantity;
  var UnitPrice;
  var TaxAmount;
  var UserId;
  String productname;

  OrderInvoiceItem(
      {required this.OrderItemId,
      required this.ProductId,
      required this.OrderId,
      required this.Quantity,
      required this.UnitPrice,
      required this.TaxAmount,
      required this.UserId,
      this.productname = '',
      this.amount});
}

/// list of orderinvoice items
List<OrderInvoiceItem> getInvoiceItems(datas) {
  List<OrderInvoiceItem> objects = [];
  for (var data in datas) {
    var amount =
        data["UnitPrice"] + (data["UnitPrice"] * data["TaxAmount"] / 100);
    objects.add(OrderInvoiceItem(
        OrderItemId: data['OrderItemId'],
        ProductId: data["ProductId"],
        OrderId: data["OrderId"],
        Quantity: data["Quantity"],
        UnitPrice: data["UnitPrice"],
        TaxAmount: data["TaxAmount"],
        amount: amount,
        UserId: data["UserId"]));
  }
  return objects;
}

CreateOrderBody saveOrderDetails(var data) {
  var items = CreateOrderBody(
      OrderId: data['OrderId'],
      HallId: data['HallId'],
      TableId: data['TableId'],
      UserId: data['UserId'],
      NetAmount: data['NetAmount'],
      NetTax: data['NetTax'],
      ServiceCharges: data['ServiceCharges'],
      totalItems: data['InvoiceItems'].length,
      InvoiceItems: getInvoiceItems(
        data['InvoiceItems'],
      ));
  return items;
}

List<Map> convertInvoiceObjectsTolist(List<OrderInvoiceItem> objects) {
  List<Map> updatebodyinvoice = [];
  for (var obj in objects) {
    updatebodyinvoice.add({
      "OrderItemId": obj.OrderItemId,
      "ProductId": obj.ProductId,
      "OrderId": obj.OrderId,
      "Quantity": obj.Quantity,
      "UnitPrice": obj.UnitPrice,
      "TaxAmount": obj.TaxAmount,
      "UserId": getUserid()
    });
  }

  return updatebodyinvoice;
}
