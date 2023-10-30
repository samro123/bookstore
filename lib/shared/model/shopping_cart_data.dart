class ShoppingCart{
  String orderId;
  int total;

  ShoppingCart({
     this.orderId = '',
     this.total = 0
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
      orderId: json['orderId'] ?? '',
      total: json['json'] ?? 0
  );
}