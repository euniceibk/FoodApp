import 'package:flutter/material.dart';
import 'package:food_app/animation/ScaleRoute.dart';
import 'package:food_app/bloc/food/food_bloc.dart';
import 'package:food_app/bloc/food/food_event.dart';
import 'package:food_app/bloc/order/order_bloc.dart';
import 'package:food_app/bloc/order/order_event.dart';
import 'package:food_app/model/food_model.dart';
import 'package:food_app/model/order_model.dart';
import 'package:food_app/pages/FoodOrderPage.dart';
import 'package:food_app/repository/food_repository.dart';
import 'package:food_app/widgets/FoodDetailsSlider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailsPage extends StatefulWidget {
  Food food;
  FoodDetailsPage({Key key, @required this.food}) : super(key: key);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

//List<Order> order = [];

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  //FoodBloc foodBloc;
  //OrderBloc orderBloc;

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  OrderBloc orderBloc;
  Food food;
  @override
  void initState() {
    //super.initState();
    OrderBloc orderBloc = BlocProvider.of<OrderBloc>(context);
    // _orderBloc = OrderBloc(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF3a3737),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          brightness: Brightness.light,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.business_center,
                  color: Color(0xFF3a3737),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => BlocProvider(
                              create: (ctx) =>
                                  OrderBloc(repository: FoodRepository()),
                              child: FoodOrderPage())));

                  //Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  widget.food.image,
                  height: 250,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                elevation: 1,
                margin: EdgeInsets.all(5),
              ),
              FoodTitleWidget(
                  productName: widget.food.name,
                  productPrice: widget.food.price,
                  productCategory: widget.food.category),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //   IconButton(
                    //       onPressed: () {},
                    //   icon: Icon(Icons.remove),
                    //   color: Colors.black,
                    //   iconSize: 30,
                    // ),
                    InkWell(
                      onTap: () {
                        String id = food.id;
                        orderBloc.add(MakeOrderEvent(id: id));
                        _showToast(context);
                      },
                      child: Container(
                        width: 200.0,
                        height: 45.0,
                        decoration: new BoxDecoration(
                          color: Color(0xFFfd2c2c),
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Add To Cart',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.add),
                    //   color: Color(0xFFfd2c2c),
                    //   iconSize: 30,
                    // ),
                  ],
                ),
              ),

              // AddToCartMenu(),
              SizedBox(
                height: 15,
              ),
              PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: TabBar(
                  labelColor: Color(0xFFfd3f40),
                  indicatorColor: Color(0xFFfd3f40),
                  unselectedLabelColor: Color(0xFFa4a1a1),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(
                      text: 'Food Details',
                    ),
                    Tab(
                      text: 'Food Reviews',
                    ),
                  ], // list of tabs
                ),
              ),
              Container(
                height: 150,
                child: TabBarView(
                  children: [
                    Container(
                        color: Colors.white24,
                        child: Container(
                          child: Text(
                            widget.food.description,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                height: 1.50),
                            textAlign: TextAlign.justify,
                          ),
                        )),
                    Container(
                        color: Colors.white24,
                        child: Container(
                          child: Text(
                            'Overall a good meal and of great value. We will certainly keep coming back.',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                height: 1.50),
                            textAlign: TextAlign.justify,
                          ),
                        )), // class name
                  ],
                ),
              ),
              BottomMenu(),
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to cart'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

class FoodTitleWidget extends StatelessWidget {
  String productName;
  String productPrice;
  String productCategory;

  FoodTitleWidget({
    Key key,
    @required this.productName,
    @required this.productPrice,
    @required this.productCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              productName,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '\₦' + productPrice,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Text(
              "by ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFa9a9a9),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              productCategory,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1f1f),
                  fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }
}

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.timelapse,
                color: Color(0xFF404aff),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "12pm-3pm",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions,
                color: Color(0xFF23c58a),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "3.5 km",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.map,
                color: Color(0xFFff0654),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Map View",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_bike,
                color: Color(0xFFe95959),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Delivery",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// class AddToCartMenu extends StatelessWidget {
//   //OrderBloc _orderBloc;
//   //FoodRepository repository;
//   Food food;
//   //List<Order> order = [];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.remove),
//             color: Colors.black,
//             iconSize: 30,
//           ),
//           InkWell(
//             onTap: () {
//               String id = food.id;
//               orderBloc.add(MakeOrderEvent(id: id));
//               _showToast(context);
//             },
//             child: Container(
//               width: 200.0,
//               height: 45.0,
//               decoration: new BoxDecoration(
//                 color: Color(0xFFfd2c2c),
//                 border: Border.all(color: Colors.white, width: 2.0),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   'Add To Cart',
//                   style: new TextStyle(
//                       fontSize: 18.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.add),
//             color: Color(0xFFfd2c2c),
//             iconSize: 30,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showToast(BuildContext context) {
//     final scaffold = Scaffold.of(context);
//     scaffold.showSnackBar(
//       SnackBar(
//         content: const Text('Added to cart'),
//         action: SnackBarAction(
//             label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
//       ),
//     );
//   }
//   // getItemAndNavigate(BuildContext context) {
//   //   Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (context) => BlocProvider(
//   //               create: (context) => FoodBloc(),
//   //               child: FoodOrderPage(id: food.id))));
//   // }
// }

// class DetailContentMenu extends StatelessWidget {
//   Food food;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(
//         food.description,
//         style: TextStyle(
//             fontSize: 14.0,
//             color: Colors.black87,
//             fontWeight: FontWeight.w400,
//             height: 1.50),
//         textAlign: TextAlign.justify,
//       ),
//     );
//   }
// }
