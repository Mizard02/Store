
import '../pages/CartPage.dart';
import 'Product.dart';

class OrderDetails {
    late Product? product;
    late double? price;
    late int quantity;


    OrderDetails({
      required this.product,
      required this.price,
      required this.quantity,
    });

    factory OrderDetails.fromJson(Map<String, dynamic> json) {
      return OrderDetails(
        product: Product.fromJson(json['product']),
        price: json['price'] as double,
        quantity: json['quantity'] as int,
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'product': product?.toJson(),
        'price': price,
        'quantity': quantity,
      };
    }

}