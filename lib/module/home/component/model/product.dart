class Product {
  final int id, price;
  final String title, coutry, image;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.coutry,
    required this.image});
}

// list of products
// for our demo
List<Product> product = [
  Product(
    id: 1,
    price: 56,
    title: "Classic",
    image: "assets/images/image_1.png",
    coutry:"Russia"
  ),
  Product(
    id: 4,
    price: 68,
    title: "Poppy",
    image: "assets/images/image_2.png",
    coutry:
    "Vietnam",
  ),
  Product(
    id: 9,
    price: 39,
    title: "Bar Stool Chair",
    image: "assets/images/image_3.png",
    coutry:"China"
  ),
];