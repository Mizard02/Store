import 'package:flutter_application_1/models/OrderDetails.dart';
import 'package:flutter_application_1/models/User.dart';

class Order {
  final User client;
  final List<OrderDetails> details;

  const Order({
    required this.client,
    required this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      client: json['client'],
      details: json['details'],
    );
  }
}
