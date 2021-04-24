import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(Icon icon, String title, Function function) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile(Icon(Icons.shop), 'shop',
              () => Navigator.of(context).pushReplacementNamed('/')),
          Divider(),
          buildListTile(
              Icon(Icons.payment),
              'Orders',
              () => Navigator.of(context)
                  .pushReplacementNamed(OrderScreen.routeName)),
          Divider(),
          buildListTile(
              Icon(Icons.edit),
              'Manage Products',
              () => Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName)),
          Divider(),
          buildListTile(Icon(Icons.exit_to_app), 'Log Out', () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context,listen: false).logOut();
          })
        ],
      ),
    );
  }
}
