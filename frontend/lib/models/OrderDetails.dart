
import 'Product.dart';

class OrderDetails {
    final Product product;
    final double price;
    final int quantity;
    const OrderDetails({
      required this.product,
      required this.price,
      required this.quantity,
    });
    factory OrderDetails.fromJson(Map<String, dynamic> json) {
      return OrderDetails(
        product: json['product'],
        price: json['price'],
        quantity: json['quantity']
      );
    }
}