import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food/food_event.dart';
import 'package:food_app/bloc/food/food_state.dart';
import 'package:food_app/model/food_model.dart';
import 'package:food_app/repository/food_repository.dart';
import 'package:food_app/response/food_details_response.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository repository;

  FoodBloc({@required this.repository});

  @override
  FoodState get initialState => FoodInitialState();

  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FetchFoodListEvent) {
      yield FoodLoadingState();
      try {
        List<Food> food = await repository.fetchFoodList();
        yield FoodLoadedState(food: food);
      } catch (e) {
        yield FoodErrorState(message: e.toString());
      }
    } else if (event is FetchFoodDetailEvent) {
      yield FoodLoadingState();
      // try {
      //   Food food = await repository.fetchFoodPage(event.id);
      //   yield FoodDetailLoadedState(food: food);
      // }
      try {
        List<Food> food;
        FoodDetailsResponse fr = await repository.fetchFoodPage(event.id);
        food = fr.results;
        yield FoodDetailLoadedState(food: food);
        print('state expected to be yielded');
      } catch (e) {
        yield FoodErrorState(message: e.toString());
      }
    }
  }
}
