class Product {
  final int id;
  final String title;
  final String image;
  final String option;
  final String size;
  final String describe;
  final int price;
  final int? discountPrice;
  final double rate;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.option,
    required this.size,
    required this.describe,
    required this.price,
    this.discountPrice,
    required this.rate,
  });

  factory Product.fromMap(Map<String, dynamic> map, int id) {
    return Product(
      id: id,
      title: map['title']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      option: map['option']?.toString() ?? '',
      size: map['size']?.toString() ?? '',
      describe: map['describe']?.toString() ?? '',
      price: map['price']?.toInt() ?? 0, // Convert to int, provide default
      discountPrice: map['discountPrice']?.toInt(), // Nullable int
      rate: (map['rate'] as num?)?.toDouble() ?? 0.0, // Handle double conversion and null
    );
  }
}