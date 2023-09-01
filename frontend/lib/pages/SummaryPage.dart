import 'package:flutter/material.dart';

import '../models/User.dart';
import '../restManagers/HttpRequest.dart';
import 'OrderPage.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryDataWidgetState createState() => _SummaryDataWidgetState();
}
class Order {
  final String title;
  final String date;

  Order({required this.title, required this.date});
}
class _SummaryDataWidgetState extends State<SummaryPage> {

  void _loadUser() async =>  Model.sharedInstance.viewUser("rita-sisto@gmail.com").then((value) => u);
  User? u;

  /*User u = User(
    surname: "Chiappetta",
    name: "Desirè",
    email: "dp@mail.com",
    address: "Nogiano",
    phoneNumber: "123456",
  );*/

  final List<Order> orders = [
    Order(title: 'Ordine 1', date: '10/08/2023'),
    Order(title: 'Ordine 2', date: '12/08/2023'),
    Order(title: 'Ordine 3', date: '15/08/2023'),
  ];


  @override
  Widget build(BuildContext context) {
    _loadUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Summary Data'),
      ),
      body: Center( // Aggiunto il widget Center
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.account_circle_outlined, size: 48),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Allineato al centro
                children: [
                  ReusableRow(
                    title: 'Surname: ', value: u?.surname ?? "", iconData: Icons.person_2_outlined,
                  ),
                  ReusableRow(
                    title: 'Name: ', value:u?.name?? "", iconData: Icons.person_2_outlined,
                  ),
                  ReusableRow(
                    title: 'Phone: ', value: u?.phoneNumber?? "", iconData: Icons.phone_outlined,
                  ),
                  ReusableRow(
                    title: 'Email: ', value: u?.email?? "", iconData: Icons.email_outlined,
                  ),
                ],
              ),
              SizedBox(height: 20), // Aggiunto spazio tra il profilo e la lista degli ordini
              Expanded( // Wrap ListView.builder in Expanded per darle spazio infinito in altezza
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return ListTile(
                      leading: Icon(Icons.shopping_cart), // Icona a sinistra
                      title: Text(order.title), // Titolo cliccabile al centro
                      trailing: Text(order.date), // Data a destra
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderPage()),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),);
  }
}

class ReusableRow extends StatelessWidget{
  final String title, value;
  final IconData iconData;
  const ReusableRow({Key? key, required this.title, required this.value, required this.iconData}) : super (key:key);

  @override
  Widget build(BuildContext context){
    return Column(
        children:[
          ListTile(
            title: Text(title),
            leading: Icon(iconData),
            trailing: Text(value),
          ),
          Divider(),
        ]
    );
  }
}

