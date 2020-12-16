import 'package:flutter/material.dart';
import 'package:food_app/animation/RotationRoute.dart';
import 'package:food_app/animation/ScaleRoute.dart';
import 'package:food_app/bloc/food/food_bloc.dart';
import 'package:food_app/bloc/food/food_event.dart';
import 'package:food_app/bloc/food/food_state.dart';
import 'package:food_app/bloc/order/order_bloc.dart';
import 'package:food_app/model/food_model.dart';
import 'package:food_app/pages/FoodDetailsPage.dart';
import 'package:food_app/repository/food_repository.dart';
import 'package:food_app/resusable_widgets/bottom_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularFoodsWidget extends StatefulWidget {
  final FoodRepository foodRepository;

  PopularFoodsWidget({Key key, this.foodRepository}) : super(key: key);

  // PopularFoodsWidget({Key key, this.foodRepository})
  //     : assert(foodRepository != null),
  //       super(key: key);

  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<PopularFoodsWidget> {
  FoodBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<FoodBloc>(context);
    _bloc.add(FetchFoodListEvent());
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularFoodTitle(),
          Expanded(child: PopularFoodTiles()),
          // Builder(
          //   builder: (context) {
          //     return Material(
          //       child: Expanded(
          //         child: BlocListener<FoodBloc, FoodState>(
          //           listener: (context, state) {
          //             if (state is FoodErrorState) {
          //               Scaffold.of(context).showSnackBar(
          //                 SnackBar(
          //                   content: Text(state.message),
          //                 ),
          //               );
          //             }
          //           },
          //           child: BlocBuilder<FoodBloc, FoodState>(
          //             builder: (context, state) {
          //               if (state is FoodInitialState) {
          //                 return buildLoading();
          //               } else if (state is FoodLoadingState) {
          //                 return buildLoading();
          //               } else if (state is FoodLoadedState) {
          //                 return PopularFoodTiles();
          //                 // return ListView.builder(itemBuilder: (context, int index){
          //                 //   return index >= state.food.length ? BottomLoader(): PopularFoodTiles(food: state.food[index]);
          //                 // },
          //                 //     itemCount: food.length,
          //               } else if (state is FoodErrorState) {
          //                 return buildErrorUi(state.message);
          //               } else {
          //                 return buildErrorUi("something went wrong");
          //               }
          //             },
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class PopularFoodTiles extends StatelessWidget {
  //final FoodRepository foodRepository;

  //BuildContext context;

  //const PopularFoodTiles({Key key, this.foodRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            child: BlocListener<FoodBloc, FoodState>(
              listener: (context, state) {
                if (state is FoodErrorState) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<FoodBloc, FoodState>(
                builder: (context, state) {
                  if (state is FoodInitialState) {
                    return buildLoading();
                  } else if (state is FoodLoadingState) {
                    return buildLoading();
                  } else if (state is FoodLoadedState) {
                    return buildFoodList(state.food);
                  } else if (state is FoodErrorState) {
                    return buildErrorUi(state.message);
                  }
                  return buildErrorUi('Error loading food list');
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFoodList(List<Food> food) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: food.length,
      itemBuilder: (ctx, pos) {
        return Container(
          height: 265,
          child: InkWell(
            onTap: () {
              Food fd = food[pos];
              Navigator.push(
                  ctx,
                  MaterialPageRoute(
                      builder: (ctx) => BlocProvider(
                          create: (ctx) => OrderBloc(),
                          child: FoodDetailsPage(food: fd))));
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(boxShadow: [
                /* BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),*/
              ]),
              child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Container(
                    width: 170,
                    height: 210,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                alignment: Alignment.topRight,
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 5, top: 5),
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white70,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFfae3e2),
                                          blurRadius: 25.0,
                                          offset: Offset(0.0, 0.75),
                                        ),
                                      ]),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Color(0xFFfb3132),
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  food[pos].image,
                                  //'assets/images/' + name + ".png",
                                  width: 130,
                                  height: 140,
                                ),
                              )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: Text(food[pos].name,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Color(0xFF6e6e71),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 5),
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFfae3e2),
                                        blurRadius: 25.0,
                                        offset: Offset(0.0, 0.75),
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.near_me,
                                  color: Color(0xFFfb3132),
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(food[pos].category,
                                      style: TextStyle(
                                          color: Color(0xFFfb3132),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(food[pos].available,
                                      style: TextStyle(
                                          color: Color(0xFF6e6e71),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  EdgeInsets.only(left: 5, top: 5, right: 5),
                              child: Text('\₦' + food[pos].price,
                                  style: TextStyle(
                                      color: Color(0xFF6e6e71),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

// void navigateToFoodDetailPage(
//     BuildContext context, Food food) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BlocProvider(
//       create: (context) => FoodBloc(),
//       child:  FoodDetailsPage(foodRepository: FoodRepository()));
// }

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Popluar Foods",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Text(
            "See all",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}

// class PopularFoodItems extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       scrollDirection: Axis.horizontal,
//       children: <Widget>[
//         PopularFoodTiles(
//             name: "Fried Egg",
//             image: "ic_popular_food_1",
//             category: '4.9',
//             available: '200',
//             price: '15.06',
//             slug: "fried_egg"),
//         PopularFoodTiles(
//             name: "Mixed Vegetable",
//             image: "ic_popular_food_3",
//             category: "4.9",
//             available: "100",
//             price: "17.03",
//             slug: ""),
//         PopularFoodTiles(
//             name: "Salad With Chicken",
//             image: "ic_popular_food_4",
//             category: "4.0",
//             available: "50",
//             price: "11.00",
//             slug: ""),
//         PopularFoodTiles(
//             name: "Mixed Salad",
//             image: "ic_popular_food_5",
//             category: "4.00",
//             available: "100",
//             price: "11.10",
//             slug: ""),
//         PopularFoodTiles(
//             name: "Red meat,Salad",
//             image: "ic_popular_food_2",
//             category: "4.6",
//             available: "150",
//             price: "12.00",
//             slug: ""),
//         PopularFoodTiles(
//             name: "Mixed Salad",
//             image: "ic_popular_food_5",
//             category: "4.00",
//             available: "100",
//             price: "11.10",
//             slug: ""),
//         PopularFoodTiles(
//             name: "Potato,Meat fry",
//             image: "ic_popular_food_6",
//             category: "4.2",
//             available: "70",
//             price: "23.0",
//             slug: ""),
//         PopularFoodTiles(
//             name: "Fried Egg",
//             image: "ic_popular_food_1",
//             category: '4.9',
//             available: '200',
//             price: '15.06',
//             slug: "fried_egg"),
//         PopularFoodTiles(
//             name: "Red meat,Salad",
//             image: "ic_popular_food_2",
//             category: "4.6",
//             available: "150",
//             price: "12.00",
//             slug: ""),
//       ],
//     );
//   }
// }
