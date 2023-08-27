import 'dart:core';

class User {
  final int userId;
  final String surname, name, email, address, phoneNumber;
  final List<int> orders, reviews;

  const User({
    required this.userId,
    required this.surname,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.orders,
    required this.reviews,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        surname: json['surname'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        orders: json['orders'],
        reviews: json['review']);
  }
}