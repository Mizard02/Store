import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/UserModificationPage.dart';

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
  User user = User(
    surname: "Chiappetta",
    name: "Desirè",
    email: "dp@mail.com",
    address: "Nogiano",
    phoneNumber: "123456",
  );
  User? u;
  Future<User?> _loadUser() async {
    u = await Model.sharedInstance.viewUser("de@gmail.com");
    print(u?.toJson().toString());
    return u;
  }
  /*List<Order>? orders;
  Future<List<Order>?> _loadOrders() async{
    //orders = await Model.sharedInstance.getOrders("email");
    return orders;
  }
*/
  @override
  void initState(){
    super.initState();
    _loadUser().then((loadedUser){
      setState(() {
        u = loadedUser ?? user;
      });
    });
    /*
    _loadOrders().then((loadedOrders){
      setState((){
        orders = loadedOrders ?? o;
     */
  }

  final List<Order> orders = [
    Order(title: 'Ordine 1', date: '10/08/2023'),
    Order(title: 'Ordine 2', date: '12/08/2023'),
    Order(title: 'Ordine 3', date: '15/08/2023'),
  ];


  @override
  Widget build(BuildContext context) {
    _loadUser();
    print(u.toString());
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
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.start,
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
                //crossAxisAlignment: CrossAxisAlignment.center, // Allineato al centro
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

                  IconButton(
                    icon: Icon(Icons.mode),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserModificationPage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20), // Aggiunto spazio tra il profilo e la lista degli ordini
              Expanded( // Wrap ListView.builder in Expanded per darle spazio infinito in altezza
                child: ListView.builder(
                  itemCount: orders?.length,
                  itemBuilder: (context, index) {
                    final order = orders?[index];
                    return ListTile(
                      leading: Icon(Icons.shopping_cart), // Icona a sinistra
                      title: Text(order?.title ?? ""), // Titolo cliccabile al centro
                      trailing: Text(order?.date ?? ""), // Data a destra
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


