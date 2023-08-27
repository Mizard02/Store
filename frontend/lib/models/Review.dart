import 'dart:ffi';

class Review {
  final Long id;
  final String text;
  final String date;
  final int idClient;
  final int idProduct;
  const Review({
    required this.id,
    required this.text,
    required this.date,
    required this.idClient,
    required this.idProduct,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      text: json['text'],
      date: json['date'],
      idClient: json['idClient'],
      idProduct: json['idProduct'],
    );
  }
}
