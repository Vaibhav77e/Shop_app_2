import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers_product.dart';

class ProductDetailScreen extends StatelessWidget {
  //receving title as an object
  // final String title;
  // ProductDetailScreen(this.title);

  static const routeNamed = '/product-details-screen';

  @override
  Widget build(BuildContext context) {
    //extract id from product_item.dart
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    // here accesing other property using id
    final loadedProduct = Provider.of<ProvidersProduct>(context, listen: false)
        .findbyId(
            productId); //when widget is update only once then listen is set to false,to avoid rebuilding of this widget

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '₹ ${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
