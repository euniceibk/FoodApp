class Order {
  String id, customer_name, address, name_of_food, image;
  int quantity, price;
  // this is a class function
  Order.fromJson(Map<String, dynamic> json) {
    id = json['row_id'];
    customer_name = json['customer_name'];
    quantity = json['quantity'];
    address = json['address'];
    name_of_food = json['name_of_food'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['customer_name'] = this.customer_name;
    data['address'] = this.address;
    data['name_of_food'] = this.name_of_food;
    data['image'] = this.image;
    return data;
  }
}
