class Product {
  final String name;
  final double price;
  int quantity;
  final String barCode;
  final String uri;
  String size;

   Product({
    required this.name,
    required this.price,
    this.quantity=1,
    required this.barCode,
    required this.uri,
     this.size="S",
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      barCode: json['barCode'],
      uri: json['uri'],
      size: json['size']
    );
  }
}
