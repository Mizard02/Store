class Order {
  final int id;
  final int clientId;
  final String time;
  final List<int> details;

  const Order({
    required this.id,
    required this.clientId,
    required this.time,
    required this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      clientId: json['clientId'],
      time: json['time'],
      details: json['details'],
    );
  }
}
