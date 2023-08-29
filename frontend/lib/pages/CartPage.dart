import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Product.dart';
import '../widgets/CartAppBar.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void incrementQuantity(Product product) {
    product.quantity++;
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    } else {
      _cartItems.remove(product);
      notifyListeners();
    }
  }

  void addToCart(Product? product) {
    Product p = Product(name:"",price:12.33,barCode:"QWERT",uri:"ima",size:"S");
    _cartItems.add(product!);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < cartItems.length; i++)
      total += _cartItems[i].price * _cartItems[i].quantity;
    return total;
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          CartAppBar(),
          Container(
            height: 700,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 232, 232),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    for (int i = 0; i < cartProvider.cartItems.length; i++)
                      Container(
                        height: 110,
                        margin: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Radio(
                              value: "",
                              groupValue: "",
                              activeColor: Colors.black,
                              onChanged: (index) {},
                            ),
                            Container(
                              height: 70,
                              width: 70,
                              margin: EdgeInsets.only(right: 15),
                              child: Image.asset(
                                  cartProvider.cartItems[i].uri),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cartProvider.cartItems[i].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      cartProvider
                                          .cartItems[i].price
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, size: 20),
                                    onPressed: () {
                                      cartProvider.removeFromCart(
                                          cartProvider.cartItems[i]);
                                    },
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                              CupertinoIcons.minus,
                                              size: 20),
                                          onPressed: () {
                                            cartProvider.decrementQuantity(
                                                cartProvider.cartItems[i]);
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "0"+ cartProvider._cartItems[i].quantity.toString() ,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                            CupertinoIcons.plus,
                                            size: 20),
                                        onPressed: () {
                                          cartProvider.incrementQuantity(
                                              cartProvider.cartItems[i]);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 15),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total price: \$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Check out",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

