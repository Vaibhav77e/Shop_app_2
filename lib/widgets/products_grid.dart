import 'package:flutter/material.dart';
import '../providers/providers_product.dart';

import './product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showfavs;
  ProductsGrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    //helps in building direct connection b/w this widget and provider_product.dart

    final productData = Provider.of<ProvidersProduct>(context);
    final product = showfavs ? productData.favoriatesItems : productData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: product.length,
        //gridDelegate tells us structure of widget exactyly how many olumns should be there
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        // how grid should built
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            //helps to setup individual providers for each products.
            // create: (newcontext) => product[index] ---> recommend to use vale method for the existing object lectno-199
            value: product[index],
            child: ProductItem(
                // product[index].id, product[index].title,
                //   product[index].imageUrl
                ))));
  }
}
