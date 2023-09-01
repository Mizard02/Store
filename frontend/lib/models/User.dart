import 'dart:core';

class User {
  late String surname, name, email, address, phoneNumber;

  User({
    required this.surname,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    // required this.orders,
    //   required this.reviews,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      surname: json['surname'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      //  orders: json['orders'],
      //    reviews: json['review']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'name': name,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

}