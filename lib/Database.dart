import 'package:product_sqlite_app/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
//import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class SQliteDbProvider{
  SQliteDbProvider._();
  static final SQliteDbProvider db = SQliteDbProvider._();
  static Database _database;

  Future <Database> get database async{
    if(_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "Products.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db,int version) async{
        await db.execute("CREATE TABLE products ("
            "id INTEGER PRIMARY KEY autoincrement,"
            "name TEXT,"
            "price INTEGER,"
            "description TEXT,"
            "image Text"
            ")" );
        await db.transaction((txn) async {
          txn.execute("INSERT INTO products ( 'name', 'description','price', 'image') VALUES (?,?,?,?)",
              [ "iphone", "a quality iphone", 1000, "iphone.png"]);
        });
        await db.transaction((txn) async {
          txn.execute("INSERT INTO products ( 'name', 'description','price', 'image') VALUES (?,?,?,?)",
              [ "pixel", "a quality pixel", 2000, "pixel.png"]);
        });
        await db.transaction((txn) async {
          txn.execute("INSERT INTO products ( 'name', 'description','price', 'image') VALUES (?,?,?,?)",
              [ "laptop", "a quality laptop", 1900, "laptop.png"]);
        });
        await db.transaction((txn) async {
          txn.execute("INSERT INTO products ( 'name', 'description','price', 'image') VALUES (?,?,?,?)",
              [ "tablet", "a quality tablet", 700, "tablet.png"]);
        });
        await db.transaction((txn) async {
          txn.execute("INSERT INTO products ( 'name', 'description','price', 'image') VALUES (?,?,?,?)",
              [ "Pendrive", "a quality pendrive", 2000, "pendrive.png"]);
        });
        await db.transaction((txn) async {
          txn.execute("INSERT INTO products ( 'name', 'description','price', 'image') VALUES (?,?,?,?)",
              [ "Floppy drive", "a quality floppydisk", 3000, "floppydisk.png"]);
        });
    },
    );
  }
  Future <List<Product>> getAllProducts() async{
    final db = await database;
    List<Map> results = await db.query("products", columns : Product.columns, orderBy: "id ASC");
    List<Product> products = new List();
    results.forEach((item) => products.add(Product.fromMap(item)));
    return products;
  }

  Future<Product> getProductById(int id) async{
    final db = await database;
    List<Map> result = await db.query('products', columns: Product.columns, where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? Product.fromMap(result.first) : null;
  }

  insert(Product product) async {
    final db = await database;
    var result = db.insert("products",  Product.toMap(product));
    return result;
  }

  update(Product product) async {
    final db = await database;
    var result = db.update('products', Product.toMap(product), where: "id = ?", whereArgs: [product.id]);
    return result;
  }

  delete(int id) async{
    final db = await database;
    var result = db.delete("products", where: "id = ?", whereArgs: [id]);
    return result;
  }

}
