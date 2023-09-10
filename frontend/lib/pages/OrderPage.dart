import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Orders.dart';

class OrderPage extends StatelessWidget {
  final Orders order;

  OrderPage(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Order'),
      ),
      body: ListView.builder(
        itemCount: order.details.length,
        itemBuilder: (context, index) {
          final orderDetails = order.details[index];
          final product = orderDetails.product;

          return Column(
            children: [
              ListTile(
                leading: Image.network(
                  product!.uri,
                  width: 40, // Imposta la larghezza desiderata
                  height: 40, // Imposta l'altezza desiderata
                  fit: BoxFit.cover, // Imposta la modalità di adattamento dell'immagine
                ),
                title: Text(product!.name),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Text('Qty: ${orderDetails.quantity}'),
                    ),
                    Text('Price: \$${orderDetails.price!.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          );
        },
      ),
    );
  }
}

