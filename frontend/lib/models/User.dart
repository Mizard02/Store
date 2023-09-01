import 'dart:core';

class User {
  final String surname, name, email, address, phoneNumber;
  //final List<int> orders, reviews;

  const User({
    required this.surname,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
   // required this.orders,
 //   required this.reviews,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        surname: json['surname'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
      //  orders: json['orders'],
    //    reviews: json['review']
    );
  }
}
Map<String, dynamic> toJson(User u) {
  return {
    'surname': u.surname,
    'name': u.name,
    'email': u.email,
    'address': u.address,
    'phoneNumber': u.phoneNumber,
  };
}