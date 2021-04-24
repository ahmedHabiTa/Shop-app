import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/products.dart';
import 'package:graduation_shop_app/screens/edit_product_screen.dart';
import 'package:graduation_shop_app/widgets/app_drawer.dart';
import 'package:graduation_shop_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product_screen';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, AsyncSnapshot snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    child: Consumer<Products>(builder: (ctx,productData,_){
                      return Padding(padding: EdgeInsets.all(8),
                      child: ListView.builder(itemCount: productData.items.length,
                          itemBuilder: (_,int index)=>Column(
                            children: [
                              UserProductItem(productData.items[index].id,productData.items[index].title,productData.items[index].imageUrl),
                              Divider(),
                            ],
                          )),);
                    },),
                    onRefresh: () => _refreshProduct(context)),
      ),
      drawer: AppDrawer(),
    );
  }
}
