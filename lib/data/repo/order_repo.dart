import 'dart:async';

import 'package:appbook/data/remote/order_service.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:appbook/shared/model/shopping_cart_data.dart';
import 'package:dio/dio.dart';

class OrderRepo{
   OrderService _orderService;
   OrderRepo({required OrderService orderService}) : _orderService = orderService;

   Future<ShoppingCart> addToCart(Product product) async{
         var c = Completer<ShoppingCart>();
         try{
            var response = await _orderService.addToCart(product);
            var shoppingCart = ShoppingCart.fromJson(response.data['data']);
            c.complete(shoppingCart);
         } on DioError{
            c.completeError('Error order');
         } catch (e){
            c.completeError(e);
         }
         return c.future;
   }

   Future<ShoppingCart> getShoppingCartInfo() async{
      var c = Completer<ShoppingCart>();
      try{
         var response = await _orderService.countShoppingCart();
         var shoppingCart = ShoppingCart.fromJson(response.data['data']);
         c.complete(shoppingCart);
      }on DioError{
         c.completeError('Error don hang');
      } catch(e){
         c.completeError(e);
      }
      return c.future;
   }
}