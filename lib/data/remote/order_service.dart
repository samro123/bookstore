import 'package:appbook/network/book_client.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:dio/dio.dart';

class OrderService{
  Future<Response> countShoppingCart(){
      return BookClient.instance.dio.get(
        '/order/count',
      );
  }

  Future<Response> addToCart(Product product){
    return BookClient.instance.dio.post(
      '/order/add',
      data: product.toJson(),
    );
  }
}