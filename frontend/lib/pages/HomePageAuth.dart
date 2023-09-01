import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/CartPage.dart';
import 'package:flutter_application_1/pages/SummaryPage.dart';
import '../models/Product.dart';
import '../restManagers/HttpRequest.dart';
import '../widgets/HomeAppBarAuth.dart';
import '../widgets/ItemsWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePageAuth extends StatelessWidget {
  List<Product> productList = [
    Product(
      name: "Prodotto 1",
      price: 15.5,
      barCode: "SDFGHJKL",
      uri: "images/images-1.png",
        size: "S"
    ),
    Product(
      name: "Prodotto 2",
      price: 20.0,
      barCode: "ZXCVBNM",
      uri: "images/images-2.png",
        size: "S"
    ),
    Product(
        name: "Prodotto 3",
        price: 20.0,
        barCode: "DFTGHJ",
        uri: "images/images-3.png",
        size: "S"
    ),
    Product(
      name: "Prodotto 4",
      price: 15.5,
      barCode: "ASDFGHJK",
      uri: "images/images-4.png",
        size: "S"
    ),
    Product(
      name: "Prodotto 5",
      price: 20.0,
      barCode: "BVCNMJHHF",
      uri: "images/images-5.png",
        size: "S"
    ),
    Product(
        name: "Prodotto 6",
        price: 20.0,
        barCode: "ETRYUI",
        uri: "images/images-6.png",
        size: "S"
    ),
    Product(
        name: "Prodotto 7",
        price: 20.0,
        barCode: "QWERTYUI",
        uri: "images/images-7.png",
        size: "S"
    ),
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
                ItemsWidget(products: productList,),
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
                  MaterialPageRoute(builder: (context) => HomePageAuth()));
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
