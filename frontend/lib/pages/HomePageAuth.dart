import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/CategoriesWidget.dart';
import '../widgets/HomeAppBarAuth.dart';
import '../widgets/ItemsWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePageAuth extends StatelessWidget {
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
                /*Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 800,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here...",
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.camera_alt,
                      size: 27,
                      color: Colors.black,
                    ),
                  ]),
                ),*/
                //Categories
                /*Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Text("Categories",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                //Categories
                CategoriesWidget(),*/

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
                ItemsWidget(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {},
        height: 70,
        color: Color.fromARGB(255, 188, 196, 246),
        items: [
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(CupertinoIcons.cart_fill, size: 30, color: Colors.black),
          Icon(Icons.list, size: 30, color: Colors.black),
        ],
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
