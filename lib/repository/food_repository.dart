import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_app/model/food_model.dart';
import 'package:food_app/model/order_model.dart';
import 'package:food_app/repository/api_client.dart';
import 'package:food_app/response/food_details_response.dart';
import 'package:food_app/response/generic_response.dart';
import 'package:food_app/response/order_details_response.dart';
import 'package:food_app/utility/constants.dart' as Constants;
import 'package:http/http.dart' as http;

abstract class FoodRepositoryImpl {
  Future<List<Food>> searchFood(String searchQuery);
  Future<FoodDetailsResponse> fetchFoodPage(String foodId);
  Future<List<Order>> fetchOrderCreated(String orderId);
  Future<GenericResponse> createOrder(String customer_name, String quantity,
      String address, String id);
  Future<GenericResponse> verifyOrder(String id);
  Future<List<Food>> fetchFoodList();
}

class FoodRepository extends FoodRepositoryImpl {
  ApiClient _apiClient = ApiClient();

  // void openCache() async {
  //   prefs =  await SharedPreferences.getInstance();
  // }
  //
  // void saveSportToCache(String sportResponse) async {
  //   await openCache();
  //   // check if the key even exists
  //   prefs.setString("cachedSport",sportResponse);
  //   print("cache saved success : " + sportResponse);
  // }

  @override
  Future<List<Food>> searchFood(String searchQuery) async {
    var body = jsonEncode(<String, String>{'search_word': searchQuery});
    final response = await _apiClient.httpClient
        .post(Constants.FOOD_LIST, headers: Constants.headers, body: body);

    final json = jsonDecode(response.body);
    if (json('response') == "OK") {
      return FoodDetailsResponse.fromJson(json).results;
    } else {
      throw new Exception('error finding food');
    }
  }

  Future<List<Food>> fetchFoodList() async {
    final response = await _apiClient.get(Constants.FOOD_LIST);
    final json = jsonDecode(response);
    //print(FoodDetailsResponse.fromJson(json.results));
    return FoodDetailsResponse.fromJson(json).results;
    // if (json('response') == "OK") {
    //   return FoodDetailsResponse.fromJson(json).results;
    // } else {
    //   throw new Exception('error finding food');
    // }
  }

  @override
  Future<FoodDetailsResponse> fetchFoodPage(String foodId) async {
    var body = jsonEncode(<String, String>{
      'id': foodId,
    });

    final response = await _apiClient.post(Constants.FOOD_DETAIL, body);
    final data = json.decode(response);
    return FoodDetailsResponse.fromSingleJson(data);
  }

  @override
  Future<List<Order>> fetchOrderCreated(String orderId) async {
    var body = jsonEncode(<String, String>{
      'row_id': orderId,
    });

    final response = await _apiClient.post(Constants.SINGLE_ORDER, body);
    var data = json.decode(response);
    OrderDetailsResponse orderDetailsResponse =
        OrderDetailsResponse.fromJson(data);
    return orderDetailsResponse.results;
  }

  @override
  Future<GenericResponse> createOrder(String customer_name, String quantity,
      String address, String id) async {
    var body = jsonEncode(<String, String>{
      'customer_name': customer_name,
      'quantity': quantity,
      'address': address,
      'id_of_food' : id
    });
    final response = await _apiClient.post(Constants.MAKE_ORDER, body);
    var json = jsonDecode(response);
    return GenericResponse.fromJson(json);
  }

  @override
  Future<GenericResponse> verifyOrder(String id) async {
    var body = jsonEncode(<String, String>{'id': id});
    final response = await _apiClient.post(Constants.VERIFY_ORDER, body);
    var json = jsonDecode(response);
    return GenericResponse.fromJson(json);
  }
}
