import 'package:product_sqlite_app/Product.dart';
import 'package:flutter/material.dart';
import 'package:product_sqlite_app/main.dart';

class ProductPage extends StatelessWidget {
  final Product item;
  ProductPage({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : Key("productPage"),
      appBar: AppBar(
        title: Text('Product ${item.name}'),
      ),
      body: Center(
          child : Container(
            padding: EdgeInsets.all(0),
            child : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Image.asset('assets/product_images/${item.image}', fit : BoxFit.cover)),
                Expanded(
                    child:  Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.name,style: TextStyle(fontFamily: "verdana", color: Colors.blue)),
                            Text(item.description, style: TextStyle(fontFamily: "verdana", color: Colors.blue)),
                            Text('Price : ${item.price.toString()}',style: TextStyle(fontFamily: "verdana", color: Colors.blue)),
                            RatingBox(),],
                        )
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}

