import 'package:flutter/cupertino.dart';
import 'package:food_app/bloc/order/order_event.dart';
import 'package:food_app/bloc/order/order_state.dart';
import 'package:food_app/model/order_model.dart';
import 'package:food_app/repository/food_repository.dart';
import 'package:food_app/response/generic_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  FoodRepository repository;

  OrderBloc({@required this.repository});

  @override
  OrderState get initialState => OrderInitialState();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is FetchOrderEvent) {
      yield OrderLoadingState();
      try {
        List<Order> order = await repository.fetchOrderCreated(event.id);
        yield OrderLoadedState(order: order);
      } catch (e) {
        yield OrderErrorState(message: e.toString());
      }
    } else if (event is MakeOrderEvent) {
      yield OrderLoadingState();
      try {
        GenericResponse response = await repository.createOrder(
            event.quantity, event.customer_name, event.address, event.id);
        if (response.error == false)
          yield OrderLoadedState();
        else
          yield OrderErrorState(message: "order failed to load");
      } catch (e) {
        yield OrderErrorState(message: e.toString());
      }
    } else if (event is VerifyOrderEvent) {
      yield OrderLoadingState();
      try {
        GenericResponse order = await repository.verifyOrder(event.id);
        yield VerifyOrderLoadedState(order);
      } catch (e) {
        yield OrderErrorState(message: e.toString());
      }
    }
  }
}
