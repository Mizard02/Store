import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
import '../models/Product.dart';

import '../restManagers/HttpRequest.dart';
import '../widgets/HomeAppBar.dart';
import '../widgets/ItemsWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'ItemPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product>? productList = [
    Product(
      id: 4,
      name: "Prodotto 1",
      price: 15.5,
      barCode: "SDFGHJKL",
      uri: "images/images-1.png",
      size: "S",
      description: ""
    ),
    Product(
      id: 5,
      name: "Prodotto 2",
      price: 20.0,
      barCode: "ZXCVBNM",
      uri: "images/images-2.png",
      size: "S", description: ""
    ),
    Product(
      id: 6,
      name: "Prodotto 3",
      price: 20.0,
      barCode: "DFTGHJ",
      uri: "images/images-3.png",
      size: "S", description: ""
    ),
    Product(
      id: 7,
      name: "Prodotto 4",
      price: 15.5,
      barCode: "ASDFGHJK",
      uri: "images/images-4.png",
      size: "S", description: ""
    ),
  ];
  TextEditingController _searchController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          // Search
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple[50],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here...",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: ()  async{
                        Product? res = await Model.sharedInstance.searchProductByName(searchText);
                        Product p = Product(id: res!.id, name: res!.name, price: res!.price, barCode: res!.barCode, uri: res!.uri, description: res!.description);
                        _searchController.clear();
                        if(p!=null) {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => ItemPage(product: p))
                          );
                        }
                      },
                    ),
                  ],
                ),

              ],
            ),
          ),
          ItemsWidget(),
        ],
      ),
      bottomNavigationBar: _responsiveBottomBar(),
    );
  }

  Widget _responsiveBottomBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return CurvedNavigationBar(
            onTap: (index) {},
            height: 70,
            color: Colors.deepPurpleAccent,
            items: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Icon(Icons.home, size: 30, color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Icon(
                  CupertinoIcons.cart_fill,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Icon(Icons.list, size: 30, color: Colors.black),
              ),
            ],
            backgroundColor: Colors.transparent,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
