import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Product.dart';
import '../pages/CartPage.dart';
import '../pages/ItemPage.dart';

class ItemsWidget extends StatelessWidget {
  final List<Product>? products;

  ItemsWidget({required this.products});


  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      //it disable the scroll functionality of gridview
      //then it will scroll in list view of home page
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < (products?.length ?? 0); i++)
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 212, 45, 33),
                      borderRadius: BorderRadius.circular(20),
                    ),

                  ),

                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemPage(product: products?[i]),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(products?[i]?.uri ?? "images/image-1", height: 320, width: 320),
                ),
              ),

              Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    products?[i]?.name ?? "BlaBla",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${products?[i]?.price.toString() ?? "12"} \$',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        // Ottieni il provider del carrello
                        final cartProvider = Provider.of<CartProvider>(context, listen: false);

                        // Aggiungi il prodotto al carrello
                        cartProvider.addToCart(products?[i]);
                      },
                    )

                  ],
                ),
              )
            ]),
          ),
      ],
    );
  }
}
