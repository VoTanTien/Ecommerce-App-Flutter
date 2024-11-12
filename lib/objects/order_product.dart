class OrderProduct {
  String date;
  String uid;
  int productId;
  int quantity;
  int price;
  String? option;

  OrderProduct({
    required this.date,
    required this.uid,
    required this.productId,
    required this.quantity,
    required this.price,
    this.option,
  });
}