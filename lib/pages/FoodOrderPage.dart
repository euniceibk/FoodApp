import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/bloc/order/order_bloc.dart';
import 'package:food_app/bloc/order/order_event.dart';
import 'package:food_app/bloc/order/order_state.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/model/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FoodOrderPage extends StatefulWidget {
  final Order order;
  //final String id;
  //int index;

  const FoodOrderPage({Key key, this.order}) : super(key: key);
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  OrderBloc orderBloc;
  //Order order;
  var customerName = TextEditingController();
  var address = TextEditingController();
  int quantity = 0;
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    // ChangeNotifierProvider<Cart>(create: (_) => Cart());

    orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(MakeOrderEvent(
        quantity: widget.order.quantity.toString(),
        address: widget.order.address,
        customer_name: widget.order.customer_name,
        id: widget.order.id));
  }

  int counter = 0;
  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Center(
            child: Text(
              "Item Carts",
              style: TextStyle(
                  color: Color(0xFF3a3737),
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          brightness: Brightness.light,
          actions: <Widget>[
            CartIconWithBadge(),
          ],
        ),
        body: Builder(builder: (context) {
          return Consumer<Cart>(builder: (context, orders, child) {
            print(
                "item before modification :" + orders.items.length.toString());
            orders.initializeItem(new List<Order>());
            print("item after modification :" + orders.items.length.toString());
            return SingleChildScrollView(
                child: BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderErrorState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Could not load order"),
                  ));
                }
              },
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderInitialState) {
                    return buildLoading();
                  } else if (state is OrderLoadingState) {
                    return buildLoading();
                  } else if (state is OrderLoadedState) {
                    return buildOrderList(state.order);
                  } else if (state is OrderErrorState) {
                    return buildErrorUi("couldn't load order");
                  } else {
                    return buildErrorUi("Something went wrong!");
                  }
                },
                //child: new ListView.builder(itemBuilder: null)
              ),
              // Container(
              //   padding: EdgeInsets.all(15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.only(left: 5),
              //         child: Text(
              //           "Your Food Cart",
              //           style: TextStyle(
              //               fontSize: 20,
              //               color: Color(0xFF3a3a3b),
              //               fontWeight: FontWeight.w600),
              //           textAlign: TextAlign.left,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       ListView.builder(shrinkWrap: true, itemCount: 1,itemBuilder: (BuildContext ctxt, int index){
              //         return CartItem(
              //             productName: widget.order.name_of_food,
              //             productPrice: widget.order.price,
              //             productImage: widget.order.image,
              //             productCartQuantity: widget.order.quantity)
              //       }),
              //       CartItem(
              //           productName: "Grilled Salmon",
              //           productPrice: "\$96.00",
              //           productImage: "ic_popular_food_1",
              //           productCartQuantity: "2"),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       CartItem(
              //           productName: "Meat vegetable",
              //           productPrice: "\$65.08",
              //           productImage: "ic_popular_food_4",
              //           productCartQuantity: "5"),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       PromoCodeWidget(),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       TotalCalculationWidget(),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       Container(
              //         padding: EdgeInsets.only(left: 5),
              //         child: Text(
              //           "Payment Method",
              //           style: TextStyle(
              //               fontSize: 20,
              //               color: Color(0xFF3a3a3b),
              //               fontWeight: FontWeight.w600),
              //           textAlign: TextAlign.left,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       PaymentMethodWidget(),
              //     ],
              //   ),
              // ),
            ));
          });
        }));
  }

  Widget buildOrderList(List<Order> order) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Your Food Cart",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.order.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return CartItem(
                    productName: widget.order.name_of_food,
                    productPrice: '\₦' + widget.order.price.toString(),
                    productImage: widget.order.image,
                    productCartQuantity: widget.order.quantity.toString());
              }),
          SizedBox(
            height: 10,
          ),
          PromoCodeWidget(),
          SizedBox(
            height: 10,
          ),
          TotalCalculationWidget(order: order),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Payment Method",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          PaymentMethodWidget(),
        ],
      ),
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

class PaymentMethodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
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
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/menus/ic_credit_card.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Text(
                "Credit/Debit Card",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TotalCalculationWidget extends StatelessWidget {
  final List<Order> order;

  const TotalCalculationWidget({Key key, this.order}) : super(key: key);

  @override
  Widget totalCalculationWidget(List<Order> order) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
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
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 15,
              // ),
              ListView.builder(
                  itemCount: order.length,
                  itemBuilder: (context, pos) {
                    return Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${order[pos].name_of_food}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            (order[pos].price * order[pos].quantity).toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "\$" + totalOrder(order),
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String totalOrder(List<Order> order) {
    int totalAmount = 0;
    for (int i = 0; i < order.length; i++) {
      totalAmount = totalAmount + ((order[i].price) * (order[i].quantity));
    }
    return totalAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return totalCalculationWidget(order);
  }
}

class PromoCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 3, right: 3),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0xFFfae3e2).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ]),
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: Colors.white,
                  hintText: 'Enter your name',
                  filled: true,
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Color(0xFFfd2c2c),
                      ),
                      onPressed: () {
                        debugPrint('222');
                      })),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 3, right: 3),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0xFFfae3e2).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ]),
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: Colors.white,
                  hintText: 'Enter your address',
                  filled: true,
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Color(0xFFfd2c2c),
                      ),
                      onPressed: () {
                        debugPrint('222');
                      })),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  String productName;
  String productPrice;
  String productImage;
  String productCartQuantity;

  CartItem({
    Key key,
    @required this.productName,
    @required this.productPrice,
    @required this.productImage,
    @required this.productCartQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
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
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                        child: Image.asset(
                      "assets/images/popular_foods/$productImage.png",
                      width: 110,
                      height: 100,
                    )),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "$productName",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                "$productPrice",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/menus/ic_delete.png",
                            width: 25,
                            height: 25,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: AddToCartMenu(2),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class CartIconWithBadge extends StatelessWidget {
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.business_center,
              color: Color(0xFF3a3737),
            ),
            onPressed: () {}),
        counter != 0
            ? Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  int productCounter;

  AddToCartMenu(this.productCounter);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove),
            color: Colors.black,
            iconSize: 18,
          ),
          InkWell(
            onTap: () => print('hello'),
            child: Container(
              width: 100.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Color(0xFFfd2c2c),
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text(
                  'Add To $productCounter',
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Color(0xFFfd2c2c),
            iconSize: 18,
          ),
        ],
      ),
    );
  }
}
