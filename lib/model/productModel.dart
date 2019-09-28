class Product {
  String id;
  String price;
  String name;
  String img;
  String desc;

  Product({this.id, this.price, this.name,this.img,this.desc});

  Product.fromMap(Map snapshot, String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['title'] ?? '',
        img = snapshot['image'] ?? '',
        desc = snapshot['description'] ?? '';

  toJson() {
    return {
      "price": price,
      "title": name,
      "image": img,
      "description": desc,
    };
  }
}