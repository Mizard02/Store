import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/OrderDetails.dart';
import 'package:provider/provider.dart';
import '../restManagers/HttpRequest.dart';
import '../models/Product.dart';
import '../pages/CartPage.dart';
import '../pages/ItemPage.dart';
import '../restManagers/HttpRequest.dart';

class ItemsWidget extends StatefulWidget {

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  List<Product>? products = [
    Product(
        id: 1,
        name: "Prodotto 1",
        price: 15.5,
        barCode: "SDFGHJKL",
        uri: "images/images-1.png",
        size: "S"),
    Product(
        id: 2,
        name: "Prodotto 2",
        price: 20.0,
        barCode: "ZXCVBNM",
        uri: "images/images-2.png",
        size: "S"),
  ];
  List<Product>? productList;

  Future<List<Product>?> _loadProducts() async {
    try {
      // Effettua la chiamata API per ottenere la lista dei prodotti
      productList = await Model.sharedInstance.viewProducts();
      return productList;
    } catch (e) {
      // Gestisci eventuali errori qui, ad esempio mostrando un messaggio all'utente
      print('Errore durante il caricamento dei prodotti: $e');
      return null; // Restituisce null in caso di errore
    }
  }
  @override
  void initState(){
    super.initState();
    _loadProducts().then((loadProducts){
      setState(() {
        productList = loadProducts ?? products;
      });
    });
  }


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
        for (int i = 0; i < (productList?.length ?? 0); i++)
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemPage(product: productList?[i]),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(productList?[i]?.uri ?? "images/image-1", height: 320, width: 320),
                ),
              ),

              Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    productList?[i]?.name ?? "BlaBla",
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
                      '${productList?[i]?.price.toString() ?? "12"} \$',
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
                        OrderDetails od = OrderDetails(product: productList?[i], price: productList?[i]?.price, quantity: 1);
                        // Aggiungi il prodotto al carrello
                        cartProvider.addToCart(od);
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
