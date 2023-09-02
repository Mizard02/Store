import 'package:flutter_application_1/models/OrderDetails.dart';
import 'package:flutter_application_1/models/User.dart';

class Orders {
  late String client;
  late List<OrderDetails> details;

   Orders({
    required this.client,
    required this.details,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      client: json['client'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'emailUser': client,
      'details': details.map((orderDetail) => orderDetail.toJson()).toList(),
    };
    return data;
  }
}
