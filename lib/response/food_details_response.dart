import 'package:food_app/model/food_model.dart';

class FoodDetailsResponse {
  // int page;
  // String total;
  // int totalPages;
  List<Food> results;

  FoodDetailsResponse({this.results});

  FoodDetailsResponse.fromJson(Map<String, dynamic> json) {
    //page = json['page'];
    //total = json['total'];
    //totalPages = json['total_pages'];
    if (json['data'] != null) {
      results = new List<Food>();
      json['data'].forEach((v) {
        results.add(new Food.fromJson(v));
      });
    }
  }

  FoodDetailsResponse.fromSingleJson(Map<String, dynamic> json) {
    //totalPages = json['total_pages'];
    if (json['data'] != null) {
      results = new List<Food>();
      results.add(new Food.fromJson(json['data']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['page'] = this.page;
    //data['total_count'] = this.total;
    //data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['data'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
