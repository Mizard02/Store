import 'package:flutter/material.dart';

class Product {
  final String name;
  final int quantity;
  final double price;

  Product({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class OrderWidget extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Prodotto 1', quantity: 5, price: 10.99),
    Product(name: 'Prodotto 2', quantity: 2, price: 24.99),
    // Aggiungi altri prodotti se necessario
  ];

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

      body:

      ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.shopping_cart), // Icona a sinistra
                title: Text(product.name), // Titolo cliccabile al centro
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6), // Aggiungi spazio tra la quantità e il prezzo
                      child: Text('Qty: ${product.quantity}'), // Quantità
                    ),

                    Text('Price: \$${product.price.toStringAsFixed(2)}'), // Prezzo
                  ],
                ),

              ),
              Divider( // Spazio tra un prodotto e l'altro
                height: 1, // Altezza del divider
                color: Colors.grey, // Colore del divider
              ),

            ],

          );
        },

      ),




  );
  }
}