class Product {
  final int id;
  final int version;
  final String name;
  final double price;
  final int quantity;
  final String barCode;
  final List<int> orderDetails;
  final List<int> reviews;

  const Product({
    required this.id,
    required this.version,
    required this.name,
    required this.price,
    required this.quantity,
    required this.barCode,
    required this.orderDetails,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      version: json['version'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      barCode: json['barCode'],
      orderDetails: json['orderDetails'],
      reviews: json['reviews'],
    );
  }
}
