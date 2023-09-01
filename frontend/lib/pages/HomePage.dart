import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import '../models/Product.dart';

import '../widgets/HomeAppBar.dart';
import '../widgets/ItemsWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatelessWidget {
  List<Product>? productList = [
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
            HomeAppBar(),
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
                  ItemsWidget()

                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _responsiveBottomBar()
    );
  }
}
Widget _responsiveBottomBar (){
  return LayoutBuilder(
    builder: (context, constraints) {
      // Controlla la larghezza dello schermo
      if (constraints.maxWidth < 600) {
        // Mostra il widget solo quando la larghezza è maggiore di 600
        return CurvedNavigationBar(
          onTap: (index) {},
          height: 70,
          color: Color.fromARGB(255, 188, 196, 246),
          items: [
            Icon(Icons.home, size: 30, color: Colors.black),
            Icon(CupertinoIcons.cart_fill, size: 30, color: Colors.black),
            Icon(Icons.list, size: 30, color: Colors.black),
          ],
          backgroundColor: Colors.transparent,
        );
      } else {
        // Altrimenti, nascondi il widget
        return SizedBox.shrink();
      }
    },
  );
}
