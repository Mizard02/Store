import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBarAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          /*Icon(
            Icons.sort,
            size: 30,
            color: Colors.black,
          ),*/
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Store",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          badges.Badge(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "");
                  },
                  child: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.black,
                  )
              )
          ),
          badges.Badge(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "cartPage");
                  },
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                    color: Colors.black,
                  )))
        ],
      ),
    );
  }
}
