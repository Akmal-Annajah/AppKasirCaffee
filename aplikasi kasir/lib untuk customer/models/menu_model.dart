class MenuModel {
  final String name;
  final String category;
  final int price;
  final String image;

  MenuModel({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      name: map['name'],
      category: map['category'],
      price: map['price'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'category': category, 'price': price, 'image': image};
  }
}
