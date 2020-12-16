import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import 'order_model.dart';

class Cart extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<Order> order = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Order> get items => UnmodifiableListView(order);

  /// The current total price of all items
  double get total {
    return order.fold(0.0, (double currentTotal, Order nextProduct) {
      return currentTotal + nextProduct.price;
    });
  }

  /// Adds first items to cart.
  void initializeItem(List<Order> orders) {
    order = orders;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Order item) {
    order.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    order.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// updates the item in the cart.
  void updateItem(List<Order> orders) {
    order.addAll(orders);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify them
  /// Removes all items from the cart.
  void deleteItem(int index) {
    order.removeAt(index);
    notifyListeners();
  }
}

// class CartModels extends ListChangeNotifier<Order> {
//   /// An unmodifiable view of the items in the cart
//   UnmodifiableListView<Item> get items => UnmodifiableListView(this);
//
//   /// The current total price of all items (assuming all items cost $42).
//   int get totalPrice => length * 42;
// }
class Store {
  // Perhaps we're going to use a StreamProvider?
  StreamController<List<Order>> _streamController =
      StreamController<List<Order>>();
  Stream<List<Order>> get allProductsForSale => _streamController.stream;

// rest of class
}
