import 'package:flutter/material.dart';
import 'package:graduation_shop_app/widgets/app_drawer.dart';
import 'package:graduation_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';
import 'package:graduation_shop_app/providers/orders.dart' show Orders;

class OrderScreen extends StatelessWidget {
  static const routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error Occurred !'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (BuildContext context, int index) =>
                      OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
