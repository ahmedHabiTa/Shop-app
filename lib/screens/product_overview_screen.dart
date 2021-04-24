import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/cart.dart';
import 'package:graduation_shop_app/providers/products.dart';
import 'package:graduation_shop_app/screens/cart_screen.dart';
import 'package:graduation_shop_app/widgets/app_drawer.dart';
import 'package:graduation_shop_app/widgets/badge.dart';
import 'package:graduation_shop_app/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOption { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isLoading = false;
  var _showOnlyFavourites = false;

  // var _isInit = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) => setState(() => _isLoading = false))
        .catchError((_) => setState(
        () => _isLoading = false ,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to the Store'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOption.Favourites,
              ),
              PopupMenuItem(
                child: Text('All Products'),
                value: FilterOption.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(value: cart.itemCount.toString(), child: ch),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
              )),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavourites),
      drawer: AppDrawer(),
    );
  }
}
