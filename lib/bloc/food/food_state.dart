import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/food_model.dart';

abstract class FoodState extends Equatable {}

class FoodInitialState extends FoodState {
  @override
  List<Object> get props => [];
}

class FoodLoadingState extends FoodState {
  @override
  List<Object> get props => [];
}

class FoodLoadedState extends FoodState {
  List<Food> food;

  FoodLoadedState({@required this.food});

  @override
  List<Object> get props => [];
}

class FoodDetailLoadedState extends FoodState {
  List<Food> food;

  FoodDetailLoadedState({@required this.food});

  @override
  List<Object> get props => [];
}

class FoodErrorState extends FoodState {
  String message;

  FoodErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
