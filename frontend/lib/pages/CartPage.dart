import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestManagers/RestManager.dart';
import 'package:flutter_application_1/models/OrderDetails.dart';
import 'package:flutter_application_1/models/Orders.dart';
import 'package:flutter_application_1/pages/SummaryPage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import '../models/Product.dart';
import '../restManagers/HttpRequest.dart';
import '../widgets/CartAppBar.dart';

class CartProvider with ChangeNotifier {
  List<OrderDetails> _cartItems = [];

  List<OrderDetails> getDetails() => _cartItems;

  void incrementQuantity(OrderDetails product ) {
    product.quantity++;
    notifyListeners();
  }

  void decrementQuantity(OrderDetails product) {
    if (product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    } else {
      _cartItems.remove(product);
      notifyListeners();
    }
  }

  void addToCart(OrderDetails? product) {
    Product p = Product(id: 11, name:"",price:12.33,barCode:"QWERT",uri:"ima",size:"S");
    _cartItems.add(product!);
    notifyListeners();
  }

  void removeFromCart(OrderDetails product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void removeAll() {
    _cartItems.clear();
    notifyListeners();
  }



  double getTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < _cartItems.length; i++)
      total += (_cartItems[i]?.price ?? 0) * _cartItems[i].quantity ;
    return total;
  }
}

class CartPage extends StatelessWidget {

  void showSnackBarOK(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Ordine effettuato con successo!'),
      backgroundColor: Colors.green, // Colore di sfondo
      duration: Duration(seconds: 2), // Durata della SnackBar
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBarKO(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Qualcosa è andato storto'),
      backgroundColor: Colors.green, // Colore di sfondo
      duration: Duration(seconds: 2), // Durata della SnackBar
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }






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
                    for (int i = 0; i < cartProvider.getDetails().length; i++)
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
                                  cartProvider.getDetails()[i].product?.uri ?? "null"),
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
                                      cartProvider.getDetails()[i].product?.name ?? "null",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      (cartProvider
                                          .getDetails()[i].product?.price ?? 0)
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
                                          cartProvider.getDetails()[i]);
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
                                                cartProvider.getDetails()[i]);
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
                                              cartProvider.getDetails()[i]);
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
                child: TextButton(
                  onPressed: (){
                    String email = Model.sharedInstance.getClientFromToken();
                    Orders o = Orders(client: email, details: cartProvider.getDetails());
                    Future<String> res = Model.sharedInstance.createOrder(o);
                    cartProvider.removeAll();
                    //if(res.toString() == "ok")
                      showSnackBarOK(context);
                    //else
                      //showSnackBarKO(context);
                  },
                child:Text(
                  "Check out",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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

