import 'dart:async';

import 'package:appbook/base/base_bloc.dart';
import 'package:appbook/base/base_event.dart';
import 'package:appbook/data/repo/order_repo.dart';
import 'package:appbook/data/repo/product_repo.dart';
import 'package:appbook/event/add_to_cart_event.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:appbook/shared/model/shopping_cart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc with ChangeNotifier{
  final ProductRepo _productRepo;
  final OrderRepo _orderRepo;

  var _shoppingCart = ShoppingCart();

  static HomeBloc? _instance;

  static HomeBloc? getInstance({
    required ProductRepo productRepo,
    required OrderRepo orderRepo,
  }) {
    if (_instance == null) {
      _instance = HomeBloc._internal(
        productRepo: productRepo,
        orderRepo: orderRepo,
      );
    }
    return _instance;
  }

  HomeBloc._internal({
    required ProductRepo productRepo,
    required OrderRepo orderRepo,
  })  : _productRepo = productRepo,
        _orderRepo = orderRepo;

  final _shoppingCardSubject = BehaviorSubject<ShoppingCart>();

  Stream<ShoppingCart> get shoppingCartStream => _shoppingCardSubject.stream;
  Sink<ShoppingCart> get shoppingCartSink => _shoppingCardSubject.sink;

  @override
  void dispatchEvnet(BaseEvent event) {
    switch (event.runtimeType){
      case AddToCartEvent:

    }
  }

  handleAddToCart(event){
      AddToCartEvent addToCartEvent = event as AddToCartEvent;
      _orderRepo.addToCart(addToCartEvent.product).then((shoppingCart){
        shoppingCart.orderId = _shoppingCart.orderId;
        print(shoppingCart);
        shoppingCartSink.add(shoppingCart);
      });
  }

  getShoppingCartInfo(){
    Stream<ShoppingCart>.fromFuture(_orderRepo.getShoppingCartInfo())
        .listen((shoppingCart) {
          _shoppingCart = shoppingCart;
          shoppingCartSink.add(shoppingCart);
    });
  }

  Stream<List<Product>> getProductList(){
    return Stream<List<Product>>.fromFuture(_productRepo.getProductList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _shoppingCardSubject.close();
  }
}