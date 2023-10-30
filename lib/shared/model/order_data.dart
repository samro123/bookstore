import 'package:appbook/shared/model/product_data.dart';

class Order{
  double total;
  List<Product> items;

  Order({
    required this.total,
    required this.items
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      total: double.parse(json["total"].toString()),
      items: parseProductList(json),
  );

  static List<Product> parseProductList(map){
    var list = map['items'] as List;
    return list.map((e) => Product.fromJson(e)).toList();
  }

}