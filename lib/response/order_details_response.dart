import 'package:food_app/model/order_model.dart';

class OrderDetailsResponse {
  int page;
  String total;
  int totalPages;
  List<Order> results;

  OrderDetailsResponse({this.page, this.total, this.totalPages, this.results});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    //page = json['page'];
    total = json['total'];
    //totalPages = json['total_pages'];
    if (json['data'] != null) {
      results = new List<Order>();
      json['data'].forEach((v) {
        results.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['page'] = this.page;
    data['total_count'] = this.total;
    // data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
