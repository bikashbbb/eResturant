class ItemDetails {
  int productid;
  int productCatid;
  double productprice;
  double producttax;
  var productname;
  double quantity;
  double amount;

  ItemDetails(this.productCatid, this.productid, this.productprice,
      this.producttax, this.productname, this.quantity, this.amount);
}

class ActiveOrders {
  String amount;
  String orderedtime;
  String tableno;

  ActiveOrders(this.amount, this.orderedtime, this.tableno);
}
