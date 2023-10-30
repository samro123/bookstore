class Product{
  String orderId;
  String productId;
  String productName;
  String productImage;
  int quantity;
  int soldItems;
  double price;

  Product({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
     this.soldItems = 0,
    required this.price
   });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      orderId: json["orderId"] ?? '',
      productId: json["productId"],
      productName: json["productName"],
      productImage: json["productImage"],
      quantity: int.parse(json["quantity"].toString()),
      price: double.tryParse(json['price'].toString()) ?? 0,
  );

  Map<String, dynamic> toJson() =>{
    "productId": productId,
    "productName":productName,
    "productImage":productImage,
    "quantity": quantity,
    "price": price,
  };

  static List<Product> parseProductList(map){
    var list = map['data'] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }
}