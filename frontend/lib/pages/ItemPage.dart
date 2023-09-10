import 'dart:js_util';

import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/OrderDetails.dart';
import 'package:provider/provider.dart';
import '../models/Product.dart';
import '../widgets/ItemAppBar.dart';
import '../widgets/Review.dart';
import 'CartPage.dart';

class ItemPage extends StatefulWidget {
  final Product? product;

  ItemPage({required this.product});

  @override
  ItemPageState createState() => ItemPageState(product: product);
}

class ItemPageState extends State<ItemPage> {
  final Product? product;

  ItemPageState({required this.product});

  List<String> _size = ["S", "M", "L", "XL", "XXL"];
  int _counter = 1;
  String _chosenSize = "";
  bool _isPressed = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ItemAppBar(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(product?.uri ?? "images/image-1", height: 300),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 15),
                      child: Row(children: [
                        Text(
                          product?.name ?? "Name",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.minus, size: 18),
                                  onPressed: _decrementCounter,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  _counter.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.plus, size: 18),
                                  onPressed: _incrementCounter,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        product!.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            "Size: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          for (int i = 0; i < 5; i++)
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (product?.size == _size[i]) {
                                      return Colors.deepPurple;
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  product?.size = _size[i];
                                });
                              },
                              child: Text(
                                _size[i],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
               //     Review(username: "Rush", rating: 4, comment: "Awesome"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${product?.price.toStringAsFixed(2)?? "250\$"}',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);
                    OrderDetails od = OrderDetails(product: product, price: product?.price, quantity: _counter);
                    // Aggiungi il prodotto al carrello
                    cartProvider.addToCart(od);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please, login'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.cart_badge_plus),
                  label: Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 13, horizontal: 15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
