import "package:flutter/material.dart";
import 'package:product_sqlite_app/Product.dart';
import 'package:product_sqlite_app/Database.dart';
import 'package:product_sqlite_app/ProductPage.dart';
void main() => runApp(MyApp(products : SQliteDbProvider.db.getAllProducts()));


class MyApp extends StatelessWidget {
  final Future<List<Product>> products;
  MyApp({this.products});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Product App",
        theme: ThemeData(primarySwatch: Colors.blue),
        home : MyHomePage(title : "List of products", products : products)
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final Future<List<Product>> products;

  MyHomePage({this.title, this.products});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: Center(
          child: FutureBuilder <List<Product>>(
              future: products,
              builder: (context, snapshot){
                if(snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ? ProductBoxList(items : snapshot.data) :
                Center(child: CircularProgressIndicator(),) ;
//            return ProductBoxList(items : snapshot.data);
              }
          ),
        )
    );
  }
}

class ProductBoxList extends StatelessWidget {
  final List<Product> items;
  ProductBoxList({Key key, this.items});
  @override
  Widget build(BuildContext context) {
    return ReOrderProductList(items);
  }
}
class ReOrderProductList extends StatefulWidget {
   final List<Product> items;
  ReOrderProductList(this.items);

  @override
  _ReOrderProductListState createState() => _ReOrderProductListState();
}

class _ReOrderProductListState extends State<ReOrderProductList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: List.generate(widget.items.length, (index){
        return GestureDetector(
          key: ValueKey(index),
          child: ProductBox(item : widget.items[index]),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ProductPage(item: widget.items[index])));
          },
        );
      }),
      onReorder: (startIndex, endIndex) {
       setState(() {
         Product item = widget.items.removeAt(startIndex);
         int index = endIndex > 0 ? endIndex - 1 : 0;
         print(startIndex);
         print(index);
         widget.items.insert(index, item);
       });
      },
    );
  }
}


class ProductBox extends StatelessWidget {
  final Product item;
  ProductBox({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        key: ValueKey(item.id),
        padding: EdgeInsets.all(2),
        height: 150,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset("assets/product_images/" + item.image),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(item.name,  style: TextStyle( color: Colors.green),),
                          Text(item.description, style: TextStyle( color: Colors.red),),
                          Text('Price : ${item.price.toString()}',style: TextStyle(fontFamily: "verdana", color: Colors.blue)),
                          RatingBox(),
                        ],
                      ),

                    ),
                  )
                ]
            )

        )
    );
  }
}



class RatingBox extends StatefulWidget {

  @override
  _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating = 0 ;
  void setRating(int val){
    setState(() {
      _rating = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    double _size = 20;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: (_rating >= 1 ? Icon(Icons.star, size : _size) :
              Icon(Icons.star_border, size: _size,)),
              iconSize: _size,
              color: Colors.red[500],
              onPressed:  () => setRating(1),
            )),
        Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: (_rating >= 2 ? Icon(Icons.star, size : _size) :
              Icon(Icons.star_border, size: _size,)),
              iconSize: _size,
              color: Colors.red[500],
              onPressed: () => setRating(2),
            )),
        Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: (_rating >= 3 ? Icon(Icons.star, size : _size) :
              Icon(Icons.star_border, size: _size,)),
              iconSize: _size,
              color: Colors.red[500],
              onPressed: () => setRating(3),
            ))
      ],
    );
  }
}




