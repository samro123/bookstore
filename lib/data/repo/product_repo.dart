import 'dart:async';

import 'package:appbook/data/remote/product_service.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:appbook/shared/model/rest_error.dart';
import 'package:dio/dio.dart';


class ProductRepo{
    ProductService _productService;

    ProductRepo({required ProductService productService}) : _productService = productService;

    Future<List<Product>> getProductList() async{
        var c = Completer<List<Product>>();
        try{
            var response = await _productService.getProductList();
            var productList = Product.parseProductList(response.data);
            c.complete(productList);

        } on DioError{
            c.completeError(RestError.fromData('Khong co du lieu'));
        } catch (e){
            c.completeError(e);
        }
        return c.future;
    }
}