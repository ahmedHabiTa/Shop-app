import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/auth.dart';
import 'package:graduation_shop_app/providers/orders.dart';
import 'package:graduation_shop_app/providers/products.dart';
import 'package:graduation_shop_app/screens/auth_screen.dart';
import 'package:graduation_shop_app/screens/cart_screen.dart';
import 'package:graduation_shop_app/screens/edit_product_screen.dart';
import 'package:graduation_shop_app/screens/orders_screen.dart';
import 'package:graduation_shop_app/screens/product_detail_screen.dart';
import 'package:graduation_shop_app/screens/splash_screen.dart';
import 'package:graduation_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import './screens/product_overview_screen.dart';
import 'providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,Products>(
            create: (_) => Products(),
            update: (ctx,authValue,previousProduct) => previousProduct..getData(
                authValue.token,
                authValue.userId,
                previousProduct == null ? null : previousProduct.items),
            ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth,Orders>(
          create: (_) => Orders(),
          update: (ctx,authValue,previousOrders) => previousOrders..getData(
              authValue.token,
              authValue.userId,
              previousOrders == null ? null : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: Colors.purple,
              fontFamily: 'Lato'),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, AsyncSnapshot authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
            CartScreen.routeName: (_) => CartScreen(),
            OrderScreen.routeName: (_) => OrderScreen(),
            UserProductScreen.routeName: (_) => UserProductScreen(),
            EditProductScreen.routeName: (_) => EditProductScreen(),
            SplashScreen.routeName: (_) => SplashScreen(),
          },
        ),
      ),
    );
  }
}
