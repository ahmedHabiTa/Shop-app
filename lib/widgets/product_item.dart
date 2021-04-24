import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/auth.dart';
import 'package:graduation_shop_app/providers/cart.dart';
import 'package:graduation_shop_app/providers/product.dart';
import 'package:graduation_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Hero(
            child: FadeInImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/images/product-placeholder.png'),
            ),
            tag: product.id,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(builder: (ctx, product, _) {
            return IconButton(
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.toggleFavStatus(authData.token, authData.userId);
                });
          }),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added To Cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO!',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
