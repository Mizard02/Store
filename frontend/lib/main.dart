import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomePageAuth.dart';
import 'package:flutter_application_1/pages/OrderPage.dart';
import 'package:flutter_application_1/pages/UserModificationPage.dart';
import 'package:provider/provider.dart';
import 'models/OrderDetails.dart';
import 'models/Orders.dart';
import 'models/Product.dart';
import 'pages/LoginPage.dart';
import 'pages/CartPage.dart';
import 'pages/ItemPage.dart';
import 'pages/HomePage.dart';
import 'pages/RegistrationPage.dart';
import 'pages/SummaryPage.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  final cartObserver = CartObserver();
  MyApp({super.key});
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
          "/": (context) => HomePage(cartObserver: cartObserver,),
          "/homePageAuth": (context) => HomePageAuth(cartObserver: cartObserver,),
          "cartPage": (context) => CartPage(),
          "itemPage" : (context) => ItemPage(product: Product(id: 12, name:"",price:12.33,barCode:"QWERT",uri:"ima",size:"S"),cartObserver: cartObserver,),
          "loginPage" : (context) => LoginPage(),
          "/summary": (context) => SummaryPage(),
          "/orderPage":(context)=>OrderPage(Orders(
              emailUser:"desy@gmail.com",
              details: [OrderDetails(
                  product: Product(
                    name: "Prodotto",
                    price: 13.33,
                    quantity: 2,
                    barCode: "FGBD",
                    uri: "images/image-1.png",
                    size: "S", id: 1,
                  ),
                  price: 13.33,
                  quantity: 1
              ),]
          ),),
          "/userMod": (context)=>UserModificationPage(),
          "registration" : (context) => RegistrationPage()
        }
        );
  }
}
