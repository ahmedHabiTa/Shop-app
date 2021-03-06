import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/products.dart';
import 'package:graduation_shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl ;

  const UserProductItem(this.id, this.title, this.imageUrl) ;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: ()=> Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id)),
            IconButton(color:Theme.of(context).errorColor,icon: Icon(Icons.delete), onPressed: ()async{
              try{
                await Provider.of<Products>(context,listen: false).deleteProduct(id);
              }catch(e){
                scaffold.showSnackBar(SnackBar(content: Text('Deleting failed!',textAlign: TextAlign.center,),));
              }
            }),
          ],
        ),
      ),
    );
  }
}
