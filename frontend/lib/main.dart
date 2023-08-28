import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomePageAuth.dart';
import 'package:flutter_application_1/pages/OrderPage.dart';
import 'pages/LoginPage.dart';
import 'pages/CartPage.dart';
import 'pages/ItemPage.dart';
import 'pages/HomePage.dart';
import 'pages/RegistrationScreen.dart';
import 'pages/SummaryPage.dart';

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
          "/homePageAuth": (context) => HomePageAuth(),
          "cartPage": (context) => CartPage(),
          "itemPage" : (context) => ItemPage(),
          "loginPage" : (context) => LoginPage(),
          "/summary": (context) => SummaryPage(),
          "/orderPage":(context)=>OrderPage(),
          "registration" : (context) => RegistrationScreen()
        }
        );
  }
}
