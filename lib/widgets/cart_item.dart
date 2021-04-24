import 'package:flutter/material.dart';
import 'package:graduation_shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;

  final int quantity;

  final double price;

  final String title;

  const CartItem(
      this.id, this.productId, this.quantity, this.price, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete,color: Colors.white,size: 40,),
      ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text('Are you Sure ?'),content:Text('Delete this from cart ?') ,actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('No')),
          FlatButton(onPressed: (){
            Navigator.of(context).pop(true);
          }, child: Text('yes')),
        ],));
        },
        key: ValueKey(id),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(title),
              subtitle: Text('Total \$${(price) * quantity}'),
              trailing: Text('$quantity x'),
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('\$$price'),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
