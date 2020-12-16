import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/order_model.dart';
import 'package:food_app/response/generic_response.dart';

abstract class OrderState extends Equatable {}

class OrderInitialState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadedState extends OrderState {
  List<Order> order;

  OrderLoadedState({@required this.order});

  @override
  List<Object> get props => [order];
}

class VerifyOrderLoadedState extends OrderState {
  VerifyOrderLoadedState(GenericResponse order);

  @override
  List<Object> get props => [];
}

class OrderErrorState extends OrderState {
  String message;

  OrderErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
