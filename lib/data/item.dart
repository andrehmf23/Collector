class Item {
  int id;
  String name;
  double price;
  String description;
  bool purchased;
  
  String photo;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.purchased,
    this.photo = ''
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price']?.toDouble(),
      description: json['description'],
      purchased: json['purchased'],
      photo: json['photo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'purchased': purchased,
      'photo': photo
    };
  }
}
