class Product {
  final String name;
  final double price;
  int quantity;
  final String barCode;
  final String uri;

   Product({
    required this.name,
    required this.price,
    this.quantity=1,
    required this.barCode,
    required this.uri,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      barCode: json['barCode'],
      uri: json['uri'],
    );
  }
}
