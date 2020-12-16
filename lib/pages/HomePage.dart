import 'package:flutter/material.dart';
import 'package:food_app/animation/ScaleRoute.dart';
import 'package:food_app/bloc/food/food_bloc.dart';
import 'package:food_app/bloc/food/food_event.dart';
import 'package:food_app/bloc/food/food_state.dart';
import 'package:food_app/model/food_model.dart';
import 'package:food_app/pages/SignInPage.dart';
import 'package:food_app/repository/food_repository.dart';
import 'package:food_app/widgets/BestFoodWidget.dart';
import 'package:food_app/widgets/BottomNavBarWidget.dart';
import 'package:food_app/widgets/PopularFoodsWidget.dart';
import 'package:food_app/widgets/SearchWidget.dart';
import 'package:food_app/widgets/TopMenus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final FoodRepository foodRepository = FoodRepository();
  //
  // const HomePage({Key key, this.foodRepository})
  //     : //assert(foodRepository != null),
  //       super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //FoodBloc foodBloc;

  @override
  void initState() {
    super.initState();
    // foodBloc = BlocProvider.of<FoodBloc>(context);
    // foodBloc.add(FetchFoodListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Material(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFFAFAFA),
              elevation: 0,
              title: Text(
                "What would you like to eat?",
                style: TextStyle(
                    color: Color(0xFF3a3737),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              brightness: Brightness.light,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: Color(0xFF3a3737),
                    ),
                    onPressed: () {
                      Navigator.push(context, ScaleRoute(page: SignInPage()));
                    })
              ],
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SearchWidget(),
                    TopMenus(),
                    BlocProvider(
                      create: (context) =>
                          FoodBloc(repository: FoodRepository()),
                      child:
                          PopularFoodsWidget(foodRepository: FoodRepository()),
                    ),
                    BestFoodWidget(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavBarWidget(),
          ),
        );
      }),
    );
  }

  // Widget buildFoodWidget(List<Food> food) {
  //   return Container(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: <Widget>[
  //           SearchWidget(),
  //           TopMenus(),
  //           PopularFoodsWidget(),
  //           BestFoodWidget(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
