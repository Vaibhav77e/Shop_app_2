import 'package:flutter/material.dart';
import 'package:new_shop_app/screens/product_overview.dart';
import './screens/product_detail_screen.dart';
import './providers/providers_product.dart';
import 'package:provider/provider.dart';

import './screens/cart_screens.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ChangeNotifierProvider.value(
          //   value: ProvidersProduct(),
          // ),
          ChangeNotifierProxyProvider<Auth, ProvidersProduct?>(
            update: (ctx, authData, previousProduct) => ProvidersProduct(
              authData.token as String,
              previousProduct == null ? [] : previousProduct.items,
            ),
            create: (_) {},
          ),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProvider.value(
            value: Orders(),
          )
        ],
        child: Consumer<Auth>(builder: (context, authObj, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: authObj.isAuthData ? ProductOverview() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeNamed: (context) =>
                  ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          );
        }));
  }
}
    //   ChangeNotifierProvider(
    //     //instance of provided class
    //     create: (context) => ProvidersProduct(),
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'Flutter Demo',
    //       theme: ThemeData(
    //           primarySwatch: Colors.purple,
    //           accentColor: Colors.deepOrange,
    //           fontFamily: 'Lato'),
    //       home: ProductOverview(),
    //       routes: {
    //         ProductDetailScreen.routeNamed: (context) => ProductDetailScreen(),
    //       },
    //     ),
    //   );
    // }
