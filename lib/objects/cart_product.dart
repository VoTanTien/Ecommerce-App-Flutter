class CartProduct {
  String uid;
  int productId;
  int quantity;
  String? option;

  CartProduct({
    required this.uid,
    required this.productId,
    required this.quantity,
    this.option,
  });
}
