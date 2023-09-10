

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  int quantity;
  final String barCode;
  final String uri;
  String size;

   Product({
     required this.id,
    required this.name,
    required this.price,
     required this.description,
    this.quantity=1,
    required this.barCode,
    required this.uri,
     this.size="S",
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      quantity: json['quantity'],
      barCode: json['barCode'],
      uri: json['uri'],
      size: json['size']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price':price,
      'description' : description,
      'quantity':quantity,
      'barCode': barCode,
      'uri':uri,
      'size':size
    };
  }
}
