import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderEvent extends Equatable {}

@override
List<Object> get props => [];

class MakeOrderEvent extends OrderEvent {
  //String id;
  final String id, customer_name, quantity, address;

  MakeOrderEvent(
      {@required this.address, this.customer_name, this.quantity, this.id});

  @override
  List<Object> get props => [];
}

class FetchOrderEvent extends OrderEvent {
  String id;

  FetchOrderEvent({@required this.id});

  @override
  List<Object> get props => [];
}

class VerifyOrderEvent extends OrderEvent {
  String id;

  VerifyOrderEvent({@required this.id});

  @override
  List<Object> get props => [];
}
