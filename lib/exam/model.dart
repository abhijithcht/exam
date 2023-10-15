class ItemModel {
  final String id;
  final String name;
  final String price;
  final String image;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class CartModel {
  final String name;
  final String price;
  final String image;

  CartModel({
    required this.name,
    required this.price,
    required this.image,
  });
}
