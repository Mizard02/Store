import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
import 'package:flutter_application_1/pages/CartPage.dart';
import 'package:flutter_application_1/pages/ItemPage.dart';
import 'package:flutter_application_1/pages/HomePage.dart';
import 'package:flutter_application_1/pages/RegistrationScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Store',
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          "/": (context) => HomePage(),
          "cartPage": (context) => CartPage(),
          "itemPage" : (context) => ItemPage(),
          "loginPage" : (context) => LoginPage(),
          "registration" : (context) => RegistrationScreen()
        });
  }
}
