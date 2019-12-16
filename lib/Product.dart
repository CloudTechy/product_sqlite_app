
class Product{
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;
  static final List<String> columns = ['id', 'name', 'description','price', 'image'];

  Product({this.id,this.name, this.description, this.price, this.image});

  factory Product.fromMap(Map<String, dynamic> json){
    return Product(
      id : json["id"],
      name : json["name"],
      description : json["description"],
      price : json["price"],
      image : json["image"],
    );
  }

   static Map<String, dynamic> toMap(Product product) => {
     "id" : product.id,
      "name" : product.name,
      "description" : product.description,
      "price" : product.price,
      "image" : product.image,
    };


}

