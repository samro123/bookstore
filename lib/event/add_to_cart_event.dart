import 'package:appbook/base/base_event.dart';
import 'package:appbook/shared/model/product_data.dart';

class AddToCartEvent extends BaseEvent{
  Product product;
  AddToCartEvent({required this.product});
}