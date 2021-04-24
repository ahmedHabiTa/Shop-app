import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/products.dart';
import 'package:provider/provider.dart';
class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,listen: false).findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(tag: loadedProduct.id,child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover,),),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: 10,),
            Text('\$${loadedProduct.price}',style: TextStyle(fontSize: 20,color: Colors.grey),textAlign: TextAlign.center,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(loadedProduct.description,textAlign: TextAlign.center,softWrap: true,),
            ),

          ])),
        ],
      ),
    );
  }
}
