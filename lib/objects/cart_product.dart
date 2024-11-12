class CartProduct {
  String uid;
  int productId;
  int quantity;
  String? option;
  bool isChecked;

  CartProduct({
    required this.uid,
    required this.productId,
    required this.quantity,
    this.option,
    this.isChecked = false,
  });
}
