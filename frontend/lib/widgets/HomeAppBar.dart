import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget {

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
          CupertinoButton(
            onPressed: () {
              Navigator.pushNamed(context, "loginPage");
            },
            child: Text('Login'),
          ),
         CupertinoButton(
            onPressed: () {
              Navigator.pushNamed(context, "registration");
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
