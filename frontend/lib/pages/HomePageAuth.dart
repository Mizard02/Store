import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/CartPage.dart';
import 'package:flutter_application_1/pages/ItemPage.dart';
import 'package:flutter_application_1/pages/SummaryPage.dart';
import '../models/Product.dart';
import '../restManagers/HttpRequest.dart';
import '../widgets/HomeAppBarAuth.dart';
import '../widgets/ItemsWidgetAuth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePageAuth extends StatefulWidget {
  @override
  _HomePageAuthState createState() => _HomePageAuthState();
}

class _HomePageAuthState extends State<HomePageAuth> {
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
          HomeAppBarAuth(),
          Container(

            child: Column(
              children: [
                // Search
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple[50],
                  ),
                  child: Row(
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
                ),
              ],
            ),
          ),
          ItemsWidgetAuth(),
        ],
      ),
      bottomNavigationBar: _responsiveBottomBar(),
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
          color: Colors.deepPurpleAccent,
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
        );
      } else {
        // Altrimenti, nascondi il widget
        return SizedBox.shrink();
      }
    },
  );
}
