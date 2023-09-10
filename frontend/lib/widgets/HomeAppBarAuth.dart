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
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryPage()));
            },
            child: Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.deepPurple,
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "cartPage");
            },
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: (){
              showConfirmationDialog(context);
            },
            child: Icon(
              Icons.exit_to_app_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('The cart will be emptied.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi la finestra di dialogo
                Navigator.pushNamed(context, "/");
              },
            ),
          ],
        );
      },
    );
  }


}

