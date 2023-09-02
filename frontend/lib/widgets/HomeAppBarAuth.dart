import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../pages/SummaryPage.dart';

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryPage()));
                  },
                  child: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Color(0xFFD1C4E9),
                  )
              )
          ),
          Divider(),
          badges.Badge(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "cartPage");
                  },
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                    color: Colors.black,
                  ))),
          badges.Badge(
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.exit_to_app_outlined,
                size: 30,
                color: Colors.black,
              )
            )
          )
        ],
      ),
    );
  }
}
