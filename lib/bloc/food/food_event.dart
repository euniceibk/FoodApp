import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FoodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFoodListEvent extends FoodEvent {
  @override
  List<Object> get props => [];
}

class FetchFoodDetailEvent extends FoodEvent {
  final String id;

  FetchFoodDetailEvent({@required this.id});

  @override
  List<Object> get props => [];
}
