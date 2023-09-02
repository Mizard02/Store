import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/UserModificationPage.dart';
import '../models/Orders.dart';
import '../models/OrderDetails.dart';
import '../models/Product.dart';
import '../models/User.dart';
import '../restManagers/HttpRequest.dart';
import 'OrderPage.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  User user = User(
    surname: "Chiappetta",
    name: "Desirè",
    email: "dp@mail.com",
    address: "Nogiano",
    phoneNumber: "123456",
  );

  List<Orders> o = [
    Orders(
        emailUser:"desy@gmail.com",
        details: [OrderDetails(
            product: Product(
              name: "Prodotto",
              price: 13.33,
              quantity: 2,
              barCode: "FGBD",
              uri: "images/image-1.png",
              size: "S", id: 1,
            ),
            price: 13.33,
            quantity: 1
        ),]
    ),
  ];
  List<Orders>? orders;
  User? u;
  String? email;
  Stream<List<Orders>>? _ordersStream;
  Future<User?> _loadUser(String email) async {
    u = await Model.sharedInstance.viewUser(email);
    print(u?.toJson().toString());
    return u;
  }
  String? _loadEmail() {
    email =  Model.sharedInstance.getClientFromToken();
    return email;
  }


  @override
  void initState() {
    super.initState();
    String? e = _loadEmail() ?? "dp@gmail.com";
    _loadUser(e).then((loadedUser) {
      setState(() {
        u = loadedUser ?? user;
      });
    });
    _ordersStream = Model.sharedInstance.viewOrders(e);
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String formattedDate = "${today.day}/${today.month}/${today.year}";
    String newSurname ="", newName="", newPhoneNumber="", newEmail="", newAddress="";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD1C4E9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Summary Data'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
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
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined),
                      SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text('Surname: '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(u?.surname ?? ""),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Modify Surname"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Surname"),
                                            TextFormField(
                                              onChanged: (value) {
                                                newSurname = value; // Aggiorna la variabile con il nuovo cognome
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              // Chiudi il popup e chiama la funzione per la modifica
                                              Navigator.of(context).pop();
                                              await Model.sharedInstance.modifyUser(u?.email, newSurname, "surname" );
                                              setState(() {
                                                u?.surname = newSurname;
                                              });
                                            },
                                            child: Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Chiudi il popup senza modifiche
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text("Modify"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined),
                      SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text('Name: '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(u?.name ?? ""),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Modify Name"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Name"),
                                            TextFormField(
                                              onChanged: (value) {
                                                newName = value; // Aggiorna la variabile con il nuovo cognome
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async{
                                              // Chiudi il popup e chiama la funzione per la modifica
                                              Navigator.of(context).pop();
                                              await Model.sharedInstance.modifyUser(u?.email, newName, "name");
                                              setState(() {
                                                u?.name = newName;
                                              });
                                            },
                                            child: Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Chiudi il popup senza modifiche
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text("Modify"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone_outlined),
                      SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text('Phone number: '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(u?.phoneNumber ?? ""),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Phone Number"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Phone Number"),
                                            TextFormField(
                                              onChanged: (value) {
                                                newPhoneNumber = value; // Aggiorna la variabile con il nuovo cognome
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              // Chiudi il popup e chiama la funzione per la modifica
                                              Navigator.of(context).pop();
                                              await Model.sharedInstance.modifyUser(u?.email,newPhoneNumber,"phoneNumber" );
                                              setState(() {
                                                u?.phoneNumber = newPhoneNumber;
                                              });
                                            },
                                            child: Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Chiudi il popup senza modifiche
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text("Modify"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text('Address: '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(u?.address ?? ""),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Modify Address"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Address"),
                                            TextFormField(
                                              onChanged: (value) {
                                                newAddress = value; // Aggiorna la variabile con il nuovo cognome
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async{
                                              // Chiudi il popup e chiama la funzione per la modifica
                                              Navigator.of(context).pop();
                                              await Model.sharedInstance.modifyUser("email", newAddress, "address") ;
                                              setState(() {
                                                u?.address = newAddress;
                                              });
                                            },
                                            child: Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Chiudi il popup senza modifiche
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text("Modify"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text('Email: '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(u?.email ?? ""),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Email"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Email"),
                                            TextFormField(
                                              onChanged: (value) {
                                                newEmail = value; // Aggiorna la variabile con il nuovo cognome
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async{
                                              // Chiudi il popup e chiama la funzione per la modifica
                                              Navigator.of(context).pop();
                                              await Model.sharedInstance.modifyUser(u?.email, newEmail, "email" );
                                              setState(() {
                                                u?.email = newEmail;
                                              });
                                            },
                                            child: Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Chiudi il popup senza modifiche
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text("Modify"),
                              ),
                            ],
                          ),

                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: Icon(Icons.mode),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserModificationPage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
          StreamBuilder<List<Orders>>(
            stream: _ordersStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('Nessun ordine disponibile.');
              } else {
                // Visualizza l'elenco degli ordini qui
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text("Order $index"),
                        trailing: Text(formattedDate),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderPage(order),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            },
          )
            ],
          ),
        ),
      ),
    );
  }
}