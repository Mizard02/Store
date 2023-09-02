import 'package:flutter_application_1/models/OrderDetails.dart';
import 'package:flutter_application_1/models/User.dart';

class Orders {
  late String emailUser;
  late List<OrderDetails> details;

   Orders({
    required this.emailUser,
    required this.details,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    List<dynamic> dynamicList = json['details'];
    List<OrderDetails> orderDetailsList = [];

    for (dynamic item in dynamicList) {
      if (item is Map<String, dynamic>) {
        orderDetailsList.add(OrderDetails.fromJson(item));
      } else {
        // Gestisci il caso in cui l'item non sia di tipo Map<String, dynamic>
        // Puoi ignorarlo o gestirlo in base alle tue esigenze.
      }
    }

    return Orders(
      emailUser: json['emailUser'],
      details: orderDetailsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'emailUser': emailUser,
      'details': details.map((orderDetail) => orderDetail.toJson()).toList(),
    };
    return data;
  }
}
