import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/CartPage.dart';
import 'package:flutter_application_1/pages/SummaryPage.dart';
import '../models/Product.dart';
import '../widgets/HomeAppBarAuth.dart';
import '../widgets/ItemsWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePageAuth extends StatefulWidget {
  final CartObserver cartObserver;
  HomePageAuth({required this.cartObserver});
  @override
  _HomePageAuthState createState() => _HomePageAuthState(cartObserver: cartObserver);

}
class _HomePageAuthState extends State<HomePageAuth> {
  final CartObserver cartObserver;
  _HomePageAuthState({required this.cartObserver});
  List<Product> productList = [
    Product(
      id: 23,
        name: "Prodotto 1",
      price: 15.5,
      barCode: "SDFGHJKL",
      uri: "images/images-1.png",
        size: "S"
    )
    // Aggiungi altri oggetti Product come necessario
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBarAuth(),
          Container(
            //height: 500,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                //Search
                Container(

                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 2,
                      width: 80,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here...",
                        ),
                      ),
                    ),

                  ]),
                ),
                //Items
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text("Best Selling",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                ItemsWidget(cartObserver: cartObserver,),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        color: Color(0xFFD1C4E9),
        items: [
          InkWell(
            onTap: () {
              // Naviga alla prima pagina
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageAuth(cartObserver: cartObserver,)));
            },
            child: Icon(Icons.home, size: 30, color: Colors.black),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Icon(
                CupertinoIcons.cart_fill, size: 30, color: Colors.black),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SummaryPage()));
            },
            child: Icon(Icons.list, size: 30, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
