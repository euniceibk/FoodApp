class Food {
  String id, image, price, category, available, name, description;
  // this is a class function
  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    category = json['category'];
    available = json['available'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['category'] = this.category;
    data['available'] = this.available;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
